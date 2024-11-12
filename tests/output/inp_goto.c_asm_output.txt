section .data
__printf_size: equ 16
__temp_str_1 db `first\n`, 0
__temp_str_2 db `second\n`, 0
__temp_str_3 db `%d\n`, 0
__main_size: equ 96
section .text
extern printf
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
;define variable a
mov rax, 2
mov [rsp+0], rax
;end define variable a
mov rax, __temp_str_1
mov [rsp+8], rax
mov rdi, [rsp+8]
mov rax, rsp
add rax, 0
mov [rsp+16], rax
call printf
mov [rsp+24], rax
jmp end
mov rax, rsp
add rax, 0
mov [rsp+24], rax
mov rax, [rsp+0]
mov rbx, 69
mov rax, 69
mov rbx, [rsp+24]
mov [rbx], rax
mov [rsp+32], rax
mov rax, __temp_str_2
mov [rsp+40], rax
mov rdi, [rsp+40]
mov rax, rsp
add rax, 0
mov [rsp+48], rax
call printf
mov [rsp+56], rax
end:
mov rax, __temp_str_3
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
call printf
mov [rsp+88], rax
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
