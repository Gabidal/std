static std{

	long MAX_CONSOLE_BUFFER_LENGHT = 4096

	func Print(String x){
		internal_print(x.Value(), x.Size()->long)
	}

	String Read(){
		String Result.String()

		Result.Resize(MAX_CONSOLE_BUFFER_LENGHT)

		Result.Characters.Size = internal_read(Result.First(), MAX_CONSOLE_BUFFER_LENGHT)
		
		return Result
	}

}