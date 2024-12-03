void printf(char *, ...);

int main() {
    int a = 2;
    int b = 3;
    a += b;
    a -= b;
    a *= b + 1;

    printf("%u\n", 23 % 16);
    printf("%u\n", 19 % 16);
    printf("%u\n", 32 % 16);
    return 0;
}
