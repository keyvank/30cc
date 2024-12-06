section .data
__temp_str_0 db `%u\n`, 0
__temp_str_1 db `%u\n`, 0
__temp_str_2 db `%u\n`, 0
__main_size: equ 256
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
;define variable b
mov rax, 3
mov [rbp-16], rax
;end define variable b
mov rax, rbp
sub rax, 8
mov [rbp-24], rax
mov rax, rbp
sub rax, 16
mov [rbp-32], rax
mov rax, [rbp-8]
mov rbx, [rbp-16]
add rax, rbx
mov rbx, [rbp-24]
mov [rbx], rax
mov [rbp-48], rax
mov rax, rbp
sub rax, 8
mov [rbp-56], rax
mov rax, rbp
sub rax, 16
mov [rbp-64], rax
mov rax, [rbp-8]
mov rbx, [rbp-16]
sub rax, rbx
mov rbx, [rbp-56]
mov [rbx], rax
mov [rbp-80], rax
mov rax, rbp
sub rax, 8
mov [rbp-88], rax
mov rax, rbp
sub rax, 16
mov [rbp-96], rax
mov rax, [rbp-16]
mov rbx, 1
add rax, rbx
mov [rbp-112], rax
mov rax, [rbp-8]
mov rbx, [rbp-112]
mul rbx
mov rbx, [rbp-88]
mov [rbx], rax
mov [rbp-128], rax
mov rax, __temp_str_0
mov [rbp-136], rax
mov rax, 23
mov rbx, 16
mov rdx, 0
div rbx
mov rax, rdx
mov [rbp-152], rax
mov rax, [rbp-152]
mov [rbp-160], rax
mov rdi, [rbp-136]
mov rsi, [rbp-160]
mov rax, rbp
sub rax, 8
mov [rbp-168], rax
call printf
mov rax, __temp_str_1
mov [rbp-176], rax
mov rax, 19
mov rbx, 16
mov rdx, 0
div rbx
mov rax, rdx
mov [rbp-192], rax
mov rax, [rbp-192]
mov [rbp-200], rax
mov rdi, [rbp-176]
mov rsi, [rbp-200]
mov rax, rbp
sub rax, 8
mov [rbp-208], rax
call printf
mov rax, __temp_str_2
mov [rbp-216], rax
mov rax, 32
mov rbx, 16
mov rdx, 0
div rbx
mov rax, rdx
mov [rbp-232], rax
mov rax, [rbp-232]
mov [rbp-240], rax
mov rdi, [rbp-216]
mov rsi, [rbp-240]
mov rax, rbp
sub rax, 8
mov [rbp-248], rax
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
