#include <stdio.h>

int main()
{
    printf("global _start\n");
    printf("section .text\n");
    printf("_start:\n");
    printf("mov rax, 60\n");
    printf("mov rdi, 0\n");
    printf("syscall\n");
    return 0;
}