void printf(char *, ...);
char *malloc(int sz);
int main()
{
    int a[10];
    for (int i = 0; i < 10; i = i + 1)
        a[i] = 2 * i;
    for (int i = 0; i < 10; i = i + 1)
        printf("%u\n", a[i]);

    int *b[1024];
    int c = 123;
    b[0] = (&c);
    *(b[0]) = *(b[0]) * 2;
    printf("%u\n", c);
}
