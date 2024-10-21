void printf(char *, ...);
void *malloc(int sz);

struct MyStruct
{
    int a;
    int b;
};

int main()
{
    struct MyStruct *m = (struct MyStruct *)malloc(sizeof(struct MyStruct));
    m->a=10;
    m->b=20;
    printf("%u %u\n", m->a, m->b);
    return 0;
}
