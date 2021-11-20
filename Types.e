type char{
	size = 1

	#Go thourgh the list of characters until met null character
	int Size(){
		int i
		while(i = 0; this[i] != "\0"; i++){}
		return i
	}
}

type bool{
	size = 1
}

type short{
	size = 2
}

type int{
	size = 4
}

type long{
	size = 8
}

type float{
	size = 4
	format = decimal
}

type double{
	size = 8
	format = decimal
}