section .data
__temp_str_0 db `cde`, 0
__temp_str_1 db `%s: %d\n`, 0
__main_size: equ 128
section .text
extern printf
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
;define variable a
mov rax, 10
mov [rbp-8], rax
;end define variable a
mov rax, rbp
sub rax, 8
mov [rbp-24], rax
mov rax, 2
mov rbx, [rbp-8]
mul rbx
mov [rbp-32], rax
mov rax, 20
mov rbx, [rbp-32]
add rax, rbx
mov [rbp-40], rax
mov rax, 3
mov rbx, 20
mul rbx
mov [rbp-48], rax
mov rax, [rbp-40]
mov rbx, [rbp-48]
add rax, rbx
mov [rbp-56], rax
;define variable cde
mov rax, [rbp-56]
mov [rbp-16], rax
;end define variable cde
;define variable s
mov rax, __temp_str_0
mov [rbp-64], rax
;end define variable s
mov rax, __temp_str_1
mov [rbp-72], rax
mov rax, rbp
sub rax, 64
mov [rbp-80], rax
mov rax, [rbp-64]
mov [rbp-88], rax
mov rax, rbp
sub rax, 16
mov [rbp-96], rax
mov rax, [rbp-16]
mov [rbp-104], rax
mov rdi, [rbp-72]
mov rsi, [rbp-88]
mov rdx, [rbp-104]
mov rax, rbp
sub rax, 8
mov [rbp-112], rax
call printf
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
