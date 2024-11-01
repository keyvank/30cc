void printf(char *, ...);

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
    int res_sum = handle(10, 20, sum);
    int res_mul = handle(10, 20, mul);
    printf("%u %u\n", res_sum, res_mul);
}
