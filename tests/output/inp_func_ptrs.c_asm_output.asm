section .data
__sum_size: equ 48
__mul_size: equ 48
__handle_size: equ 80
__temp_str_3 db `Func #%u result: %u\n`, 0
__main_size: equ 320
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
xor rax, rax
mov [rsp+40], rax
mov rax, [rsp+32]
mov [rsp+40], rax
;define variable funcs
mov rax, [rsp+40]
mov [rsp+0], rax
;end define variable funcs
mov rax, rsp
add rax, 0
mov [rsp+48], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+0]
add rbx, rax
mov [rsp+56], rbx
mov rax, [rbx]
mov [rsp+64], rax
mov rax, rsp
add rax, 0
mov [rsp+72], rax
mov rax, [rsp+64]
mov rbx, sum
mov rax, [rsp+56]
mov [rax], rbx
mov rax, rbx
mov [rsp+80], rax
mov rax, rsp
add rax, 0
mov [rsp+88], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, [rsp+0]
add rbx, rax
mov [rsp+96], rbx
mov rax, [rbx]
mov [rsp+104], rax
mov rax, rsp
add rax, 0
mov [rsp+112], rax
mov rax, [rsp+104]
mov rbx, mul
mov rax, [rsp+96]
mov [rax], rbx
mov rax, rbx
mov [rsp+120], rax
;define variable i
mov rax, 0
mov [rsp+128], rax
;end define variable i
; enter loop
__tmp_label_0:
mov rax, rsp
add rax, 128
mov [rsp+136], rax
mov rax, [rsp+128]
mov rbx, 2
cmp rax, rbx
jl __tmp_label_2
mov rax, 0
jmp __tmp_label_3
__tmp_label_2:
mov rax, 1
__tmp_label_3:
mov [rsp+152], rax
mov rax, [rsp+152]
cmp rax, 0
je __tmp_label_1
mov rax, 10
mov [rsp+168], rax
mov rax, 20
mov [rsp+176], rax
mov rax, rsp
add rax, 0
mov [rsp+184], rax
mov rax, rsp
add rax, 128
mov [rsp+192], rax
mov rax, [rsp+128]
mov rbx, 8
mul rbx
mov rbx, [rsp+0]
add rbx, rax
mov [rsp+200], rbx
mov rax, [rbx]
mov [rsp+208], rax
mov rax, [rsp+208]
mov [rsp+216], rax
mov rdi, [rsp+168]
mov rsi, [rsp+176]
mov rdx, [rsp+216]
mov rax, rsp
add rax, 0
mov [rsp+224], rax
call handle
mov [rsp+232], rax
;define variable res
mov rax, [rsp+232]
mov [rsp+160], rax
;end define variable res
mov rax, __temp_str_3
mov [rsp+240], rax
mov rax, rsp
add rax, 128
mov [rsp+248], rax
mov rax, [rsp+128]
mov [rsp+256], rax
mov rax, rsp
add rax, 160
mov [rsp+264], rax
mov rax, [rsp+160]
mov [rsp+272], rax
mov rdi, [rsp+240]
mov rsi, [rsp+256]
mov rdx, [rsp+272]
mov rax, rsp
add rax, 0
mov [rsp+280], rax
call printf
; postfix op apply
mov rax, rsp
add rax, 128
mov [rsp+160], rax
mov rax, [rsp+128]
mov [rsp+168], rax
add rax, 1
mov rbx, [rsp+160]
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
