section .data
__printf_size: equ 16
__temp_str_1 db `i is 0\n`, 0
__temp_str_2 db `i is 0\n`, 0
__temp_str_3 db `i is %d\n`, 0
__temp_str_4 db `j is %d\n`, 0
__main_size: equ 336
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
mov rax, 1
cmp rax, 0
je __tmp_label_1
mov rax, rsp
add rax, 0
mov [rsp+8], rax
mov rax, [rsp+0]
mov rbx, 0
cmp rax, rbx
je __tmp_label_2
mov rax, 0
jmp __tmp_label_3
__tmp_label_2:
mov rax, 1
__tmp_label_3:
mov [rsp+16], rax
mov rax, 0
cmp rax, [rsp+16]
je __tmp_label_4
mov rax, __temp_str_1
mov [rsp+24], rax
mov rdi, [rsp+24]
mov rax, rsp
add rax, 0
mov [rsp+32], rax
call printf
jmp __tmp_label_1
__tmp_label_4:
jmp __tmp_label_1
jmp __tmp_label_0
__tmp_label_1:
; exit loop
;define variable i
mov rax, 0
mov [rsp+8], rax
;end define variable i
; enter loop
__tmp_label_5:
mov rax, rsp
add rax, 8
mov [rsp+16], rax
mov rax, [rsp+8]
mov rbx, 0
cmp rax, rbx
jge __tmp_label_7
mov rax, 0
jmp __tmp_label_8
__tmp_label_7:
mov rax, 1
__tmp_label_8:
mov [rsp+24], rax
mov rax, [rsp+24]
cmp rax, 0
je __tmp_label_6
mov rax, rsp
add rax, 8
mov [rsp+32], rax
mov rax, [rsp+8]
mov rbx, 0
cmp rax, rbx
je __tmp_label_9
mov rax, 0
jmp __tmp_label_10
__tmp_label_9:
mov rax, 1
__tmp_label_10:
mov [rsp+40], rax
mov rax, 0
cmp rax, [rsp+40]
je __tmp_label_11
mov rax, __temp_str_2
mov [rsp+48], rax
mov rdi, [rsp+48]
mov rax, rsp
add rax, 0
mov [rsp+56], rax
call printf
jmp __tmp_label_6
__tmp_label_11:
mov rax, rsp
add rax, 8
mov [rsp+48], rax
mov rax, [rsp+8]
mov rbx, 1
cmp rax, rbx
je __tmp_label_12
mov rax, 0
jmp __tmp_label_13
__tmp_label_12:
mov rax, 1
__tmp_label_13:
mov [rsp+56], rax
mov rax, 0
cmp rax, [rsp+56]
je __tmp_label_14
jmp __tmp_label_6
__tmp_label_14:
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
jmp __tmp_label_5
__tmp_label_6:
; exit loop
;define variable i
mov rax, 0
mov [rsp+8], rax
;end define variable i
; enter loop
__tmp_label_15:
mov rax, rsp
add rax, 8
mov [rsp+16], rax
mov rax, [rsp+8]
mov rbx, 0
cmp rax, rbx
jge __tmp_label_17
mov rax, 0
jmp __tmp_label_18
__tmp_label_17:
mov rax, 1
__tmp_label_18:
mov [rsp+24], rax
mov rax, [rsp+24]
cmp rax, 0
je __tmp_label_16
mov rax, __temp_str_3
mov [rsp+32], rax
mov rax, rsp
add rax, 8
mov [rsp+40], rax
mov rax, [rsp+8]
mov [rsp+48], rax
mov rdi, [rsp+32]
mov rsi, [rsp+48]
mov rax, rsp
add rax, 0
mov [rsp+56], rax
call printf
;define variable j
mov rax, 0
mov [rsp+64], rax
;end define variable j
; enter loop
__tmp_label_19:
mov rax, rsp
add rax, 64
mov [rsp+72], rax
mov rax, [rsp+64]
mov rbx, 10
cmp rax, rbx
jl __tmp_label_21
mov rax, 0
jmp __tmp_label_22
__tmp_label_21:
mov rax, 1
__tmp_label_22:
mov [rsp+80], rax
mov rax, [rsp+80]
cmp rax, 0
je __tmp_label_20
mov rax, __temp_str_4
mov [rsp+88], rax
mov rax, rsp
add rax, 64
mov [rsp+96], rax
mov rax, [rsp+64]
mov [rsp+104], rax
mov rdi, [rsp+88]
mov rsi, [rsp+104]
mov rax, rsp
add rax, 0
mov [rsp+112], rax
call printf
mov rax, rsp
add rax, 64
mov [rsp+120], rax
mov rax, [rsp+64]
mov rbx, 5
cmp rax, rbx
je __tmp_label_23
mov rax, 0
jmp __tmp_label_24
__tmp_label_23:
mov rax, 1
__tmp_label_24:
mov [rsp+128], rax
mov rax, 0
cmp rax, [rsp+128]
je __tmp_label_25
jmp __tmp_label_20
__tmp_label_25:
; postfix op apply
mov rax, rsp
add rax, 64
mov [rsp+88], rax
mov rax, [rsp+64]
mov [rsp+96], rax
add rax, 1
mov rbx, [rsp+88]
mov [rbx], rax
; postfix op finish
jmp __tmp_label_19
__tmp_label_20:
; exit loop
jmp __tmp_label_16
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
jmp __tmp_label_15
__tmp_label_16:
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
