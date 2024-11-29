section .data
__function2_size: equ 16
__function_size: equ 16
__temp_str_2 db `function: %d\n`, 0
__temp_str_3 db `function2: %d\n`, 0
__main_size: equ 96
section .text
global function2
function2:
push rbp
mov rbp, rsp
sub rsp, __function2_size
mov rax, 13
mov rsp, rbp
pop rbp
ret
mov rsp, rbp
pop rbp
ret
global function
function:
push rbp
mov rbp, rsp
sub rsp, __function_size
mov rax, 69
mov rsp, rbp
pop rbp
ret
mov rsp, rbp
pop rbp
ret
extern printf
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
mov rax, __temp_str_2
mov [rbp-8], rax
mov rax, rbp
sub rax, 8
mov [rbp-16], rax
call function
mov [rbp-24], rax
mov rax, [rbp-24]
mov [rbp-32], rax
mov rdi, [rbp-8]
mov rsi, [rbp-32]
mov rax, rbp
sub rax, 8
mov [rbp-40], rax
call printf
mov rax, __temp_str_3
mov [rbp-48], rax
mov rax, rbp
sub rax, 8
mov [rbp-56], rax
call function2
mov [rbp-64], rax
mov rax, [rbp-64]
mov [rbp-72], rax
mov rdi, [rbp-48]
mov rsi, [rbp-72]
mov rax, rbp
sub rax, 8
mov [rbp-80], rax
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
