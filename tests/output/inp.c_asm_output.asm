section .data
__temp_str_0 db `%u `, 0
__temp_str_1 db `%u `, 0
__main_size: equ 160
section .text
extern printf
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
;define variable i
mov rax, 10
mov [rbp-8], rax
;end define variable i
;define variable i
mov rax, 0
mov [rbp-16], rax
;end define variable i
; enter loop
__tmp_label_0:
mov rax, rbp
sub rax, 16
mov [rbp-24], rax
mov rax, [rbp-16]
mov rbx, 5
cmp rax, rbx
jl __tmp_label_2
mov rax, 0
jmp __tmp_label_3
__tmp_label_2:
mov rax, 1
__tmp_label_3:
mov [rbp-40], rax
mov rax, [rbp-40]
cmp rax, 0
je __tmp_label_1
;define variable i
mov rax, 2
mov [rbp-48], rax
;end define variable i
mov rax, __temp_str_0
mov [rbp-56], rax
mov rax, rbp
sub rax, 48
mov [rbp-64], rax
mov rax, [rbp-48]
mov [rbp-72], rax
mov rdi, [rbp-56]
mov rsi, [rbp-72]
mov rax, rbp
sub rax, 8
mov [rbp-80], rax
call printf
mov rax, rbp
sub rax, 16
mov [rbp-48], rax
mov rax, rbp
sub rax, 16
mov [rbp-56], rax
mov rax, [rbp-16]
mov rbx, 1
add rax, rbx
mov [rbp-64], rax
mov rax, [rbp-16]
mov rbx, [rbp-64]
mov rax, [rbp-48]
mov [rax], rbx
mov rax, rbx
mov [rbp-72], rax
jmp __tmp_label_0
__tmp_label_1:
; exit loop
mov rax, __temp_str_1
mov [rbp-16], rax
mov rax, rbp
sub rax, 8
mov [rbp-24], rax
mov rax, [rbp-8]
mov [rbp-32], rax
mov rdi, [rbp-16]
mov rsi, [rbp-32]
mov rax, rbp
sub rax, 8
mov [rbp-40], rax
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
