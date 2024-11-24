section .data
__printf_size: equ 16
__temp_str_1 db `%u `, 0
__temp_str_2 db `%u `, 0
__main_size: equ 144
section .text
extern printf
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
;define variable i
mov rax, 10
mov [rsp+0], rax
;end define variable i
;define variable i
mov rax, 0
mov [rsp+8], rax
;end define variable i
; enter loop
__tmp_label_0:
mov rax, rsp
add rax, 8
mov [rsp+16], rax
mov rax, [rsp+8]
mov rbx, 5
cmp rax, rbx
jl __tmp_label_2
mov rax, 0
jmp __tmp_label_3
__tmp_label_2:
mov rax, 1
__tmp_label_3:
mov [rsp+24], rax
mov rax, [rsp+24]
cmp rax, 0
je __tmp_label_1
;define variable i
mov rax, 2
mov [rsp+32], rax
;end define variable i
mov rax, __temp_str_1
mov [rsp+40], rax
mov rax, rsp
add rax, 32
mov [rsp+48], rax
mov rax, [rsp+32]
mov [rsp+56], rax
mov rdi, [rsp+40]
mov rsi, [rsp+56]
mov rax, rsp
add rax, 0
mov [rsp+64], rax
call printf
mov rax, rsp
add rax, 8
mov [rsp+32], rax
mov rax, rsp
add rax, 8
mov [rsp+40], rax
mov rax, [rsp+8]
mov rbx, 1
add rax, rbx
mov [rsp+48], rax
mov rax, [rsp+8]
mov rbx, [rsp+48]
mov rax, [rsp+32]
mov [rax], rbx
mov [rsp+56], rax
jmp __tmp_label_0
__tmp_label_1:
; exit loop
mov rax, __temp_str_2
mov [rsp+8], rax
mov rax, rsp
add rax, 0
mov [rsp+16], rax
mov rax, [rsp+0]
mov [rsp+24], rax
mov rdi, [rsp+8]
mov rsi, [rsp+24]
mov rax, rsp
add rax, 0
mov [rsp+32], rax
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
