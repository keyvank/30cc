section .data
__main_size: equ 112
section .text
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
;define variable a
mov rax, 2
mov [rsp+0], rax
;end define variable a
;define variable b
mov rax, 3
mov [rsp+8], rax
;end define variable b
mov rax, rsp
add rax, 0
mov [rsp+16], rax
mov rax, rsp
add rax, 8
mov [rsp+24], rax
mov rax, [rsp+0]
mov rbx, [rsp+8]
add rax, rbx
mov rbx, [rsp+16]
mov [rbx], rax
mov [rsp+32], rax
mov rax, rsp
add rax, 0
mov [rsp+40], rax
mov rax, rsp
add rax, 8
mov [rsp+48], rax
mov rax, [rsp+0]
mov rbx, [rsp+8]
sub rax, rbx
mov rbx, [rsp+40]
mov [rbx], rax
mov [rsp+56], rax
mov rax, rsp
add rax, 0
mov [rsp+64], rax
mov rax, rsp
add rax, 8
mov [rsp+72], rax
mov rax, [rsp+8]
mov rbx, 1
add rax, rbx
mov [rsp+80], rax
mov rax, [rsp+0]
mov rbx, [rsp+80]
mul rbx
mov rbx, [rsp+64]
mov [rbx], rax
mov [rsp+88], rax
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