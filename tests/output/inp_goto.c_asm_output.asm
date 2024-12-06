section .data
__temp_str_0 db `first\n`, 0
__temp_str_1 db `second\n`, 0
__temp_str_2 db `%d\n`, 0
__main_size: equ 112
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
mov rdi, [rbp-16]
mov rax, rbp
sub rax, 8
mov [rbp-24], rax
call printf
jmp end
mov rax, rbp
sub rax, 8
mov [rbp-32], rax
mov rax, [rbp-8]
mov rbx, 69
mov rax, [rbp-32]
mov [rax], rbx
mov rax, rbx
mov [rbp-48], rax
mov rax, __temp_str_1
mov [rbp-56], rax
mov rdi, [rbp-56]
mov rax, rbp
sub rax, 8
mov [rbp-64], rax
call printf
end:
mov rax, __temp_str_2
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
call printf
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
