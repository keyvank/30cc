section .data
__temp_str_0 db `Salam!`, 0
__temp_str_1 db `%u %u %c %s\n`, 0
__main_size: equ 288
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
mov [rbp-72], rax
mov rax, rbp
sub rax, 8
mov [rbp-80], rax
mov rax, [rbp-8]
add rax, 8
mov [rbp-88], rax
mov rax, [rax]
mov [rbp-96], rax
mov rax, [rbp-96]
mov rbx, 20
mov rax, [rbp-88]
mov [rax], rbx
mov rax, rbx
mov [rbp-104], rax
mov rax, rbp
sub rax, 8
mov [rbp-112], rax
mov rax, [rbp-8]
add rax, 16
mov [rbp-120], rax
mov al, [rax]
mov [rbp-121], al
mov al, [rbp-121]
mov bl, 75
mov rax, [rbp-120]
mov [rax], bl
mov al, bl
mov [rbp-122], al
mov rax, rbp
sub rax, 8
mov [rbp-130], rax
mov rax, [rbp-8]
add rax, 17
mov [rbp-138], rax
mov rax, [rax]
mov [rbp-146], rax
mov rax, [rbp-146]
mov rbx, __temp_str_0
mov rax, [rbp-138]
mov [rax], rbx
mov rax, rbx
mov [rbp-154], rax
mov rax, __temp_str_1
mov [rbp-162], rax
mov rax, rbp
sub rax, 8
mov [rbp-170], rax
mov rax, [rbp-8]
add rax, 0
mov [rbp-178], rax
mov rax, [rax]
mov [rbp-186], rax
mov rax, [rbp-186]
mov [rbp-194], rax
mov rax, rbp
sub rax, 8
mov [rbp-202], rax
mov rax, [rbp-8]
add rax, 8
mov [rbp-210], rax
mov rax, [rax]
mov [rbp-218], rax
mov rax, [rbp-218]
mov [rbp-226], rax
mov rax, rbp
sub rax, 8
mov [rbp-234], rax
mov rax, [rbp-8]
add rax, 16
mov [rbp-242], rax
mov al, [rax]
mov [rbp-243], al
mov al, [rbp-243]
mov [rbp-244], al
mov rax, rbp
sub rax, 8
mov [rbp-252], rax
mov rax, [rbp-8]
add rax, 17
mov [rbp-260], rax
mov rax, [rax]
mov [rbp-268], rax
mov rax, [rbp-268]
mov [rbp-276], rax
mov rdi, [rbp-162]
mov rsi, [rbp-194]
mov rdx, [rbp-226]
mov cl, [rbp-244]
mov r8, [rbp-276]
mov rax, rbp
sub rax, 8
mov [rbp-284], rax
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
