void printf(char *, ...);
char *malloc(int sz);
int main()
{
    int *a = malloc(10 * 8);
    for (int i = 0; i < 10; i += 1)
        a[i] = 2 * i;
    for (int i = 0; i < 10; i += 1)
        printf("%u\n", a[i]);

    int **b = malloc(1024 * 8);
    int c = 123;
    b[0] = (&c);
    *(b[0]) = *(b[0]) * 2;
    printf("%u\n", c);

    char *str = malloc(20);
    str[0] = 'h';
    str[1] = 'i';
    str[2] = '!';
    str[3] = 0;
    printf("%s\n", str);
}
