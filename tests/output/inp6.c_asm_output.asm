section .data
__temp_str_0 db `Salam!`, 0
__temp_str_1 db `%u %u %c %s\n`, 0
__main_size: equ 320
section .text
extern printf
extern malloc
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
mov rax, 25
mov [rbp-16], rax
mov rdi, [rbp-16]
mov rax, rbp
sub rax, 8
mov [rbp-24], rax
call malloc
mov [rbp-32], rax
xor rax, rax
mov [rbp-40], rax
mov rax, [rbp-32]
mov [rbp-40], rax
;define variable m
mov rax, [rbp-40]
mov [rbp-8], rax
;end define variable m
mov rax, rbp
sub rax, 8
mov [rbp-48], rax
mov rax, [rbp-8]
add rax, 0
mov [rbp-56], rax
mov rax, [rax]
mov [rbp-64], rax
mov rax, [rbp-64]
mov rbx, 10
mov rax, [rbp-56]
mov [rax], rbx
mov rax, rbx
mov [rbp-80], rax
mov rax, rbp
sub rax, 8
mov [rbp-88], rax
mov rax, [rbp-8]
add rax, 8
mov [rbp-96], rax
mov rax, [rax]
mov [rbp-104], rax
mov rax, [rbp-104]
mov rbx, 20
mov rax, [rbp-96]
mov [rax], rbx
mov rax, rbx
mov [rbp-120], rax
mov rax, rbp
sub rax, 8
mov [rbp-128], rax
mov rax, [rbp-8]
add rax, 16
mov [rbp-136], rax
mov al, [rax]
mov [rbp-137], al
mov al, [rbp-137]
mov bl, 75
mov rax, [rbp-136]
mov [rax], bl
mov al, bl
mov [rbp-139], al
mov rax, rbp
sub rax, 8
mov [rbp-147], rax
mov rax, [rbp-8]
add rax, 17
mov [rbp-155], rax
mov rax, [rax]
mov [rbp-163], rax
mov rax, [rbp-163]
mov rbx, __temp_str_0
mov rax, [rbp-155]
mov [rax], rbx
mov rax, rbx
mov [rbp-171], rax
mov rax, __temp_str_1
mov [rbp-187], rax
mov rax, rbp
sub rax, 8
mov [rbp-195], rax
mov rax, [rbp-8]
add rax, 0
mov [rbp-203], rax
mov rax, [rax]
mov [rbp-211], rax
mov rax, [rbp-211]
mov [rbp-219], rax
mov rax, rbp
sub rax, 8
mov [rbp-227], rax
mov rax, [rbp-8]
add rax, 8
mov [rbp-235], rax
mov rax, [rax]
mov [rbp-243], rax
mov rax, [rbp-243]
mov [rbp-251], rax
mov rax, rbp
sub rax, 8
mov [rbp-259], rax
mov rax, [rbp-8]
add rax, 16
mov [rbp-267], rax
mov al, [rax]
mov [rbp-268], al
mov al, [rbp-268]
mov [rbp-269], al
mov rax, rbp
sub rax, 8
mov [rbp-277], rax
mov rax, [rbp-8]
add rax, 17
mov [rbp-285], rax
mov rax, [rax]
mov [rbp-293], rax
mov rax, [rbp-293]
mov [rbp-301], rax
mov rdi, [rbp-187]
mov rsi, [rbp-219]
mov rdx, [rbp-251]
mov cl, [rbp-269]
mov r8, [rbp-301]
mov rax, rbp
sub rax, 8
mov [rbp-309], rax
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
