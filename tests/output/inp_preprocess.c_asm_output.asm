section .data
__temp_str_0 db `ABC defined!\n`, 0
__temp_str_1 db `AB defined!\n`, 0
__temp_str_2 db `A defined!\n`, 0
__temp_str_3 db `D not defined!\n`, 0
__main_size: equ 80
section .text
extern printf
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
mov rax, __temp_str_0
mov [rbp-8], rax
mov rdi, [rbp-8]
mov rax, rbp
sub rax, 8
mov [rbp-16], rax
call printf
mov rax, __temp_str_1
mov [rbp-24], rax
mov rdi, [rbp-24]
mov rax, rbp
sub rax, 8
mov [rbp-32], rax
call printf
mov rax, __temp_str_2
mov [rbp-40], rax
mov rdi, [rbp-40]
mov rax, rbp
sub rax, 8
mov [rbp-48], rax
call printf
mov rax, __temp_str_3
mov [rbp-56], rax
mov rdi, [rbp-56]
mov rax, rbp
sub rax, 8
mov [rbp-64], rax
call printf
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
