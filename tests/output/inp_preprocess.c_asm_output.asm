section .data
__main_size: equ 16
section .text
extern printf
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
mov rax, 0
mov rsp, rbp
pop rbp
ret
mov rsp, rbp
pop rbp
ret
extern exit
global _start
_start:
; Pass argc and argv
mov rdi, [rsp]
mov rsi, rsp
add rsi, 8
call main
mov rdi, rax
call exit
