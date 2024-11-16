section .data
__printf_size: equ 16
__temp_str_1 db `inside do while\n`, 0
__temp_str_2 db `i %d\n`, 0
__temp_str_3 db `i %d\n`, 0
__main_size: equ 160
section .text
extern printf
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
;define variable i
mov rax, 0
mov [rsp+0], rax
;end define variable i
; enter loop
__tmp_label_0:
mov rax, __temp_str_1
mov [rsp+8], rax
mov rdi, [rsp+8]
mov rax, rsp
add rax, 0
mov [rsp+16], rax
call printf
mov [rsp+24], rax
mov rax, 0
cmp rax, 0
je __tmp_label_1
jmp __tmp_label_0
__tmp_label_1:
; exit loop
; enter loop
__tmp_label_2:
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
mov [rsp+40], rax
; postfix op apply
mov rax, rsp
add rax, 0
mov [rsp+40], rax
mov rax, [rsp+0]
mov [rsp+48], rax
add rax, 1
mov rbx, [rsp+40]
mov [rbx], rax
; postfix op finish
mov rax, rsp
add rax, 0
mov [rsp+8], rax
mov rax, [rsp+0]
mov rbx, 3
cmp rax, rbx
jl __tmp_label_4
mov rax, 0
jmp __tmp_label_5
__tmp_label_4:
mov rax, 1
__tmp_label_5:
mov [rsp+16], rax
mov rax, [rsp+16]
cmp rax, 0
je __tmp_label_3
jmp __tmp_label_2
__tmp_label_3:
; exit loop
; enter loop
__tmp_label_6:
mov rax, rsp
add rax, 0
mov [rsp+24], rax
mov rax, [rsp+0]
mov rbx, 0
cmp rax, rbx
jne __tmp_label_8
mov rax, 0
jmp __tmp_label_9
__tmp_label_8:
mov rax, 1
__tmp_label_9:
mov [rsp+32], rax
mov rax, [rsp+32]
cmp rax, 0
je __tmp_label_7
; postfix op apply
mov rax, rsp
add rax, 0
mov [rsp+40], rax
mov rax, [rsp+0]
mov [rsp+48], rax
sub rax, 1
mov rbx, [rsp+40]
mov [rbx], rax
; postfix op finish
mov rax, __temp_str_3
mov [rsp+56], rax
mov rax, rsp
add rax, 0
mov [rsp+64], rax
mov rax, [rsp+0]
mov [rsp+72], rax
mov rdi, [rsp+56]
mov rsi, [rsp+72]
mov rax, rsp
add rax, 0
mov [rsp+80], rax
call printf
mov [rsp+88], rax
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
