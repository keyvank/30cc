void printf(char *, ...);
void *malloc(int sz);

typedef struct
{
    int a;
    int b;
} MyStruct;

int main()
{
    MyStruct *m = (MyStruct *)malloc(sizeof(MyStruct));
    m->a = 10;
    m->b = 20;
    printf("%u %u\n", m->a, m->b);
    return 0;
}
