section .data
__temp_str_0 db `This is stdout!\n`, 0
__temp_str_1 db `This is stderr!\n`, 0
__main_size: equ 80
section .text
extern stderr
extern stdout
extern fprintf
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
mov rax, rbp
sub rax, 8
mov [rbp-8], rax
mov rax, [stdout]
mov [rbp-16], rax
mov rax, __temp_str_0
mov [rbp-24], rax
mov rdi, [rbp-16]
mov rsi, [rbp-24]
mov rax, rbp
sub rax, 8
mov [rbp-32], rax
call fprintf
mov rax, rbp
sub rax, 8
mov [rbp-40], rax
mov rax, [stderr]
mov [rbp-48], rax
mov rax, __temp_str_1
mov [rbp-56], rax
mov rdi, [rbp-48]
mov rsi, [rbp-56]
mov rax, rbp
sub rax, 8
mov [rbp-64], rax
call fprintf
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
