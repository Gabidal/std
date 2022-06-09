static Internal{

	int STANDARD_OUTPUT_HANDLE = -11
	int STANDARD_INPUT_HANDLE = -10

	import plain long GetStdHandle(long Handle)

	import plain bool WriteFile(long Handle, char ptr Buffer, long Size, long ptr Written, long ptr Overlapped)

	import plain bool ReadConsoleA(long Handle, char ptr Buffer, long Size, long ptr Read, long ptr Overlapped)

	func Write(char ptr Data, long Size) {
		long Written = 0

		long Handle = GetStdHandle(STANDARD_OUTPUT_HANDLE)

		WriteFile(Handle, Data, Size, Written, 0->address)
	}

	#Returns the size of the readed size
	func Read(char ptr Result, long Size) {
		long Read = 0

		long Handle = GetStdHandle(STANDARD_INPUT_HANDLE)

		ReadConsoleA(Handle, Result, Size, Read, 0->address)

		return Read
	}

}