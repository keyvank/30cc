void printf(char *);

struct MyStruct
{
    int a;
    char b;
    int c;
};

int doub(int k)
{
    return k * 2 * k;
}

int main()
{
    int a = 10;
    int b = 20;
    int c = a * b;
    int d = c * (c + a);
    printf("Result: %u\n", c + c + d + ((b + a) * a));
    int *cc = &c;
    printf("Addr of a: %u\n", &a);
    printf("Value of b: %u\n", *(&a + 8));
    printf("Addr of c: %u\n", cc);
    int kk = doub(123);
    printf("Double of 123: %u\n", kk);
    if (100)
    {
        printf("HI\n");
        if (100)
        {
            printf("Hello!\n");
            printf("Heee\n");
        }
    }
}
