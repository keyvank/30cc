section .data
__printf_size: equ 16
__malloc_size: equ 16
__sum_size: equ 48
__mul_size: equ 48
__handle_size: equ 80
__temp_str_5 db `Func #%u result: %u\n`, 0
__main_size: equ 304
section .text
extern printf
extern malloc
global sum
sum:
push rbp
mov rbp, rsp
sub rsp, __sum_size
mov [rsp+0], rdi
mov [rsp+8], rsi
mov rax, rsp
add rax, 0
mov [rsp+16], rax
mov rax, rsp
add rax, 8
mov [rsp+24], rax
mov rax, [rsp+0]
mov rbx, [rsp+8]
add rax, rbx
mov [rsp+32], rax
mov rax, [rsp+32]
mov rsp, rbp
pop rbp
ret
mov rsp, rbp
pop rbp
ret
global mul
mul:
push rbp
mov rbp, rsp
sub rsp, __mul_size
mov [rsp+0], rdi
mov [rsp+8], rsi
mov rax, rsp
add rax, 0
mov [rsp+16], rax
mov rax, rsp
add rax, 8
mov [rsp+24], rax
mov rax, [rsp+0]
mov rbx, [rsp+8]
mul rbx
mov [rsp+32], rax
mov rax, [rsp+32]
mov rsp, rbp
pop rbp
ret
mov rsp, rbp
pop rbp
ret
global handle
handle:
push rbp
mov rbp, rsp
sub rsp, __handle_size
mov [rsp+0], rdi
mov [rsp+8], rsi
mov [rsp+16], rdx
mov rax, rsp
add rax, 0
mov [rsp+24], rax
mov rax, [rsp+0]
mov [rsp+32], rax
mov rax, rsp
add rax, 8
mov [rsp+40], rax
mov rax, [rsp+8]
mov [rsp+48], rax
mov rdi, [rsp+32]
mov rsi, [rsp+48]
mov rax, rsp
add rax, 16
mov [rsp+56], rax
call [rsp+16]
mov [rsp+64], rax
mov rax, [rsp+64]
mov rsp, rbp
pop rbp
ret
mov rsp, rbp
pop rbp
ret
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
mov rax, 8
mov rbx, 2
mul rbx
mov [rsp+8], rax
mov rax, [rsp+8]
mov [rsp+16], rax
mov rdi, [rsp+16]
mov rax, rsp
add rax, 0
mov [rsp+24], rax
call malloc
mov [rsp+32], rax
;define variable funcs
mov rax, [rsp+32]
mov [rsp+0], rax
;end define variable funcs
mov rax, rsp
add rax, 0
mov [rsp+40], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+0]
add rbx, rax
mov [rsp+48], rbx
mov rax, [rbx]
mov [rsp+56], rax
mov rax, rsp
add rax, 0
mov [rsp+64], rax
mov rax, [rsp+56]
mov rbx, sum
mov rax, sum
mov rbx, [rsp+48]
mov [rbx], rax
mov [rsp+72], rax
mov rax, rsp
add rax, 0
mov [rsp+80], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, [rsp+0]
add rbx, rax
mov [rsp+88], rbx
mov rax, [rbx]
mov [rsp+96], rax
mov rax, rsp
add rax, 0
mov [rsp+104], rax
mov rax, [rsp+96]
mov rbx, mul
mov rax, mul
mov rbx, [rsp+88]
mov [rbx], rax
mov [rsp+112], rax
;define variable i
mov rax, 0
mov [rsp+120], rax
;end define variable i
; enter loop
__tmp_label_0:
mov rax, rsp
add rax, 120
mov [rsp+128], rax
mov rax, [rsp+120]
mov rbx, 2
cmp rax, rbx
jl __tmp_label_2
mov rax, 0
jmp __tmp_label_3
__tmp_label_2:
mov rax, 1
__tmp_label_3:
mov [rsp+136], rax
mov rax, [rsp+136]
cmp rax, 0
je __tmp_label_1
mov rax, 10
mov [rsp+152], rax
mov rax, 20
mov [rsp+160], rax
mov rax, rsp
add rax, 0
mov [rsp+168], rax
mov rax, rsp
add rax, 120
mov [rsp+176], rax
mov rax, [rsp+120]
mov rbx, 8
mul rbx
mov rbx, [rsp+0]
add rbx, rax
mov [rsp+184], rbx
mov rax, [rbx]
mov [rsp+192], rax
mov rax, [rsp+192]
mov [rsp+200], rax
mov rdi, [rsp+152]
mov rsi, [rsp+160]
mov rdx, [rsp+200]
mov rax, rsp
add rax, 0
mov [rsp+208], rax
call handle
mov [rsp+216], rax
;define variable res
mov rax, [rsp+216]
mov [rsp+144], rax
;end define variable res
mov rax, __temp_str_5
mov [rsp+224], rax
mov rax, rsp
add rax, 120
mov [rsp+232], rax
mov rax, [rsp+120]
mov [rsp+240], rax
mov rax, rsp
add rax, 144
mov [rsp+248], rax
mov rax, [rsp+144]
mov [rsp+256], rax
mov rdi, [rsp+224]
mov rsi, [rsp+240]
mov rdx, [rsp+256]
mov rax, rsp
add rax, 0
mov [rsp+264], rax
call printf
mov [rsp+272], rax
; postfix op apply
mov rax, rsp
add rax, 120
mov [rsp+144], rax
mov rax, [rsp+120]
mov [rsp+152], rax
add rax, 1
mov rbx, [rsp+144]
mov [rbx], rax
; postfix op finish
jmp __tmp_label_0
__tmp_label_1:
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
