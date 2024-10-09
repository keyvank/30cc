void printf(char *);

struct MyStruct
{
    int a;
    char b;
    int c;
};

int doub(int k)
{
    return k * 2;
}

int fact(int a)
{
    printf("Fact: %u\n", a);
    if (a)
    {
        int aa = fact(a - 1);
        return a * aa;
    }
    else
    {
        return 1;
    }
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
    printf("Double of 123: %u\n", doub(doub(123 * doub(123)) * 2) + 10);
    printf("Factorial 5: %u\n", fact(5));
    if (1)
    {
        printf("TRUE\n");
    }
    else
    {
        printf("FALSE\n");
    }
    if (1)
    {
        printf("TRUE\n");
    }
    else
    {
        printf("FALSE\n");
    }
}
