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
mov [rsp+8], rax
mov rdi, [rsp+8]
mov rax, rsp
add rax, 0
mov [rsp+16], rax
call malloc
mov [rsp+24], rax
xor rax, rax
mov [rsp+32], rax
mov rax, [rsp+24]
mov [rsp+32], rax
;define variable m
mov rax, [rsp+32]
mov [rsp+0], rax
;end define variable m
mov rax, rsp
add rax, 0
mov [rsp+40], rax
mov rax, [rsp+0]
add rax, 0
mov [rsp+48], rax
mov rax, [rax]
mov [rsp+56], rax
mov rax, [rsp+56]
mov rbx, 10
mov rax, [rsp+48]
mov [rax], rbx
mov rax, rbx
mov [rsp+64], rax
mov rax, rsp
add rax, 0
mov [rsp+72], rax
mov rax, [rsp+0]
add rax, 8
mov [rsp+80], rax
mov rax, [rax]
mov [rsp+88], rax
mov rax, [rsp+88]
mov rbx, 20
mov rax, [rsp+80]
mov [rax], rbx
mov rax, rbx
mov [rsp+96], rax
mov rax, rsp
add rax, 0
mov [rsp+104], rax
mov rax, [rsp+0]
add rax, 16
mov [rsp+112], rax
mov al, [rax]
mov [rsp+120], al
mov al, [rsp+120]
mov bl, 75
mov rax, [rsp+112]
mov [rax], bl
mov al, bl
mov [rsp+121], al
mov rax, rsp
add rax, 0
mov [rsp+122], rax
mov rax, [rsp+0]
add rax, 17
mov [rsp+130], rax
mov rax, [rax]
mov [rsp+138], rax
mov rax, [rsp+138]
mov rbx, __temp_str_0
mov rax, [rsp+130]
mov [rax], rbx
mov rax, rbx
mov [rsp+146], rax
mov rax, __temp_str_1
mov [rsp+154], rax
mov rax, rsp
add rax, 0
mov [rsp+162], rax
mov rax, [rsp+0]
add rax, 0
mov [rsp+170], rax
mov rax, [rax]
mov [rsp+178], rax
mov rax, [rsp+178]
mov [rsp+186], rax
mov rax, rsp
add rax, 0
mov [rsp+194], rax
mov rax, [rsp+0]
add rax, 8
mov [rsp+202], rax
mov rax, [rax]
mov [rsp+210], rax
mov rax, [rsp+210]
mov [rsp+218], rax
mov rax, rsp
add rax, 0
mov [rsp+226], rax
mov rax, [rsp+0]
add rax, 16
mov [rsp+234], rax
mov al, [rax]
mov [rsp+242], al
mov al, [rsp+242]
mov [rsp+243], al
mov rax, rsp
add rax, 0
mov [rsp+244], rax
mov rax, [rsp+0]
add rax, 17
mov [rsp+252], rax
mov rax, [rax]
mov [rsp+260], rax
mov rax, [rsp+260]
mov [rsp+268], rax
mov rdi, [rsp+154]
mov rsi, [rsp+186]
mov rdx, [rsp+218]
mov rcx, [rsp+243]
mov r8, [rsp+268]
mov rax, rsp
add rax, 0
mov [rsp+276], rax
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
