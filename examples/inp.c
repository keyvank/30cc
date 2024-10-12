void printf(char *, ...);
int main()
{
    int i = 10;

    for (int i = 0; i < 5; i = i + 1)
    {
        int i = 2;
        printf("%u ", i);
    }

    printf("%u ", i);
}
