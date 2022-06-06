static Internal{

    int MEMORY_COMMIT = 0x1000
    int MEMORY_RESERVE = 0x2000
    int MEMORY_RELEASE = 0x8000

    int PAGE_READWRITE = 0x04

    import plain char ptr VirtualAlloc(char ptr Hint, long Size, long Flags, int Protection_Type)

    import plain char ptr VirtualFree(char ptr Hint, long Size, long Flags)

    char ptr Allocate(long Size) {
        return VirtualAlloc(0->address, Size, MEMORY_COMMIT | MEMORY_RESERVE, PAGE_READWRITE)
    }

    char ptr Deallocate(char ptr Address, long Size) {
        return VirtualFree(Address, 0, MEMORY_RELEASE)
    }

}