section .data
__temp_str_0 db `salam `, 0
__temp_str_1 db `khubi`, 0
__temp_str_2 db `%s\n`, 0
__temp_str_3 db `output.txt`, 0
__temp_str_4 db `w`, 0
__temp_str_5 db `Error opening file!`, 0
__temp_str_6 db `Hello, World!\n`, 0
__main_size: equ 336
section .text
extern stdout
extern stderr
extern printf
extern strcmp
extern strcat
extern strcpy
extern malloc
extern sprintf
extern fprintf
extern fopen
extern fclose
extern fread
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
;define variable a
mov rax, __temp_str_0
mov [rbp-8], rax
;end define variable a
;define variable b
mov rax, __temp_str_1
mov [rbp-16], rax
;end define variable b
mov rax, 100
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
;define variable c
mov rax, [rbp-56]
mov [rbp-24], rax
;end define variable c
mov rax, rbp
sub rax, 24
mov [rbp-64], rax
mov rax, [rbp-24]
mov [rbp-72], rax
mov rax, rbp
sub rax, 8
mov [rbp-80], rax
mov rax, [rbp-8]
mov [rbp-88], rax
mov rdi, [rbp-72]
mov rsi, [rbp-88]
mov rax, rbp
sub rax, 8
mov [rbp-96], rax
call strcpy
mov rax, rbp
sub rax, 24
mov [rbp-104], rax
mov rax, [rbp-24]
mov [rbp-112], rax
mov rax, rbp
sub rax, 16
mov [rbp-120], rax
mov rax, [rbp-16]
mov [rbp-128], rax
mov rdi, [rbp-112]
mov rsi, [rbp-128]
mov rax, rbp
sub rax, 8
mov [rbp-136], rax
call strcat
mov rax, __temp_str_2
mov [rbp-144], rax
mov rax, rbp
sub rax, 24
mov [rbp-152], rax
mov rax, [rbp-24]
mov [rbp-160], rax
mov rdi, [rbp-144]
mov rsi, [rbp-160]
mov rax, rbp
sub rax, 8
mov [rbp-168], rax
call printf
mov rax, rbp
sub rax, 176
mov [rbp-184], rax
mov rax, __temp_str_3
mov [rbp-192], rax
mov rax, __temp_str_4
mov [rbp-200], rax
mov rdi, [rbp-192]
mov rsi, [rbp-200]
mov rax, rbp
sub rax, 8
mov [rbp-208], rax
call fopen
mov [rbp-216], rax
mov rax, [rbp-176]
mov rbx, [rbp-216]
mov rax, [rbp-184]
mov [rax], rbx
mov rax, rbx
mov [rbp-224], rax
; unary op apply
mov rax, rbp
sub rax, 176
mov [rbp-232], rax
; operand code: [rbp-176]
mov rax, [rbp-176]
cmp rax, 0
sete al
movzx rax, al
mov [rbp-240], rax
; unary op finish
mov rax, 0
cmp rax, [rbp-240]
je __tmp_label_0
mov rax, __temp_str_5
mov [rbp-248], rax
mov rdi, [rbp-248]
mov rax, rbp
sub rax, 8
mov [rbp-256], rax
call printf
mov rax, 1
mov rsp, rbp
pop rbp
ret
__tmp_label_0:
mov rax, rbp
sub rax, 176
mov [rbp-248], rax
mov rax, [rbp-176]
mov [rbp-256], rax
mov rax, __temp_str_6
mov [rbp-264], rax
mov rdi, [rbp-256]
mov rsi, [rbp-264]
mov rax, rbp
sub rax, 8
mov [rbp-272], rax
call fprintf
mov rax, rbp
sub rax, 176
mov [rbp-280], rax
mov rax, [rbp-176]
mov [rbp-288], rax
mov rdi, [rbp-288]
mov rax, rbp
sub rax, 8
mov [rbp-296], rax
call fclose
mov [rbp-304], rax
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
