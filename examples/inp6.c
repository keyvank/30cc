void printf(char *, ...);
void *malloc(int sz);

typedef struct
{
    int a;
    int b;
    char c;
    char *d;
} MyStruct;

int main()
{
    MyStruct *m = (MyStruct *)malloc(sizeof(MyStruct));
    m->a = 10;
    m->b = 20;
    m->c = 'K';
    m->d = "Salam!";
    printf("%u %u %c %s\n", m->a, m->b, m->c, m->d);
    return 0;
}
