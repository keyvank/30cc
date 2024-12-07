void printf(char *, ...);

#define ADD(x, y) (20 + 2 * x + 3 * y)
#define STR(x) #x

int main()
{
    int a = 10;
    int cde = ADD(a, 20);
    char *s = STR(cde);
    printf("%s: %d\n", s, cde);
    return 0;
}