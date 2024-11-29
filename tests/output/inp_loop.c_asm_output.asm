section .data
__temp_str_0 db `inside do while\n`, 0
__temp_str_1 db `i %d\n`, 0
__temp_str_2 db `i %d\n`, 0
__main_size: equ 176
section .text
extern printf
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
;define variable i
mov rax, 0
mov [rbp-8], rax
;end define variable i
; enter loop
__tmp_label_0:
mov rax, __temp_str_0
mov [rbp-16], rax
mov rdi, [rbp-16]
mov rax, rbp
sub rax, 8
mov [rbp-24], rax
call printf
mov rax, 0
cmp rax, 0
je __tmp_label_1
jmp __tmp_label_0
__tmp_label_1:
; exit loop
; enter loop
__tmp_label_2:
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
; postfix op apply
mov rax, rbp
sub rax, 8
mov [rbp-48], rax
mov rax, [rbp-8]
mov [rbp-56], rax
add rax, 1
mov rbx, [rbp-48]
mov [rbx], rax
; postfix op finish
mov rax, rbp
sub rax, 8
mov [rbp-16], rax
mov rax, [rbp-8]
mov rbx, 3
cmp rax, rbx
jl __tmp_label_4
mov rax, 0
jmp __tmp_label_5
__tmp_label_4:
mov rax, 1
__tmp_label_5:
mov [rbp-32], rax
mov rax, [rbp-32]
cmp rax, 0
je __tmp_label_3
jmp __tmp_label_2
__tmp_label_3:
; exit loop
; enter loop
__tmp_label_6:
mov rax, rbp
sub rax, 8
mov [rbp-40], rax
mov rax, [rbp-8]
mov rbx, 0
cmp rax, rbx
jne __tmp_label_8
mov rax, 0
jmp __tmp_label_9
__tmp_label_8:
mov rax, 1
__tmp_label_9:
mov [rbp-56], rax
mov rax, [rbp-56]
cmp rax, 0
je __tmp_label_7
; postfix op apply
mov rax, rbp
sub rax, 8
mov [rbp-64], rax
mov rax, [rbp-8]
mov [rbp-72], rax
sub rax, 1
mov rbx, [rbp-64]
mov [rbx], rax
; postfix op finish
mov rax, __temp_str_2
mov [rbp-80], rax
mov rax, rbp
sub rax, 8
mov [rbp-88], rax
mov rax, [rbp-8]
mov [rbp-96], rax
mov rdi, [rbp-80]
mov rsi, [rbp-96]
mov rax, rbp
sub rax, 8
mov [rbp-104], rax
call printf
jmp __tmp_label_6
__tmp_label_7:
; exit loop
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
