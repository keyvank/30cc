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
mov [rbp-8], rdi
mov [rbp-16], rsi
mov rax, rbp
sub rax, 8
mov [rbp-24], rax
mov rax, rbp
sub rax, 16
mov [rbp-32], rax
mov rax, [rbp-8]
mov rbx, [rbp-16]
add rax, rbx
mov [rbp-40], rax
mov rax, [rbp-40]
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
mov [rbp-8], rdi
mov [rbp-16], rsi
mov rax, rbp
sub rax, 8
mov [rbp-24], rax
mov rax, rbp
sub rax, 16
mov [rbp-32], rax
mov rax, [rbp-8]
mov rbx, [rbp-16]
mul rbx
mov [rbp-40], rax
mov rax, [rbp-40]
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
mov [rbp-8], rdi
mov [rbp-16], rsi
mov [rbp-24], rdx
mov rax, rbp
sub rax, 8
mov [rbp-32], rax
mov rax, [rbp-8]
mov [rbp-40], rax
mov rax, rbp
sub rax, 16
mov [rbp-48], rax
mov rax, [rbp-16]
mov [rbp-56], rax
mov rdi, [rbp-40]
mov rsi, [rbp-56]
mov rax, rbp
sub rax, 24
mov [rbp-64], rax
call [rbp-24]
mov [rbp-72], rax
mov rax, [rbp-72]
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
mov [rbp-16], rax
mov rax, [rbp-16]
mov [rbp-24], rax
mov rdi, [rbp-24]
mov rax, rbp
sub rax, 8
mov [rbp-32], rax
call malloc
mov [rbp-40], rax
xor rax, rax
mov [rbp-48], rax
mov rax, [rbp-40]
mov [rbp-48], rax
;define variable funcs
mov rax, [rbp-48]
mov [rbp-8], rax
;end define variable funcs
mov rax, rbp
sub rax, 8
mov [rbp-56], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rbp-8]
add rbx, rax
mov [rbp-64], rbx
mov rax, [rbx]
mov [rbp-72], rax
mov rax, rbp
sub rax, 8
mov [rbp-80], rax
mov rax, [rbp-72]
mov rbx, sum
mov rax, [rbp-64]
mov [rax], rbx
mov rax, rbx
mov [rbp-88], rax
mov rax, rbp
sub rax, 8
mov [rbp-96], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, [rbp-8]
add rbx, rax
mov [rbp-104], rbx
mov rax, [rbx]
mov [rbp-112], rax
mov rax, rbp
sub rax, 8
mov [rbp-120], rax
mov rax, [rbp-112]
mov rbx, mul
mov rax, [rbp-104]
mov [rax], rbx
mov rax, rbx
mov [rbp-128], rax
;define variable i
mov rax, 0
mov [rbp-136], rax
;end define variable i
; enter loop
jmp __tmp_label_2
__tmp_label_0:
; postfix op apply
mov rax, rbp
sub rax, 136
mov [rbp-144], rax
mov rax, [rbp-136]
mov [rbp-152], rax
add rax, 1
mov rbx, [rbp-144]
mov [rbx], rax
; postfix op finish
__tmp_label_2:
mov rax, rbp
sub rax, 136
mov [rbp-160], rax
mov rax, [rbp-136]
mov rbx, 2
cmp rax, rbx
jl __tmp_label_3
mov rax, 0
jmp __tmp_label_4
__tmp_label_3:
mov rax, 1
__tmp_label_4:
mov [rbp-176], rax
mov rax, [rbp-176]
cmp rax, 0
je __tmp_label_1
mov rax, 10
mov [rbp-192], rax
mov rax, 20
mov [rbp-200], rax
mov rax, rbp
sub rax, 8
mov [rbp-208], rax
mov rax, rbp
sub rax, 136
mov [rbp-216], rax
mov rax, [rbp-136]
mov rbx, 8
mul rbx
mov rbx, [rbp-8]
add rbx, rax
mov [rbp-224], rbx
mov rax, [rbx]
mov [rbp-232], rax
mov rax, [rbp-232]
mov [rbp-240], rax
mov rdi, [rbp-192]
mov rsi, [rbp-200]
mov rdx, [rbp-240]
mov rax, rbp
sub rax, 8
mov [rbp-248], rax
call handle
mov [rbp-256], rax
;define variable res
mov rax, [rbp-256]
mov [rbp-184], rax
;end define variable res
mov rax, __temp_str_3
mov [rbp-264], rax
mov rax, rbp
sub rax, 136
mov [rbp-272], rax
mov rax, [rbp-136]
mov [rbp-280], rax
mov rax, rbp
sub rax, 184
mov [rbp-288], rax
mov rax, [rbp-184]
mov [rbp-296], rax
mov rdi, [rbp-264]
mov rsi, [rbp-280]
mov rdx, [rbp-296]
mov rax, rbp
sub rax, 8
mov [rbp-304], rax
call printf
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
