void printf(char *, ...);

int main()
{
    int i = 0;

    do
    {
        printf("inside do while\n");
    } while(0);

    do
    {
        printf("i %d\n", i);
        i++;
    } while(i < 3);

    while (i != 0)
    {
        i--;
        printf("i %d\n", i);
    }

    return 0;
}
