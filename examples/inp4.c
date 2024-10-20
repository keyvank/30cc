struct MyStruct2
{
    int e;
    int f;
};

struct MyStruct
{
    int c;
    int d;
    struct MyStruct2 hi;
    char e;
};

int main()
{
    struct MyStruct m;
    return 0;
}
