void printf(char *, ...);
void *malloc(int sz);

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
    int e;
};

int main()
{
    struct MyStruct m;
    m.c = 5;
    m.d = 10;
    m.hi.e = 19;
    m.hi.f = 123;
    m.e = m.hi.f * 2 + m.c; // 251
    printf("%u %u %u %u %u\n", m.c, m.d, m.hi.e, m.hi.f, m.e);

    int *salam = (int *)malloc(10 * 8);
    salam[5] = 987;
    int *s5 = &salam[5];
    printf("%u\n", *s5);
    
    return 0;
}
