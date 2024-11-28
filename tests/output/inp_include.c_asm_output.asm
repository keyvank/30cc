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
mov [rsp+0], rax
mov rax, rsp
add rax, 0
mov [rsp+8], rax
call function
mov [rsp+16], rax
mov rax, [rsp+16]
mov [rsp+24], rax
mov rdi, [rsp+0]
mov rsi, [rsp+24]
mov rax, rsp
add rax, 0
mov [rsp+32], rax
call printf
mov rax, __temp_str_3
mov [rsp+40], rax
mov rax, rsp
add rax, 0
mov [rsp+48], rax
call function2
mov [rsp+56], rax
mov rax, [rsp+56]
mov [rsp+64], rax
mov rdi, [rsp+40]
mov rsi, [rsp+64]
mov rax, rsp
add rax, 0
mov [rsp+72], rax
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
