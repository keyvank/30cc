section .data
__printf_size: equ 16
__strcmp_size: equ 16
__strcat_size: equ 16
__strcpy_size: equ 16
__malloc_size: equ 16
__fprintf_size: equ 16
__fopen_size: equ 16
__fclose_size: equ 16
__temp_str_8 db `salam `, 0
__temp_str_9 db `khubi`, 0
__temp_str_10 db `%s\n`, 0
__temp_str_11 db `output.txt`, 0
__temp_str_12 db `w`, 0
__temp_str_13 db `Error opening file!`, 0
__temp_str_14 db `Hello, World!\n`, 0
__main_size: equ 320
section .text
extern printf
extern strcmp
extern strcat
extern strcpy
extern malloc
extern fprintf
extern fopen
extern fclose
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
;define variable a
mov rax, __temp_str_8
mov [rsp+0], rax
;end define variable a
;define variable b
mov rax, __temp_str_9
mov [rsp+8], rax
;end define variable b
mov rax, 100
mov [rsp+24], rax
mov rdi, [rsp+24]
mov rax, rsp
add rax, 0
mov [rsp+32], rax
call malloc
mov [rsp+40], rax
;define variable c
mov rax, [rsp+40]
mov [rsp+16], rax
;end define variable c
mov rax, rsp
add rax, 16
mov [rsp+48], rax
mov rax, [rsp+16]
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
call strcpy
mov rax, rsp
add rax, 16
mov [rsp+88], rax
mov rax, [rsp+16]
mov [rsp+96], rax
mov rax, rsp
add rax, 8
mov [rsp+104], rax
mov rax, [rsp+8]
mov [rsp+112], rax
mov rdi, [rsp+96]
mov rsi, [rsp+112]
mov rax, rsp
add rax, 0
mov [rsp+120], rax
call strcat
mov rax, __temp_str_10
mov [rsp+128], rax
mov rax, rsp
add rax, 16
mov [rsp+136], rax
mov rax, [rsp+16]
mov [rsp+144], rax
mov rdi, [rsp+128]
mov rsi, [rsp+144]
mov rax, rsp
add rax, 0
mov [rsp+152], rax
call printf
mov rax, rsp
add rax, 160
mov [rsp+168], rax
mov rax, __temp_str_11
mov [rsp+176], rax
mov rax, __temp_str_12
mov [rsp+184], rax
mov rdi, [rsp+176]
mov rsi, [rsp+184]
mov rax, rsp
add rax, 0
mov [rsp+192], rax
call fopen
mov [rsp+200], rax
mov rax, [rsp+160]
mov rbx, [rsp+200]
mov rax, [rsp+168]
mov [rax], rbx
mov [rsp+208], rax
; unary op apply
mov rax, rsp
add rax, 160
mov [rsp+216], rax
; operand code: [rsp+160]
mov rax, [rsp+160]
cmp rax, 0
sete al
movzx rax, al
mov [rsp+224], rax
; unary op finish
mov rax, 0
cmp rax, [rsp+224]
je __tmp_label_0
mov rax, __temp_str_13
mov [rsp+232], rax
mov rdi, [rsp+232]
mov rax, rsp
add rax, 0
mov [rsp+240], rax
call printf
mov rax, 1
mov rsp, rbp
pop rbp
ret
__tmp_label_0:
mov rax, rsp
add rax, 160
mov [rsp+232], rax
mov rax, [rsp+160]
mov [rsp+240], rax
mov rax, __temp_str_14
mov [rsp+248], rax
mov rdi, [rsp+240]
mov rsi, [rsp+248]
mov rax, rsp
add rax, 0
mov [rsp+256], rax
call fprintf
mov rax, rsp
add rax, 160
mov [rsp+264], rax
mov rax, [rsp+160]
mov [rsp+272], rax
mov rdi, [rsp+272]
mov rax, rsp
add rax, 0
mov [rsp+280], rax
call fclose
mov [rsp+288], rax
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
