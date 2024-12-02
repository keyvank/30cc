void printf(char *, ...);

#define A
#define B
#define C

int main()
{
#ifndef D
#ifdef A
#ifdef B
#ifdef C
    printf("ABC defined!\n");
#endif
    printf("AB defined!\n");
#endif
    printf("A defined!\n");
#endif
    printf("D not defined!\n");
#endif
    return 0;
}
