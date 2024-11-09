void printf(char *, ...);
void *malloc(int sz);

int main()
{
    int *a = (int *)malloc(10 * sizeof(int));
    for (int i = 0; i < 10; i = i + 1)
        a[i] = 2 * i;

    printf("a[4] %d\n", *(4 + a));

    int i = 0;
    while (i++ < 10) {
        printf("*a: %d\n", *a++);
    }

    printf("*--a %d\n", *--a);
    printf("*--a %d\n", *--a);

    char *s = (char *)malloc(10 * sizeof(char));
    s[0] = '1';
    s[1] = 'h';
    s[2] = 'e';
    s[3] = 'l';
    s[4] = 'l';
    s[5] = 'o';
    s[6] = '\n';
    s[7] = '\0';
    printf("s %c\n", *++s);
    printf("s %s", s);

    int **arr = (int **)malloc(10 * sizeof(int *));
    *arr = (int *)malloc(10 * sizeof(int));
    *(arr + 1) = (int *)malloc(10 * sizeof(int));
    arr[2] = (int *)malloc(10 * sizeof(int));

    arr[0][0] = 69;
    *(arr + 1)[0] = 99;
    *(*(arr + 1) + 1) = 109;

    printf("arr[0][0] %d\n", arr[0][0]);
    printf("arr[1][0] %d\n", *(arr+1)[0]);
    printf("arr[1][1] %d\n", arr[1][1]);

    // Can assign 0 or TODO: null to pointers
    int *b = 0;
    if (b == 0)
        printf("b is null pointer\n");
}
