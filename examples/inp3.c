#define SALAM2 110

char c = '\n';

void printf(char *, ...);

struct MyStruct
{
    int **a;
    char b;
    int c;
};

int salam = 52;

int doub(int k)
{
    return k * 2;
}

int fact(int a)
{
    printf("Fact: %u\n", a);
    if (a)
    {
        return a * fact(a - 1);
    }
    else
    {
        return 1;
    }
}

int fibo(int n)
{
    if (n == 0)
    {
        return 1;
    }
    else if (n == 1)
    {
        return 1;
    }
    else
    {
        return fibo(n - 1) + fibo(n - 2);
    }
}

int main()
{
    int i2 = 0;
    while (i2 < 10)
    {
        printf("I: %u\n", i2);
        i2 = i2 + 1;
    }

    printf("%c %c %u", 'a', SALAM2, 'c');
    printf("\n");

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
    printf("%u\n", 5 != 1);

    // Manually printing fibo
    printf("%u ", fibo(0));
    printf("%u ", fibo(1));
    printf("%u ", fibo(2));
    printf("%u ", fibo(3));
    printf("%u ", fibo(4));
    printf("%u ", fibo(5));
    printf("%u ", fibo(6));
    printf("%u ", fibo(7));
    printf("%u\n", fibo(8));

    /*
        Fibo in for loop
    */
    for (int i = 0; i < 20; i = i + 1)
    {
        printf("%u ", fibo(i));
    }
    /* Salam donya! */
    printf("\nDONE!\n");

    printf("%u\n", (1 && 1) && (1 && 1));
}
