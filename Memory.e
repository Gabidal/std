T ptr Internal_Allocate<T>(int Size){
	return (internal_allocate((Size * T.size)->long)->(char ptr))->(T ptr)
}

T ptr Internal_Allocate<T>(long Size){
	return (internal_allocate(Size * (T.size)->long)->(char ptr))->(T ptr)
}

func Internal_Deallocate<T>(T ptr Address, int Size){
	internal_deallocate(Address->(char ptr), Size->long)
}

func Internal_Deallocate<T>(T ptr Address, long Size){
	internal_deallocate(Address->(char ptr), Size)
}

func Internal_Deallocate<T>(T ptr Address){
	internal_deallocate(Address->(char ptr), Address.size->long)
}

T ptr New<T>(){
	return std.Allocate(T.size)->(T ptr)
}

T ptr New<T>(T ptr This){
	T ptr Substitute = New<T>()
	Substitute[0] = This[0]
	return Substitute
}

func Memcpy<T>(T ptr dest, T ptr source, int Size){
    while (int i = 0, i < Size, i++){
        dest[i] = source[i]
    }
    return
}

static std{
	#This tells how big one Bucket heap is
	int ALLOCATION_SIZE = 700000
	#This is the number of buckets
	int BUCKET_COUNT = 100000

	#This is the buffer that holds the buckets
	char ptr BUCKET_BUFFER = Internal_Allocate<char>(BUCKET_COUNT)

	#This is the start of the bucket heap
	Bucket ptr Bucket_Start = Bucket(BUCKET_BUFFER->(Bucket ptr))

	#This is for speeding up the allocation
	Bucket ptr Bucket_Cache = Bucket_Start

	type Page{
		char ptr Buffer
		int Size
		bool Is_Use
		Page ptr Next
		Bucket ptr Parent
		Page ptr Page_End

		Page ptr Page(Page ptr previus){
			In_Use = false
			previus.Next = this
			Parent = previus.Parent
			#Make this buffer to point to the end of this page
			Buffer = (this->(char ptr) + Page.size)->(char ptr)	

			#Make this to point to the end of the buffer
			Page_End = (Buffer + Size->(char ptr))->(Page ptr)
		}

		Page ptr Page(Bucket ptr parent) {
			Size = 0
			In_Use = false
			Next = 0->address
			Parent = parent

			#Make this buffer to point to the end of this page
			Buffer = (this->(char ptr) + Page.size)->(char ptr)

			#Make this to point to the end of the buffer
			Page_End = (Buffer + Size->(char ptr))->(Page ptr)
		}

		func Update_Page(int size) {
			Size = size
			#Update the page end
			Page_End = (Buffer + Size->(char ptr))->(Page ptr)
		}
	}

	
	type Bucket {
		char ptr Initial_Heap
		int Page_Count = 0
		bool Is_Full
		Page ptr Start
		Page ptr Cache
		Bucket ptr Next
		Bucket ptr Previus
		Bucket ptr Bucket_End

		Bucket ptr Bucket(Bucket ptr previus) {
			#This is the heap that the pages are going to reside in
			Initial_Heap = Internal_Allocate<char>(ALLOCATION_SIZE)

			#This points to the start of the heap
			Start = Page(Initial_Heap->(Page ptr), this)

			#This is for speeding up the allocation
			Cache = Start

			Is_Full = false

			#This makes connections between the buckets to smoothen bucket transistions
			Next = previus.Next
			previus.Next = this
			Previus = previus

			#This makes the bucket end point to the end of the bucket
			Bucket_End = (this->(char ptr) + Bucket.size)->(Bucket ptr)
		}

		Bucket ptr Bucket() {
			#This is the heap that the pages are going to reside in
			Initial_Heap = Internal_Allocate<char ptr>(ALLOCATION_SIZE)

			#This points tot he start of the heap
			Start = Page(Initial_Heap->(Page ptr), this)

			#This is for speeding up the allocation
			Cache = Start

			Is_Full = false

			Next = 0->address

			Previus = 0->address

			#This makes the bucket end point to the end of the bucket
			Bucket_End = (this->(char ptr) + Bucket.size)->(Bucket ptr)
		}

		func Clean() {
			#If the bucket is empty then free it from RAM
			if (Page_Count == 0) {
				Internal_Deallocate<char ptr>(Initial_Heap)

				Cache = Start

				#Make a handshake between the neighbouring buckets
				if (Previus){
					Previus.Next = Next
				}
				if (Next){
					Next.Previus = Previus
				}
			}
		}
	}

	Page ptr Get_Free_Page() {
		#Start from the last empty page
		Page ptr Current = Bucket_Cache.Cache
		#Because Current can be null we have Last to keep track of the last page
		Page ptr Last = Current
		while (Current != 0->address) {
			Last = Current
			#Is the current page is in use then move to the next page
			if (Current.In_Use == true){
				Current = Current.Next
			}
			else {
				#If the page is not in use then return it
				Bucket_Cache.Cache = Current
				return Current
			}
		}

		#This means that the bucket is full
		if (Last.Page_End->(char ptr) >= Last.Parent.Initial_Heap + ALLOCATION_SIZE) {
			Last.Parent.Is_Full = true
			#return a Get_New_Bucket flag
			return 0->address
		}

		#If we get here then we have to allocate a new page
		Page ptr Result = Page(Last.Page_End->(Page ptr), this)
		return Result
	}

	Bucket ptr Get_Free_Bucket() {
		#Start from the last empty bucket
		Bucket ptr Current = Bucket_Cache
		#Because Current can be null we have Last to keep track of the last bucket
		Bucket ptr Last = Current
		while (Current != 0->address) {
			Last = Current
			#Is the current bucket is in use then move to the next bucket
			if (Current.Is_Full){
				Current = Current.Next
			}
			else {
				#If the bucket is not in use then return it
				Bucket_Cache = Current
				return Current
			}
		}

		#Allocate a new bucket
		Bucket ptr Result = Bucket(Last.Bucket_End->(Bucket ptr), this)

		#This makes the allocation faster
		Bucket_Cache = Result

		return Result
	}

	char ptr Allocate(int Size) {
		if (Size > ALLOCATION_SIZE){
			#This means that the allocation is too big
			Page ptr Result = Internal_Allocate<char ptr>(Size + Page.size)
			Result.Page(Bucket_Cache.Cache)
			return Result.Buffer->address
		}

		#If this function return null it means that the we need to allocate a new bucket
		Page ptr New_Page = Get_Free_Page()

		#if New_Page is null this function will return a new Bucket, else it will return cached bucket
		Bucket ptr New_Bucket = Get_Free_Bucket()

		#Now that we have a new page and bucket we need to assign the new page in the new allocated bucket
		if (New_Page == 0->address) {
			New_Page = Get_Free_Page()
		}

		#New that we have a new page, we can assign it to a new heap from the bucket that we have
		New_Page.Update_Page(Size)
		#Tell future users that this page is in use
		New_Page.In_Use = true
		#this will speed up the search for empty buckets
		Bucket_Cache = New_Bucket
		#this will speed up the search for empty pages
		Bucket_Cache.Cache = New_Page
		#tell the Bucket that how close it is to being full
		Bucket_Cache.Page_Count++
		#return the address of the new buffer from page
		return New_Page.Buffer->address
	}

	func Deallocate(char ptr handle) {
		#find the page that contains the buffer
		Page ptr Handle = handle->(Page ptr)
		#tell future users that this page is not in use
		Handle.In_Use = false
		#tell the Get_Free_Page function to use this Page as a future reference point
		Handle.Parent.Cache = Handle
		#tell the Bucket that how close it is to being empty
		Handle.Parent.Page_Count--
		#this speeds up the search for empty buckets
		Handle.Parent.Is_Full = false

		#if the page is empty we can free the allocated heap init.
		Handle.Parent.Clean()
	}
}