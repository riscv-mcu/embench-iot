
// workaround for crt0 required

void exit(int fd)
{
}

void __libc_fini_array(void)
{
}

void __libc_init_array(void)
{
}
