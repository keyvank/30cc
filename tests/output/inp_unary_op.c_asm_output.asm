section .data
__temp_str_0 db `%d\n`, 0
__temp_str_1 db `%d\n`, 0
__temp_str_2 db `%d\n`, 0
__temp_str_3 db `%d\n`, 0
__temp_str_4 db `%d\n`, 0
__temp_str_5 db `%d\n`, 0
__temp_str_6 db `%d\n`, 0
__temp_str_7 db `%d\n`, 0
__temp_str_8 db `%d\n`, 0
__main_size: equ 432
section .text
extern printf
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
;define variable a
mov rax, 2
mov [rbp-8], rax
;end define variable a
mov rax, __temp_str_0
mov [rbp-16], rax
; unary op apply
mov rax, rbp
sub rax, 8
mov [rbp-24], rax
; operand code: [rbp-8]
mov rax, [rbp-8]
neg rax
mov [rbp-32], rax
; unary op finish
mov rax, [rbp-32]
mov [rbp-40], rax
mov rdi, [rbp-16]
mov rsi, [rbp-40]
mov rax, rbp
sub rax, 8
mov [rbp-48], rax
call printf
mov rax, __temp_str_1
mov [rbp-56], rax
; unary op apply
mov rax, rbp
sub rax, 8
mov [rbp-64], rax
; operand code: [rbp-8]
mov rax, [rbp-8]
sub rax, 1
mov rbx, [rbp-64]
mov [rbx], rax
mov [rbp-72], rax
; unary op finish
mov rax, [rbp-72]
mov [rbp-80], rax
mov rdi, [rbp-56]
mov rsi, [rbp-80]
mov rax, rbp
sub rax, 8
mov [rbp-88], rax
call printf
mov rax, __temp_str_2
mov [rbp-96], rax
; unary op apply
mov rax, rbp
sub rax, 8
mov [rbp-104], rax
; operand code: [rbp-8]
mov rax, [rbp-8]
cmp rax, 0
sete al
movzx rax, al
mov [rbp-112], rax
; unary op finish
mov rax, [rbp-112]
mov [rbp-120], rax
mov rdi, [rbp-96]
mov rsi, [rbp-120]
mov rax, rbp
sub rax, 8
mov [rbp-128], rax
call printf
mov rax, __temp_str_3
mov [rbp-136], rax
; unary op apply
; unary op apply
mov rax, rbp
sub rax, 8
mov [rbp-144], rax
; operand code: [rbp-8]
mov rax, [rbp-8]
cmp rax, 0
sete al
movzx rax, al
mov [rbp-152], rax
; unary op finish
; operand code: [rbp-152]
mov rax, [rbp-152]
cmp rax, 0
sete al
movzx rax, al
mov [rbp-160], rax
; unary op finish
mov rax, [rbp-160]
mov [rbp-168], rax
mov rdi, [rbp-136]
mov rsi, [rbp-168]
mov rax, rbp
sub rax, 8
mov [rbp-176], rax
call printf
mov rax, __temp_str_4
mov [rbp-184], rax
; unary op apply
; unary op apply
mov rax, rbp
sub rax, 8
mov [rbp-192], rax
; operand code: [rbp-8]
mov rax, [rbp-8]
neg rax
mov [rbp-200], rax
; unary op finish
; operand code: [rbp-200]
mov rax, [rbp-200]
mov [rbp-208], rax
; unary op finish
mov rax, [rbp-208]
mov [rbp-216], rax
mov rdi, [rbp-184]
mov rsi, [rbp-216]
mov rax, rbp
sub rax, 8
mov [rbp-224], rax
call printf
mov rax, __temp_str_5
mov [rbp-232], rax
; unary op apply
mov rax, rbp
sub rax, 8
mov [rbp-240], rax
; operand code: [rbp-8]
mov rax, [rbp-8]
add rax, 1
mov rbx, [rbp-240]
mov [rbx], rax
mov [rbp-248], rax
; unary op finish
mov rax, [rbp-248]
mov [rbp-256], rax
mov rdi, [rbp-232]
mov rsi, [rbp-256]
mov rax, rbp
sub rax, 8
mov [rbp-264], rax
call printf
mov rax, __temp_str_6
mov [rbp-272], rax
; postfix op apply
mov rax, rbp
sub rax, 8
mov [rbp-280], rax
mov rax, [rbp-8]
mov [rbp-288], rax
add rax, 1
mov rbx, [rbp-280]
mov [rbx], rax
; postfix op finish
mov rax, [rbp-288]
mov [rbp-296], rax
mov rdi, [rbp-272]
mov rsi, [rbp-296]
mov rax, rbp
sub rax, 8
mov [rbp-304], rax
call printf
mov rax, __temp_str_7
mov [rbp-312], rax
; postfix op apply
mov rax, rbp
sub rax, 8
mov [rbp-320], rax
mov rax, [rbp-8]
mov [rbp-328], rax
sub rax, 1
mov rbx, [rbp-320]
mov [rbx], rax
; postfix op finish
mov rax, [rbp-328]
mov [rbp-336], rax
mov rdi, [rbp-312]
mov rsi, [rbp-336]
mov rax, rbp
sub rax, 8
mov [rbp-344], rax
call printf
;define variable i
mov rax, 0
mov [rbp-352], rax
;end define variable i
; enter loop
jmp __tmp_label_2
__tmp_label_0:
; postfix op apply
mov rax, rbp
sub rax, 352
mov [rbp-360], rax
mov rax, [rbp-352]
mov [rbp-368], rax
add rax, 1
mov rbx, [rbp-360]
mov [rbx], rax
; postfix op finish
__tmp_label_2:
mov rax, rbp
sub rax, 352
mov [rbp-376], rax
mov rax, [rbp-352]
mov rbx, 5
cmp rax, rbx
jl __tmp_label_3
mov rax, 0
jmp __tmp_label_4
__tmp_label_3:
mov rax, 1
__tmp_label_4:
mov [rbp-392], rax
mov rax, [rbp-392]
cmp rax, 0
je __tmp_label_1
mov rax, __temp_str_8
mov [rbp-400], rax
mov rax, rbp
sub rax, 352
mov [rbp-408], rax
mov rax, [rbp-352]
mov [rbp-416], rax
mov rdi, [rbp-400]
mov rsi, [rbp-416]
mov rax, rbp
sub rax, 8
mov [rbp-424], rax
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
