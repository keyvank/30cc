#include <stdio.h>

int main()
{
    printf("global _start\n");
    printf("section .text\n");
    printf("_start:\n");
    printf("push dword 1\n");
    printf("push dword 2\n");
    printf("push dword 3\n");
    printf("push dword 4\n");
    printf("push dword 5\n");
    printf("mov rax, 60\n");
    printf("mov rdi, [rsp+16]\n");
    printf("syscall\n");
    return 0;
}