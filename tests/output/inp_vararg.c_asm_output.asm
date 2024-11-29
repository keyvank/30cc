section .data
__cc_asprintf_size: equ 112
__temp_str_1 db `salam %s %u%c`, 0
__temp_str_2 db `donya`, 0
__temp_str_3 db `%s %s\n`, 0
__temp_str_4 db `haha`, 0
__main_size: equ 96
section .text
extern malloc
extern printf
extern sprintf
global cc_asprintf
cc_asprintf:
push rbp
mov rbp, rsp
sub rsp, __cc_asprintf_size
mov [rbp-8], rdi
mov r9, r8
mov r8, rcx
mov rcx, rdx
mov rdx, rsi
mov rsi, rdi
mov rdi, 0
push rdi
push rsi
push rdx
push rcx
push r8
push r9
mov rax, 128
mov [rbp-24], rax
mov rdi, [rbp-24]
mov rax, rbp
sub rax, 8
mov [rbp-32], rax
call malloc
mov [rbp-40], rax
xor rax, rax
mov [rbp-48], rax
mov rax, [rbp-40]
mov [rbp-48], rax
;define variable ret
mov rax, [rbp-48]
mov [rbp-16], rax
;end define variable ret
pop r9
pop r8
pop rcx
pop rdx
pop rsi
pop rdi
mov rax, rbp
sub rax, 16
mov [rbp-56], rax
mov rax, [rbp-16]
mov [rbp-64], rax
mov rax, rbp
sub rax, 8
mov [rbp-72], rax
mov rax, [rbp-8]
mov [rbp-80], rax
mov rdi, [rbp-64]
mov rsi, [rbp-80]
mov rax, rbp
sub rax, 8
mov [rbp-88], rax
call sprintf
mov rax, rbp
sub rax, 16
mov [rbp-96], rax
mov rax, [rbp-16]
mov rsp, rbp
pop rbp
ret
mov rsp, rbp
pop rbp
ret
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
mov rax, __temp_str_1
mov [rbp-16], rax
mov rax, __temp_str_2
mov [rbp-24], rax
mov rax, 123
mov [rbp-32], rax
mov al, 33
mov [rbp-33], al
mov rdi, [rbp-16]
mov rsi, [rbp-24]
mov rdx, [rbp-32]
mov rcx, [rbp-33]
mov rax, rbp
sub rax, 8
mov [rbp-41], rax
call cc_asprintf
mov [rbp-49], rax
;define variable ret
mov rax, [rbp-49]
mov [rbp-8], rax
;end define variable ret
mov rax, __temp_str_3
mov [rbp-57], rax
mov rax, __temp_str_4
mov [rbp-65], rax
mov rax, rbp
sub rax, 8
mov [rbp-73], rax
mov rax, [rbp-8]
mov [rbp-81], rax
mov rdi, [rbp-57]
mov rsi, [rbp-65]
mov rdx, [rbp-81]
mov rax, rbp
sub rax, 8
mov [rbp-89], rax
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
