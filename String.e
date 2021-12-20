static std{
	type String{
		List<char> ptr Characters.List<char>()
	}

	func String.String(char ptr data){
		this.Set(data)
	}

	int String.Size(){
		return this.Characters.Size
	}

	char String.At(int i){
		return this.First()[i]
	}

	char ptr String.Value(){
		return this.First()
	}

	String To_String(int x){
		String Result.String()

		while (1 < 2){
			int Remainder = x % 10
			x = x / 10

			char Digit = Remainder + 48

			Result.Characters.Add(Digit)

			if (x == 0){
				return Result
			}
		}
	}

	int To_Int(String x){
		int Result = 0;
		while (int i = x.Size() -1; i >= 0; i--){
			char Character = x.At(i) - 48

			Result = Result * 10 + Character
		}

		return Result
	}

	bool String.Compare(String y){
		if (this.Size() != y.Size()){
			return false
		}
		while (int i = 0; i < this.Size(); i++){
			if (this.At(i) != y.At(i)){
				return false
			}
		}
		return true
	}

	bool Compare(char ptr x, String y){
		String New_X.String(x)
		return Compare(New_X, y)
	}

	bool String.Compare(char ptr y){
		return Compare(y, this)
	}

	#This append adds to the left side list and then returns it
	#Warning: this function modifies content of 'x'
	func String.Append(String y){
		return Characters.Append<char>(y)
	}

	#This append returns a new combined list
	String Append(String x, String y){
		return Append<char>(x.Characters, y.Characters)
	}

	#this is for the overload of '=' operator
	String String.Set(String value){
		this.Characters.Resize(Max<int>(this.Size(), value.Size()))
		Memcpy<char>(this.First(), value.First(), value.Size())
	}

	String String.Set(char ptr value){
		this.Characters.Resize(Max<int>(this.Size(), value.Size()))
		Memcpy<char>(this.First(), value, value.Size())
	}

	char ptr String.First(){
		return this.Characters.First()
	}
	
	char ptr String.Last(){
		return this.Characters.Last()
	}

}