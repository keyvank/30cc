void fprintf(void *, char *, ...);

extern void *stderr;
extern void *stdout;

int main()
{
    fprintf(stdout, "This is stdout!\n");
    fprintf(stderr, "This is stderr!\n");
    return 0;
}