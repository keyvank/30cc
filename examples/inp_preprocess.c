void printf(char *, ...);

#define DEBUG

int main()
{
#ifndef DEBUG
    printf("Debug disabled!\n");
#endif
    return 0;
}
