void printf(char *, ...);

// #define A
// #define B
#define C

int main()
{
#ifndef A
#ifndef B
#ifndef C
    printf("C not defined!\n");
#endif
    printf("B not defined!\n");
#endif
    printf("A not defined!\n");
#endif
    return 0;
}
