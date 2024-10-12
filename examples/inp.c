void printf(char *, ...);

int main()
{
    int a = 123;
    {
        int a = 234;
        {
            int a = 345;
            printf("%u ", a);
        }
        printf("%u ", a);
    }
    printf("%u ", a);
    int a = 456;
    printf("%u ", a);
}
