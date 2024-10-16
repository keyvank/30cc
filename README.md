# 30 C Compiler!

`30cc` (Pronounced as *CCC*, because in the Persian language, the number 30 is pronounced as C) is a toy C compiler written in C, with the goal of being able to compile itself 🤝 This is my first attempt in writing a self-hosting software! What is a self-hosting software?

- Imagine `30cc` gets strong enough to be able to compile itself.
- I will first compile `30cc` with `gcc` to get the `30cc` compiler's binary.
- I will then use the `gcc`-generated `30cc` binary file to compile the `30cc` again.
- I now have a `30cc`-compiled version of `30cc`, which I can use for further developing the compiler!
- I can forget about `gcc`, as if it never existed! Beautiful hah? `30cc` is now all alive by itself!

`30cc` emits x86-64 assembly as its output. The outputs are totally unoptimized, but that's fine, the project aims to be educational.

Currently, this is the most complicated code `30cc` is able to successfully parse and compile:

```c
void printf(char *);

struct MyStruct
{
    int a;
    char b;
    int c;
};

int doub(int k)
{
    return k * 2;
}

int fact(int a)
{
    printf("Fact: %u\n", a);
    if (a)
    {
        return a * fact(a - 1);
    }
    else
    {
        return 1;
    }
}

int fibo(int n)
{
    if (n == 0)
    {
        return 1;
    }
    else if (n == 1)
    {
        return 1;
    }
    else
    {
        return fibo(n - 1) + fibo(n - 2);
    }
}

int main()
{
    int a = 10;
    int b = 20;
    int c = a * b;
    int d = c * (c + a);
    printf("Result: %u\n", c + c + d + ((b + a) * a));
    int *cc = &c;
    printf("Addr of a: %u\n", &a);
    printf("Value of b: %u\n", *(&a + 8));
    printf("Addr of c: %u\n", cc);
    printf("Double of 123: %u\n", doub(doub(123 * doub(123)) * 2) + 10);
    printf("Factorial 5: %u\n", fact(5));
    if (1)
    {
        printf("TRUE\n");
    }
    else
    {
        printf("FALSE\n");
    }
    if (1)
    {
        printf("TRUE\n");
    }
    else
    {
        printf("FALSE\n");
    }
    printf("%u\n", 5 != 1);


    // Manually printing fibo
    printf("%u ", fibo(0));
    printf("%u ", fibo(1));
    printf("%u ", fibo(2));
    printf("%u ", fibo(3));
    printf("%u ", fibo(4));
    printf("%u ", fibo(5));
    printf("%u ", fibo(6));
    printf("%u ", fibo(7));
    printf("%u\n", fibo(8));
    
    /*
        Fibo in for loop
    */
    for (int i = 0; i < 20; i = i + 1)
    {
        printf("%u ", fibo(i));
    }
    /* Salam donya! */
    printf("\nDONE!\n");
}
```

## Usage

- First build the compiler using `gcc` by running: `make`
- Compile to NASM x86-64 assembly: `./a.out INP_FILE.c --asm > out.asm`
- Assemble with NASM: `nasm -f elf64 out.asm -o out.o`
- Link with the C standard-library: `ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 -lc -o out out.o`
- Run the output: `./out`

## Contribute

The missing parts are:

- [ ] `#include` macro.
- [ ] `#ifdef`, `#define` and `#ifndef` macros.
- [ ] Field-access in structs (The `.` and `->` operators)
- [ ] Type-checker
- [ ] Some binary expressions (`+=`, `-=`, `*=`)
- [ ] Unary expressions (`++`, `--`, `-`, `!`)
