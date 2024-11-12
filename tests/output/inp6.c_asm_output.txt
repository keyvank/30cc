section .data
__printf_size: equ 16
__malloc_size: equ 16
__temp_str_2 db `%u %u\n`, 0
__main_size: equ 192
section .text
extern printf
extern malloc
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
mov rax, 16
mov [rsp+8], rax
mov rdi, [rsp+8]
mov rax, rsp
add rax, 0
mov [rsp+16], rax
call malloc
mov [rsp+24], rax
;define variable m
mov rax, [rsp+24]
mov [rsp+0], rax
;end define variable m
mov rax, rsp
add rax, 0
mov [rsp+32], rax
;;;
mov rax, [rsp+0]
add rax, 0
mov [rsp+40], rax
mov rax, [rax]
mov [rsp+48], rax
;;;
mov rax, [rsp+48]
mov rbx, 10
mov rax, 10
mov rbx, [rsp+40]
mov [rbx], rax
mov [rsp+56], rax
mov rax, rsp
add rax, 0
mov [rsp+64], rax
;;;
mov rax, [rsp+0]
add rax, 8
mov [rsp+72], rax
mov rax, [rax]
mov [rsp+80], rax
;;;
mov rax, [rsp+80]
mov rbx, 20
mov rax, 20
mov rbx, [rsp+72]
mov [rbx], rax
mov [rsp+88], rax
mov rax, __temp_str_2
mov [rsp+96], rax
mov rax, rsp
add rax, 0
mov [rsp+104], rax
;;;
mov rax, [rsp+0]
add rax, 0
mov [rsp+112], rax
mov rax, [rax]
mov [rsp+120], rax
;;;
mov rax, [rsp+120]
mov [rsp+128], rax
mov rax, rsp
add rax, 0
mov [rsp+136], rax
;;;
mov rax, [rsp+0]
add rax, 8
mov [rsp+144], rax
mov rax, [rax]
mov [rsp+152], rax
;;;
mov rax, [rsp+152]
mov [rsp+160], rax
mov rdi, [rsp+96]
mov rsi, [rsp+128]
mov rdx, [rsp+160]
mov rax, rsp
add rax, 0
mov [rsp+168], rax
call printf
mov [rsp+176], rax
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
