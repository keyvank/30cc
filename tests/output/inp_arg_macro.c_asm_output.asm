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
mov [rsp+0], rax
;end define variable a
mov rax, rsp
add rax, 0
mov [rsp+16], rax
mov rax, 2
mov rbx, [rsp+0]
mul rbx
mov [rsp+24], rax
mov rax, 20
mov rbx, [rsp+24]
add rax, rbx
mov [rsp+32], rax
mov rax, 3
mov rbx, 20
mul rbx
mov [rsp+40], rax
mov rax, [rsp+32]
mov rbx, [rsp+40]
add rax, rbx
mov [rsp+48], rax
;define variable cde
mov rax, [rsp+48]
mov [rsp+8], rax
;end define variable cde
;define variable s
mov rax, __temp_str_0
mov [rsp+56], rax
;end define variable s
mov rax, __temp_str_1
mov [rsp+64], rax
mov rax, rsp
add rax, 56
mov [rsp+72], rax
mov rax, [rsp+56]
mov [rsp+80], rax
mov rax, rsp
add rax, 8
mov [rsp+88], rax
mov rax, [rsp+8]
mov [rsp+96], rax
mov rdi, [rsp+64]
mov rsi, [rsp+80]
mov rdx, [rsp+96]
mov rax, rsp
add rax, 0
mov [rsp+104], rax
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
