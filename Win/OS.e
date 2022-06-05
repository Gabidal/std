
#usage: Link with the Kernel32.lib
static Win{

    import plain char ptr internal_allocate(long Size);

    import plain func internal_deallocate(char ptr Ptr, long Size);

}