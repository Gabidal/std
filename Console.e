static std{

    static Read{

        type Console_Read_Buffer{
            size = 4096
        }

        String ptr Line(){
            Console_Read_Buffer Buffer

            long Size = Internal.Read(Buffer->char, Console_Read_Buffer.size) - 2

            if (Size <= 0){

                return 0->address

            }

            String ptr Result.String(Buffer->char, Size)

            return Result
        }

    }

    static Write{

        func Line(String Text){

            Internal.Write(Text.First(), Text.Size())

        }

        func Line(char ptr Data, int Size){
                
            Internal.Write(Data, Size)
    
        }

        func Line(long Value){

            String Text = To_String(Value)

            Internal.Write(Text.First(), Text.Size())

        }

    }

    

}