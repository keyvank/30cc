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
jmp __tmp_label_2
__tmp_label_0:
mov rax, rbp
sub rax, 16
mov [rbp-24], rax
mov rax, rbp
sub rax, 16
mov [rbp-32], rax
mov rax, [rbp-16]
mov rbx, 1
add rax, rbx
mov [rbp-40], rax
mov rax, [rbp-16]
mov rbx, [rbp-40]
mov rax, [rbp-24]
mov [rax], rbx
mov rax, rbx
mov [rbp-48], rax
__tmp_label_2:
mov rax, rbp
sub rax, 16
mov [rbp-56], rax
mov rax, [rbp-16]
mov rbx, 5
cmp rax, rbx
jl __tmp_label_3
mov rax, 0
jmp __tmp_label_4
__tmp_label_3:
mov rax, 1
__tmp_label_4:
mov [rbp-72], rax
mov rax, [rbp-72]
cmp rax, 0
je __tmp_label_1
;define variable i
mov rax, 2
mov [rbp-80], rax
;end define variable i
mov rax, __temp_str_0
mov [rbp-88], rax
mov rax, rbp
sub rax, 80
mov [rbp-96], rax
mov rax, [rbp-80]
mov [rbp-104], rax
mov rdi, [rbp-88]
mov rsi, [rbp-104]
mov rax, rbp
sub rax, 8
mov [rbp-112], rax
call printf
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
