# 30 C Compiler!

`30cc` (Pronounced as *CCC*, because in the Persian language, the number 30 is pronounced as C) is a toy C compiler written in C, with the goal of being able to compile itself 🤝 This is my first attempt in writing a self-hosting software! What is a self-hosting software?

- Imagine `30cc` gets strong enough to be able to compile itself.
- I will first compile `30cc` with `gcc` to get the `30cc` compiler's binary.
- I will then use the `gcc`-generated `30cc` binary file to compile the `30cc` again.
- I now have a `30cc`-compiled version of `30cc`, which I can use for further developing the compiler!
- I can forget about `gcc`, as if it never existed! Beautiful hah? `30cc` is now all alive by itself!

`30cc` emits x86-64 assembly as its output. The outputs are totally unoptimized, but that's fine, the project aims to be educational.

Currently, this is the most complicated code `30cc` is able to successfully parse and compile a simple implementation of a linked-list:

```c
void *malloc(int sz);
void printf(char *s, ...);

struct node
{
    int val;
    void *next;
};

struct linked_list
{
    struct node *first;
};

struct linked_list *new_list()
{
    struct linked_list *ret = (struct linked_list *)malloc(8);
    return ret;
}

void add_val(struct linked_list *lst, int val)
{
    struct node *new = (struct node *)malloc(16);
    *((int *)(&new->next)) = new;
    new->val = val;
    if (lst->first)
    {
        struct node *curr = lst->first;
        while (curr->next)
        {
            curr = (struct node *)curr->next;
        }
        curr->next = (void *)new;
    }
    else
    {
        lst->first = new;
    }
}

int main()
{
    struct linked_list *lst = new_list();
    add_val(lst, 123);
    add_val(lst, 432);
    add_val(lst, 999);
    add_val(lst, 873);
    struct node *curr = lst->first;
    while (curr)
    {
        printf("%u\n", curr->val);
        curr = (struct node *)curr->next;
    }
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
- [ ] Pointer-integer addition (Based on the type-size)
