void printf(char *);

int main()
{
    int a = 10;
    int b = 20;
    int c = a * b;
    int d = c * (c + a);
    printf("Result: %u\n", c + c + d + ((b + a) * a));
    int *cc = &a;
    printf("Addr of a: %u\n", &a);
    printf("Addr of b: %u\n", *(&a + 8));
    printf("Addr of a: %u\n", cc);
}
