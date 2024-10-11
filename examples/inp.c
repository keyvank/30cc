void printf(char *, ...);

int main()
{
    int a = 10 > 5 ? 10 + 3 : 3;
    int b = 10 < 5 ? 10 + 3 : 3;
    printf("Res: %u %u\n", a, b);
}