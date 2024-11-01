void printf(char *, ...);
void *malloc(int sz);

int sum(int a, int b)
{
    return a + b;
}

int mul(int a, int b)
{
    return a * b;
}

int handle(int a, int b, int (*f)(int, int))
{
    return f(a, b);
}

int main()
{
    int (**funcs)(int, int) = (int (**)(int, int))malloc(sizeof(int (*)(int, int)) * 2);
    funcs[0] = sum;
    funcs[1] = mul;

    for (int i = 0; i < 2; i++)
    {
        int res = handle(10, 20, funcs[i]);
        printf("Func #%u result: %u\n", i, res);
    }
}
