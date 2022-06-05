#usage: Link with the Kernel32.lib
import plain char ptr internal_allocate(long Size);

import plain func internal_deallocate(char ptr Ptr, long Size);

import plain func internal_print(char ptr Ptr, long Size);

import plain long internal_read(char ptr Buffer, long Max_Read_Lenght);