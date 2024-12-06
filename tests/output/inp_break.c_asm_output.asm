section .data
__temp_str_0 db `i is 0\n`, 0
__temp_str_1 db `i is 0\n`, 0
__temp_str_2 db `i is %d\n`, 0
__temp_str_3 db `j is %d\n`, 0
__main_size: equ 480
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
mov rax, 1
cmp rax, 0
je __tmp_label_1
mov rax, rbp
sub rax, 8
mov [rbp-16], rax
mov rax, [rbp-8]
mov rbx, 0
cmp rax, rbx
je __tmp_label_2
mov rax, 0
jmp __tmp_label_3
__tmp_label_2:
mov rax, 1
__tmp_label_3:
mov [rbp-40], rax
mov rax, 0
cmp rax, [rbp-40]
je __tmp_label_4
mov rax, __temp_str_0
mov [rbp-48], rax
mov rdi, [rbp-48]
mov rax, rbp
sub rax, 8
mov [rbp-56], rax
call printf
jmp __tmp_label_1
__tmp_label_4:
jmp __tmp_label_0
jmp __tmp_label_0
__tmp_label_1:
; exit loop
;define variable i
mov rax, 0
mov [rbp-16], rax
;end define variable i
; enter loop
__tmp_label_5:
mov rax, rbp
sub rax, 16
mov [rbp-24], rax
mov rax, [rbp-16]
mov rbx, 0
cmp rax, rbx
jge __tmp_label_7
mov rax, 0
jmp __tmp_label_8
__tmp_label_7:
mov rax, 1
__tmp_label_8:
mov [rbp-48], rax
mov rax, [rbp-48]
cmp rax, 0
je __tmp_label_6
mov rax, rbp
sub rax, 16
mov [rbp-56], rax
mov rax, [rbp-16]
mov rbx, 0
cmp rax, rbx
je __tmp_label_9
mov rax, 0
jmp __tmp_label_10
__tmp_label_9:
mov rax, 1
__tmp_label_10:
mov [rbp-80], rax
mov rax, 0
cmp rax, [rbp-80]
je __tmp_label_11
mov rax, __temp_str_1
mov [rbp-88], rax
mov rdi, [rbp-88]
mov rax, rbp
sub rax, 8
mov [rbp-96], rax
call printf
__tmp_label_11:
mov rax, rbp
sub rax, 16
mov [rbp-88], rax
mov rax, [rbp-16]
mov rbx, 1
cmp rax, rbx
je __tmp_label_12
mov rax, 0
jmp __tmp_label_13
__tmp_label_12:
mov rax, 1
__tmp_label_13:
mov [rbp-112], rax
mov rax, 0
cmp rax, [rbp-112]
je __tmp_label_14
jmp __tmp_label_6
__tmp_label_14:
mov rax, rbp
sub rax, 16
mov [rbp-56], rax
mov rax, rbp
sub rax, 16
mov [rbp-64], rax
mov rax, [rbp-16]
mov rbx, 1
add rax, rbx
mov [rbp-80], rax
mov rax, [rbp-16]
mov rbx, [rbp-80]
mov rax, [rbp-56]
mov [rax], rbx
mov rax, rbx
mov [rbp-96], rax
jmp __tmp_label_5
__tmp_label_6:
; exit loop
;define variable i
mov rax, 0
mov [rbp-16], rax
;end define variable i
; enter loop
__tmp_label_15:
mov rax, rbp
sub rax, 16
mov [rbp-24], rax
mov rax, [rbp-16]
mov rbx, 10
cmp rax, rbx
jle __tmp_label_17
mov rax, 0
jmp __tmp_label_18
__tmp_label_17:
mov rax, 1
__tmp_label_18:
mov [rbp-48], rax
mov rax, [rbp-48]
cmp rax, 0
je __tmp_label_16
mov rax, __temp_str_2
mov [rbp-56], rax
mov rax, rbp
sub rax, 16
mov [rbp-64], rax
mov rax, [rbp-16]
mov [rbp-72], rax
mov rdi, [rbp-56]
mov rsi, [rbp-72]
mov rax, rbp
sub rax, 8
mov [rbp-80], rax
call printf
;define variable j
mov rax, 0
mov [rbp-88], rax
;end define variable j
; enter loop
__tmp_label_19:
mov rax, rbp
sub rax, 88
mov [rbp-96], rax
mov rax, [rbp-88]
mov rbx, 10
cmp rax, rbx
jl __tmp_label_21
mov rax, 0
jmp __tmp_label_22
__tmp_label_21:
mov rax, 1
__tmp_label_22:
mov [rbp-120], rax
mov rax, [rbp-120]
cmp rax, 0
je __tmp_label_20
mov rax, __temp_str_3
mov [rbp-128], rax
mov rax, rbp
sub rax, 88
mov [rbp-136], rax
mov rax, [rbp-88]
mov [rbp-144], rax
mov rdi, [rbp-128]
mov rsi, [rbp-144]
mov rax, rbp
sub rax, 8
mov [rbp-152], rax
call printf
mov rax, rbp
sub rax, 88
mov [rbp-160], rax
mov rax, [rbp-88]
mov rbx, 5
cmp rax, rbx
je __tmp_label_23
mov rax, 0
jmp __tmp_label_24
__tmp_label_23:
mov rax, 1
__tmp_label_24:
mov [rbp-184], rax
mov rax, 0
cmp rax, [rbp-184]
je __tmp_label_25
jmp __tmp_label_20
__tmp_label_25:
; postfix op apply
mov rax, rbp
sub rax, 88
mov [rbp-128], rax
mov rax, [rbp-88]
mov [rbp-136], rax
add rax, 1
mov rbx, [rbp-128]
mov [rbx], rax
; postfix op finish
jmp __tmp_label_19
__tmp_label_20:
; exit loop
mov rax, rbp
sub rax, 16
mov [rbp-56], rax
mov rax, rbp
sub rax, 16
mov [rbp-64], rax
mov rax, [rbp-16]
mov rbx, 1
add rax, rbx
mov [rbp-80], rax
mov rax, [rbp-16]
mov rbx, [rbp-80]
mov rax, [rbp-56]
mov [rax], rbx
mov rax, rbx
mov [rbp-96], rax
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
