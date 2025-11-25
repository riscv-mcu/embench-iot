
// workaround for crt0 required

// The property of the 'exit' function is' noreturn '. When the implementation
// is empty, the 'exit' function segment will overlap with another function
// segment, resulting in a circular function call. However, it is difficult to
// view during disassembly
void exit(int fd)
{
  exit(fd);
}

void __libc_fini_array(void)
{
}

void __libc_init_array(void)
{
}
