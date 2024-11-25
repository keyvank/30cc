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
mov rax, rsp
add rax, 0
mov [rsp+0], rax
mov rax, [stdout]
mov [rsp+8], rax
mov rax, __temp_str_0
mov [rsp+16], rax
mov rdi, [rsp+8]
mov rsi, [rsp+16]
mov rax, rsp
add rax, 0
mov [rsp+24], rax
call fprintf
mov rax, rsp
add rax, 0
mov [rsp+32], rax
mov rax, [stderr]
mov [rsp+40], rax
mov rax, __temp_str_1
mov [rsp+48], rax
mov rdi, [rsp+40]
mov rsi, [rsp+48]
mov rax, rsp
add rax, 0
mov [rsp+56], rax
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
