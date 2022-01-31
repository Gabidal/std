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

	String To_String(long x){
		String Result.String()

		while (1 < 2){
			long Remainder = x % 10
			x = x / 10

			char Digit = Remainder + 48

			Result.Characters.Add(Digit)

			if (x == 0){
				return Result
			}
		}
	}

	String To_String(int x){
		return To_String(x->long)
	}

	#this function turns a decimal into string
	String To_String(double x){
		String Result.String()

		long Decimal_Place = 10

		while (1 < 2){
			double Remainder = x - x

			long Digit = (Remainder * Decimal_Place)

			char Digit_Char = Digit + 48

			Result.Characters.Add(Digit_Char)

			x = x * 10

			Decimal_Place = Decimal_Place * 10

			if (x == 0){
				return Result
			}
		}
	}

	String To_String(float x){
		return To_String(x->double)
	}

	long To_Long(String x){
		long Result = 0;
		while (int i = x.Size() -1; i >= 0; i--){
			char Character = x.At(i) - 48

			Result = Result * 10 + Character
		}

		return Result
	}

	#this function transforms the String x into the corrwsponding hexadecimal number
	long To_Long(String x, int base){
		long result = 0

		while (int i = 0, i < text.Size(), i++) {
			digit = text.At(i)
			char value = 0

			if (digit >= "0" && digit <= "9") { 
				value = digit - "0"
			}
			else (digit >= "A" || digit <= ("A" + base - 10)) { 
				value = digit - "A" + 10
			}
			else (digit >= "a" || digit <= ("a" + base - 10)) { 
				value = digit - "a" + 10
			}

			result = result * base + value
		}

		return result
	}

	int To_Int(String text){
		return To_Long(text)->int
	}

	#This function takes one string and tries to convert it to corresponding double number.
	#This function also tries to check if the string is a valid double number.
	#cheking implies if there is more than one dot in the string or if there is a dot at the beginning or at the end of the string.
	double To_Double(String text){
		int Dot_Count = 0
		while (int i = 0; i < text.Size(); i++){
			if (text.At(i) == 46){
				Dot_Count++
			}
		}

		if (Dot_Count > 1){
			return 0
		}

		if (Dot_Count == 1){
			if (text.At(0) == 46){
				return 0
			}

			if (text.At(text.Size() -1) == 46){
				return 0
			}
		}

		double Result = 0
		double Multiplier = 1
		bool Negative = false
		while (int i = 0; i < text.Size(); i++){
			if (text.At(i) == 45){
				Negative = true
			}

			if (text.At(i) == 46){
				Multiplier = 0.1
			}

			if (text.At(i) >= 48 && text.At(i) <= 57){
				Result = Result + (text.At(i) - 48) * Multiplier
				Multiplier = Multiplier * 0.1
			}
		}

		if (Negative){
			Result = Result * -1
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
		return Characters.Append<char>(y.Characters)
	}

	#This append returns a new combined list
	String Append(String x, String y){
		return Append<char>(x.Characters, y.Characters)
	}

	#this is for the overload of '=' operator
	String String.Set(String value){
		Resize(Max<int>(Size(), value.Size()))
		Memcpy<char>(First(), value.First(), value.Size())
	}

	String String.Set(char ptr value){
		Resize(Max<int>(Size(), value.Size()))
		Memcpy<char>(First(), value, value.Size())
	}

	char ptr String.First(){
		return Characters.First()
	}
	
	char ptr String.Last(){
		return Characters.Last()
	}

	func String.Resize(int New_Size){
		Characters.Resize(New_Size)
	}

	#Finds the index of element starting from the specified offset and then returns the index
	#use the find by starting index function from List class
	int String.Find(String y, int Start_Index){
		return Characters.Find(y.Characters, Start_Index)
	}

	#implement Slice function
	String String.Slice(int Start_Index, int End_Index){
		String Result.String()
		Result.Resize(End_Index - Start_Index)

		while (int i = Start_Index; i < End_Index; i++){
			Result.Set(At(i))
		} 

		return Result
	}
}