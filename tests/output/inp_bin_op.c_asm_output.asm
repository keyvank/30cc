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
mov [rbp-8], rax
;end define variable a
;define variable b
mov rax, 3
mov [rbp-16], rax
;end define variable b
mov rax, rbp
sub rax, 8
mov [rbp-24], rax
mov rax, rbp
sub rax, 16
mov [rbp-32], rax
mov rax, [rbp-8]
mov rbx, [rbp-16]
add rax, rbx
mov rbx, [rbp-24]
mov [rbx], rax
mov [rbp-40], rax
mov rax, rbp
sub rax, 8
mov [rbp-48], rax
mov rax, rbp
sub rax, 16
mov [rbp-56], rax
mov rax, [rbp-8]
mov rbx, [rbp-16]
sub rax, rbx
mov rbx, [rbp-48]
mov [rbx], rax
mov [rbp-64], rax
mov rax, rbp
sub rax, 8
mov [rbp-72], rax
mov rax, rbp
sub rax, 16
mov [rbp-80], rax
mov rax, [rbp-16]
mov rbx, 1
add rax, rbx
mov [rbp-88], rax
mov rax, [rbp-8]
mov rbx, [rbp-88]
mul rbx
mov rbx, [rbp-72]
mov [rbx], rax
mov [rbp-96], rax
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
