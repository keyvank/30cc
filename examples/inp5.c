void printf(char *, ...);
void *malloc(int sz);
int main(int argc, char **argv)
{
    for (int i = 0; i < argc; i += 1)
    {
        printf("Arg %u: %s\n", i, argv[i]);
    }

    int *a = (int *)(malloc(10 * 8));
    for (int i = 0; i < 10; i = i + 1)
        a[i] = 2 * i;
    for (int i = 0; i < 10; i += 1)
        printf("%u\n", a[i]);

    int **b = (int **)(malloc(1024 * 8));
    int c = 123;
    b[0] = (&c);
    *(b[0]) = *(b[0]) * 2;
    printf("%u\n", c);

    char *str = (char *)(malloc(20));
    str[0] = 'h';
    str[1] = 'i';
    str[2] = '!';
    str[3] = '\0';
    printf("%s", str);
}
