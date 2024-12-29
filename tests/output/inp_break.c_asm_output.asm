section .data
__temp_str_0 db `i is 0\n`, 0
__temp_str_1 db `i is %d\n`, 0
__temp_str_2 db `i is 0\n`, 0
__temp_str_3 db `i is %d\n`, 0
__temp_str_4 db `j is %d\n`, 0
__main_size: equ 496
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
mov [rbp-32], rax
mov rax, 0
cmp rax, [rbp-32]
je __tmp_label_4
mov rax, __temp_str_0
mov [rbp-40], rax
mov rdi, [rbp-40]
mov rax, rbp
sub rax, 8
mov [rbp-48], rax
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
jmp __tmp_label_7
__tmp_label_5:
; unary op apply
mov rax, rbp
sub rax, 16
mov [rbp-24], rax
; operand code: [rbp-16]
mov rax, [rbp-16]
add rax, 1
mov rbx, [rbp-24]
mov [rbx], rax
mov [rbp-32], rax
; unary op finish
__tmp_label_7:
mov rax, rbp
sub rax, 16
mov [rbp-40], rax
mov rax, [rbp-16]
mov rbx, 3
cmp rax, rbx
jl __tmp_label_8
mov rax, 0
jmp __tmp_label_9
__tmp_label_8:
mov rax, 1
__tmp_label_9:
mov [rbp-56], rax
mov rax, [rbp-56]
cmp rax, 0
je __tmp_label_6
mov rax, rbp
sub rax, 16
mov [rbp-64], rax
mov rax, [rbp-16]
mov rbx, 1
cmp rax, rbx
je __tmp_label_10
mov rax, 0
jmp __tmp_label_11
__tmp_label_10:
mov rax, 1
__tmp_label_11:
mov [rbp-80], rax
mov rax, 0
cmp rax, [rbp-80]
je __tmp_label_12
jmp __tmp_label_5
__tmp_label_12:
mov rax, __temp_str_1
mov [rbp-88], rax
mov rax, rbp
sub rax, 16
mov [rbp-96], rax
mov rax, [rbp-16]
mov [rbp-104], rax
mov rdi, [rbp-88]
mov rsi, [rbp-104]
mov rax, rbp
sub rax, 8
mov [rbp-112], rax
call printf
jmp __tmp_label_5
__tmp_label_6:
; exit loop
;define variable i
mov rax, 0
mov [rbp-16], rax
;end define variable i
; enter loop
jmp __tmp_label_15
__tmp_label_13:
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
__tmp_label_15:
mov rax, rbp
sub rax, 16
mov [rbp-56], rax
mov rax, [rbp-16]
mov rbx, 0
cmp rax, rbx
jge __tmp_label_16
mov rax, 0
jmp __tmp_label_17
__tmp_label_16:
mov rax, 1
__tmp_label_17:
mov [rbp-72], rax
mov rax, [rbp-72]
cmp rax, 0
je __tmp_label_14
mov rax, rbp
sub rax, 16
mov [rbp-80], rax
mov rax, [rbp-16]
mov rbx, 0
cmp rax, rbx
je __tmp_label_18
mov rax, 0
jmp __tmp_label_19
__tmp_label_18:
mov rax, 1
__tmp_label_19:
mov [rbp-96], rax
mov rax, 0
cmp rax, [rbp-96]
je __tmp_label_20
mov rax, __temp_str_2
mov [rbp-104], rax
mov rdi, [rbp-104]
mov rax, rbp
sub rax, 8
mov [rbp-112], rax
call printf
__tmp_label_20:
mov rax, rbp
sub rax, 16
mov [rbp-104], rax
mov rax, [rbp-16]
mov rbx, 1
cmp rax, rbx
je __tmp_label_21
mov rax, 0
jmp __tmp_label_22
__tmp_label_21:
mov rax, 1
__tmp_label_22:
mov [rbp-120], rax
mov rax, 0
cmp rax, [rbp-120]
je __tmp_label_23
jmp __tmp_label_14
__tmp_label_23:
jmp __tmp_label_13
__tmp_label_14:
; exit loop
;define variable i
mov rax, 0
mov [rbp-16], rax
;end define variable i
; enter loop
jmp __tmp_label_26
__tmp_label_24:
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
__tmp_label_26:
mov rax, rbp
sub rax, 16
mov [rbp-56], rax
mov rax, [rbp-16]
mov rbx, 10
cmp rax, rbx
jle __tmp_label_27
mov rax, 0
jmp __tmp_label_28
__tmp_label_27:
mov rax, 1
__tmp_label_28:
mov [rbp-72], rax
mov rax, [rbp-72]
cmp rax, 0
je __tmp_label_25
mov rax, __temp_str_3
mov [rbp-80], rax
mov rax, rbp
sub rax, 16
mov [rbp-88], rax
mov rax, [rbp-16]
mov [rbp-96], rax
mov rdi, [rbp-80]
mov rsi, [rbp-96]
mov rax, rbp
sub rax, 8
mov [rbp-104], rax
call printf
;define variable j
mov rax, 0
mov [rbp-112], rax
;end define variable j
; enter loop
jmp __tmp_label_31
__tmp_label_29:
; postfix op apply
mov rax, rbp
sub rax, 112
mov [rbp-120], rax
mov rax, [rbp-112]
mov [rbp-128], rax
add rax, 1
mov rbx, [rbp-120]
mov [rbx], rax
; postfix op finish
__tmp_label_31:
mov rax, rbp
sub rax, 112
mov [rbp-136], rax
mov rax, [rbp-112]
mov rbx, 10
cmp rax, rbx
jl __tmp_label_32
mov rax, 0
jmp __tmp_label_33
__tmp_label_32:
mov rax, 1
__tmp_label_33:
mov [rbp-152], rax
mov rax, [rbp-152]
cmp rax, 0
je __tmp_label_30
mov rax, __temp_str_4
mov [rbp-160], rax
mov rax, rbp
sub rax, 112
mov [rbp-168], rax
mov rax, [rbp-112]
mov [rbp-176], rax
mov rdi, [rbp-160]
mov rsi, [rbp-176]
mov rax, rbp
sub rax, 8
mov [rbp-184], rax
call printf
mov rax, rbp
sub rax, 112
mov [rbp-192], rax
mov rax, [rbp-112]
mov rbx, 5
cmp rax, rbx
je __tmp_label_34
mov rax, 0
jmp __tmp_label_35
__tmp_label_34:
mov rax, 1
__tmp_label_35:
mov [rbp-208], rax
mov rax, 0
cmp rax, [rbp-208]
je __tmp_label_36
jmp __tmp_label_30
__tmp_label_36:
jmp __tmp_label_29
__tmp_label_30:
; exit loop
jmp __tmp_label_24
__tmp_label_25:
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
