section .data
__new_list_size: equ 64
__add_val_size: equ 416
__temp_str_2 db `%u\n`, 0
__main_size: equ 304
section .text
extern malloc
extern printf
global new_list
new_list:
push rbp
mov rbp, rsp
sub rsp, __new_list_size
mov rax, 8
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
;define variable ret
mov rax, [rbp-40]
mov [rbp-8], rax
;end define variable ret
mov rax, rbp
sub rax, 8
mov [rbp-48], rax
mov rax, [rbp-8]
mov rsp, rbp
pop rbp
ret
mov rsp, rbp
pop rbp
ret
global add_val
add_val:
push rbp
mov rbp, rsp
sub rsp, __add_val_size
mov [rbp-8], rdi
mov [rbp-16], rsi
mov rax, 16
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
;define variable new
mov rax, [rbp-56]
mov [rbp-24], rax
;end define variable new
mov rax, rbp
sub rax, 24
mov [rbp-64], rax
mov rax, [rbp-24]
add rax, 8
mov [rbp-72], rax
mov rax, [rax]
mov [rbp-80], rax
mov rax, [rbp-72]
mov [rbp-88], rax
xor rax, rax
mov [rbp-96], rax
mov rax, [rbp-88]
mov [rbp-96], rax
mov rax, [rbp-96]
mov [rbp-104], rax
mov rax, [rax]
mov [rbp-112], rax
mov rax, [rbp-112]
mov rbx, 0
mov rax, [rbp-104]
mov [rax], rbx
mov rax, rbx
mov [rbp-128], rax
mov rax, rbp
sub rax, 24
mov [rbp-136], rax
mov rax, [rbp-24]
add rax, 0
mov [rbp-144], rax
mov rax, [rax]
mov [rbp-152], rax
mov rax, rbp
sub rax, 16
mov [rbp-160], rax
mov rax, [rbp-152]
mov rbx, [rbp-16]
mov rax, [rbp-144]
mov [rax], rbx
mov rax, rbx
mov [rbp-176], rax
mov rax, rbp
sub rax, 8
mov [rbp-184], rax
mov rax, [rbp-8]
add rax, 0
mov [rbp-192], rax
mov rax, [rax]
mov [rbp-200], rax
mov rax, 0
cmp rax, [rbp-200]
je __tmp_label_0
mov rax, rbp
sub rax, 8
mov [rbp-216], rax
mov rax, [rbp-8]
add rax, 0
mov [rbp-224], rax
mov rax, [rax]
mov [rbp-232], rax
;define variable curr
mov rax, [rbp-232]
mov [rbp-208], rax
;end define variable curr
; enter loop
__tmp_label_2:
mov rax, rbp
sub rax, 208
mov [rbp-240], rax
mov rax, [rbp-208]
add rax, 8
mov [rbp-248], rax
mov rax, [rax]
mov [rbp-256], rax
mov rax, [rbp-256]
cmp rax, 0
je __tmp_label_3
mov rax, rbp
sub rax, 208
mov [rbp-264], rax
mov rax, rbp
sub rax, 208
mov [rbp-272], rax
mov rax, [rbp-208]
add rax, 8
mov [rbp-280], rax
mov rax, [rax]
mov [rbp-288], rax
xor rax, rax
mov [rbp-296], rax
mov rax, [rbp-288]
mov [rbp-296], rax
mov rax, [rbp-208]
mov rbx, [rbp-296]
mov rax, [rbp-264]
mov [rax], rbx
mov rax, rbx
mov [rbp-304], rax
jmp __tmp_label_2
__tmp_label_3:
; exit loop
mov rax, rbp
sub rax, 208
mov [rbp-264], rax
mov rax, [rbp-208]
add rax, 8
mov [rbp-272], rax
mov rax, [rax]
mov [rbp-280], rax
mov rax, rbp
sub rax, 24
mov [rbp-288], rax
mov rax, [rbp-280]
mov rbx, [rbp-24]
mov rax, [rbp-272]
mov [rax], rbx
mov rax, rbx
mov [rbp-296], rax
jmp __tmp_label_1
__tmp_label_0:
mov rax, rbp
sub rax, 8
mov [rbp-208], rax
mov rax, [rbp-8]
add rax, 0
mov [rbp-216], rax
mov rax, [rax]
mov [rbp-224], rax
mov rax, rbp
sub rax, 24
mov [rbp-232], rax
mov rax, [rbp-224]
mov rbx, [rbp-24]
mov rax, [rbp-216]
mov [rax], rbx
mov rax, rbx
mov [rbp-240], rax
__tmp_label_1:
mov rsp, rbp
pop rbp
ret
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
mov rax, rbp
sub rax, 8
mov [rbp-16], rax
call new_list
mov [rbp-24], rax
;define variable lst
mov rax, [rbp-24]
mov [rbp-8], rax
;end define variable lst
mov rax, rbp
sub rax, 8
mov [rbp-32], rax
mov rax, [rbp-8]
mov [rbp-40], rax
mov rax, 123
mov [rbp-48], rax
mov rdi, [rbp-40]
mov rsi, [rbp-48]
mov rax, rbp
sub rax, 8
mov [rbp-56], rax
call add_val
mov rax, rbp
sub rax, 8
mov [rbp-64], rax
mov rax, [rbp-8]
mov [rbp-72], rax
mov rax, 432
mov [rbp-80], rax
mov rdi, [rbp-72]
mov rsi, [rbp-80]
mov rax, rbp
sub rax, 8
mov [rbp-88], rax
call add_val
mov rax, rbp
sub rax, 8
mov [rbp-96], rax
mov rax, [rbp-8]
mov [rbp-104], rax
mov rax, 999
mov [rbp-112], rax
mov rdi, [rbp-104]
mov rsi, [rbp-112]
mov rax, rbp
sub rax, 8
mov [rbp-120], rax
call add_val
mov rax, rbp
sub rax, 8
mov [rbp-128], rax
mov rax, [rbp-8]
mov [rbp-136], rax
mov rax, 873
mov [rbp-144], rax
mov rdi, [rbp-136]
mov rsi, [rbp-144]
mov rax, rbp
sub rax, 8
mov [rbp-152], rax
call add_val
mov rax, rbp
sub rax, 8
mov [rbp-168], rax
mov rax, [rbp-8]
add rax, 0
mov [rbp-176], rax
mov rax, [rax]
mov [rbp-184], rax
;define variable curr
mov rax, [rbp-184]
mov [rbp-160], rax
;end define variable curr
; enter loop
__tmp_label_4:
mov rax, rbp
sub rax, 160
mov [rbp-192], rax
mov rax, [rbp-160]
cmp rax, 0
je __tmp_label_5
mov rax, __temp_str_2
mov [rbp-200], rax
mov rax, rbp
sub rax, 160
mov [rbp-208], rax
mov rax, [rbp-160]
add rax, 0
mov [rbp-216], rax
mov rax, [rax]
mov [rbp-224], rax
mov rax, [rbp-224]
mov [rbp-232], rax
mov rdi, [rbp-200]
mov rsi, [rbp-232]
mov rax, rbp
sub rax, 8
mov [rbp-240], rax
call printf
mov rax, rbp
sub rax, 160
mov [rbp-248], rax
mov rax, rbp
sub rax, 160
mov [rbp-256], rax
mov rax, [rbp-160]
add rax, 8
mov [rbp-264], rax
mov rax, [rax]
mov [rbp-272], rax
xor rax, rax
mov [rbp-280], rax
mov rax, [rbp-272]
mov [rbp-280], rax
mov rax, [rbp-160]
mov rbx, [rbp-280]
mov rax, [rbp-248]
mov [rax], rbx
mov rax, rbx
mov [rbp-288], rax
jmp __tmp_label_4
__tmp_label_5:
; exit loop
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
