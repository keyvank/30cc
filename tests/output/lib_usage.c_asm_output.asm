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
mov rax, __temp_str_0
mov [rsp+0], rax
;end define variable a
;define variable b
mov rax, __temp_str_1
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
xor rax, rax
mov [rsp+48], rax
mov rax, [rsp+40]
mov [rsp+48], rax
;define variable c
mov rax, [rsp+48]
mov [rsp+16], rax
;end define variable c
mov rax, rsp
add rax, 16
mov [rsp+56], rax
mov rax, [rsp+16]
mov [rsp+64], rax
mov rax, rsp
add rax, 0
mov [rsp+72], rax
mov rax, [rsp+0]
mov [rsp+80], rax
mov rdi, [rsp+64]
mov rsi, [rsp+80]
mov rax, rsp
add rax, 0
mov [rsp+88], rax
call strcpy
mov rax, rsp
add rax, 16
mov [rsp+96], rax
mov rax, [rsp+16]
mov [rsp+104], rax
mov rax, rsp
add rax, 8
mov [rsp+112], rax
mov rax, [rsp+8]
mov [rsp+120], rax
mov rdi, [rsp+104]
mov rsi, [rsp+120]
mov rax, rsp
add rax, 0
mov [rsp+128], rax
call strcat
mov rax, __temp_str_2
mov [rsp+136], rax
mov rax, rsp
add rax, 16
mov [rsp+144], rax
mov rax, [rsp+16]
mov [rsp+152], rax
mov rdi, [rsp+136]
mov rsi, [rsp+152]
mov rax, rsp
add rax, 0
mov [rsp+160], rax
call printf
mov rax, rsp
add rax, 168
mov [rsp+176], rax
mov rax, __temp_str_3
mov [rsp+184], rax
mov rax, __temp_str_4
mov [rsp+192], rax
mov rdi, [rsp+184]
mov rsi, [rsp+192]
mov rax, rsp
add rax, 0
mov [rsp+200], rax
call fopen
mov [rsp+208], rax
mov rax, [rsp+168]
mov rbx, [rsp+208]
mov rax, [rsp+176]
mov [rax], rbx
mov rax, rbx
mov [rsp+216], rax
; unary op apply
mov rax, rsp
add rax, 168
mov [rsp+224], rax
; operand code: [rsp+168]
mov rax, [rsp+168]
cmp rax, 0
sete al
movzx rax, al
mov [rsp+232], rax
; unary op finish
mov rax, 0
cmp rax, [rsp+232]
je __tmp_label_0
mov rax, __temp_str_5
mov [rsp+240], rax
mov rdi, [rsp+240]
mov rax, rsp
add rax, 0
mov [rsp+248], rax
call printf
mov rax, 1
mov rsp, rbp
pop rbp
ret
__tmp_label_0:
mov rax, rsp
add rax, 168
mov [rsp+240], rax
mov rax, [rsp+168]
mov [rsp+248], rax
mov rax, __temp_str_6
mov [rsp+256], rax
mov rdi, [rsp+248]
mov rsi, [rsp+256]
mov rax, rsp
add rax, 0
mov [rsp+264], rax
call fprintf
mov rax, rsp
add rax, 168
mov [rsp+272], rax
mov rax, [rsp+168]
mov [rsp+280], rax
mov rdi, [rsp+280]
mov rax, rsp
add rax, 0
mov [rsp+288], rax
call fclose
mov [rsp+296], rax
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
