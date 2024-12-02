void printf(char *, ...);

#define A
#define B
#define C

int main()
{
#ifdef _30CC
    printf("30CC is compiling this!\n");
#endif

#ifndef _30CC
    printf("GCC is compiling this!\n");
#endif

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
