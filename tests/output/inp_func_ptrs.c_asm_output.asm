section .data
__sum_size: equ 64
__mul_size: equ 64
__handle_size: equ 80
__temp_str_3 db `Func #%u result: %u\n`, 0
__main_size: equ 352
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
mov [rbp-48], rax
mov rax, [rbp-48]
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
mov [rbp-48], rax
mov rax, [rbp-48]
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
mov [rbp-24], rax
mov rax, [rbp-24]
mov [rbp-32], rax
mov rdi, [rbp-32]
mov rax, rbp
sub rax, 8
mov [rbp-40], rax
call malloc
mov [rbp-48], rax
xor rax, rax
mov [rbp-56], rax
mov rax, [rbp-48]
mov [rbp-56], rax
;define variable funcs
mov rax, [rbp-56]
mov [rbp-8], rax
;end define variable funcs
mov rax, rbp
sub rax, 8
mov [rbp-64], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rbp-8]
add rbx, rax
mov [rbp-72], rbx
mov rax, [rbx]
mov [rbp-80], rax
mov rax, rbp
sub rax, 8
mov [rbp-88], rax
mov rax, [rbp-80]
mov rbx, sum
mov rax, [rbp-72]
mov [rax], rbx
mov rax, rbx
mov [rbp-96], rax
mov rax, rbp
sub rax, 8
mov [rbp-112], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, [rbp-8]
add rbx, rax
mov [rbp-120], rbx
mov rax, [rbx]
mov [rbp-128], rax
mov rax, rbp
sub rax, 8
mov [rbp-136], rax
mov rax, [rbp-128]
mov rbx, mul
mov rax, [rbp-120]
mov [rax], rbx
mov rax, rbx
mov [rbp-144], rax
;define variable i
mov rax, 0
mov [rbp-160], rax
;end define variable i
; enter loop
__tmp_label_0:
mov rax, rbp
sub rax, 160
mov [rbp-168], rax
mov rax, [rbp-160]
mov rbx, 2
cmp rax, rbx
jl __tmp_label_2
mov rax, 0
jmp __tmp_label_3
__tmp_label_2:
mov rax, 1
__tmp_label_3:
mov [rbp-192], rax
mov rax, [rbp-192]
cmp rax, 0
je __tmp_label_1
mov rax, 10
mov [rbp-208], rax
mov rax, 20
mov [rbp-216], rax
mov rax, rbp
sub rax, 8
mov [rbp-224], rax
mov rax, rbp
sub rax, 160
mov [rbp-232], rax
mov rax, [rbp-160]
mov rbx, 8
mul rbx
mov rbx, [rbp-8]
add rbx, rax
mov [rbp-240], rbx
mov rax, [rbx]
mov [rbp-248], rax
mov rax, [rbp-248]
mov [rbp-256], rax
mov rdi, [rbp-208]
mov rsi, [rbp-216]
mov rdx, [rbp-256]
mov rax, rbp
sub rax, 8
mov [rbp-264], rax
call handle
mov [rbp-272], rax
;define variable res
mov rax, [rbp-272]
mov [rbp-200], rax
;end define variable res
mov rax, __temp_str_3
mov [rbp-280], rax
mov rax, rbp
sub rax, 160
mov [rbp-288], rax
mov rax, [rbp-160]
mov [rbp-296], rax
mov rax, rbp
sub rax, 200
mov [rbp-304], rax
mov rax, [rbp-200]
mov [rbp-312], rax
mov rdi, [rbp-280]
mov rsi, [rbp-296]
mov rdx, [rbp-312]
mov rax, rbp
sub rax, 8
mov [rbp-320], rax
call printf
; postfix op apply
mov rax, rbp
sub rax, 160
mov [rbp-200], rax
mov rax, [rbp-160]
mov [rbp-208], rax
add rax, 1
mov rbx, [rbp-200]
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
