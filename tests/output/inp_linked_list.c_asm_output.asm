section .data
__new_list_size: equ 64
__add_val_size: equ 384
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
;define variable ret
mov rax, [rsp+32]
mov [rsp+0], rax
;end define variable ret
mov rax, rsp
add rax, 0
mov [rsp+40], rax
mov rax, [rsp+0]
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
mov [rsp+0], rdi
mov [rsp+8], rsi
mov rax, 16
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
;define variable new
mov rax, [rsp+48]
mov [rsp+16], rax
;end define variable new
mov rax, rsp
add rax, 16
mov [rsp+56], rax
mov rax, [rsp+16]
add rax, 8
mov [rsp+64], rax
mov rax, [rax]
mov [rsp+72], rax
mov rax, [rsp+64]
mov [rsp+80], rax
xor rax, rax
mov [rsp+88], rax
mov rax, [rsp+80]
mov [rsp+88], rax
mov rax, [rsp+88]
mov [rsp+96], rax
mov rax, [rax]
mov [rsp+104], rax
mov rax, [rsp+104]
mov rbx, 0
mov rax, [rsp+96]
mov [rax], rbx
mov rax, rbx
mov [rsp+112], rax
mov rax, rsp
add rax, 16
mov [rsp+120], rax
mov rax, [rsp+16]
add rax, 0
mov [rsp+128], rax
mov rax, [rax]
mov [rsp+136], rax
mov rax, rsp
add rax, 8
mov [rsp+144], rax
mov rax, [rsp+136]
mov rbx, [rsp+8]
mov rax, [rsp+128]
mov [rax], rbx
mov rax, rbx
mov [rsp+152], rax
mov rax, rsp
add rax, 0
mov [rsp+160], rax
mov rax, [rsp+0]
add rax, 0
mov [rsp+168], rax
mov rax, [rax]
mov [rsp+176], rax
mov rax, 0
cmp rax, [rsp+176]
je __tmp_label_0
mov rax, rsp
add rax, 0
mov [rsp+192], rax
mov rax, [rsp+0]
add rax, 0
mov [rsp+200], rax
mov rax, [rax]
mov [rsp+208], rax
;define variable curr
mov rax, [rsp+208]
mov [rsp+184], rax
;end define variable curr
; enter loop
__tmp_label_2:
mov rax, rsp
add rax, 184
mov [rsp+216], rax
mov rax, [rsp+184]
add rax, 8
mov [rsp+224], rax
mov rax, [rax]
mov [rsp+232], rax
mov rax, [rsp+232]
cmp rax, 0
je __tmp_label_3
mov rax, rsp
add rax, 184
mov [rsp+240], rax
mov rax, rsp
add rax, 184
mov [rsp+248], rax
mov rax, [rsp+184]
add rax, 8
mov [rsp+256], rax
mov rax, [rax]
mov [rsp+264], rax
xor rax, rax
mov [rsp+272], rax
mov rax, [rsp+264]
mov [rsp+272], rax
mov rax, [rsp+184]
mov rbx, [rsp+272]
mov rax, [rsp+240]
mov [rax], rbx
mov rax, rbx
mov [rsp+280], rax
jmp __tmp_label_2
__tmp_label_3:
; exit loop
mov rax, rsp
add rax, 184
mov [rsp+240], rax
mov rax, [rsp+184]
add rax, 8
mov [rsp+248], rax
mov rax, [rax]
mov [rsp+256], rax
mov rax, rsp
add rax, 16
mov [rsp+264], rax
mov rax, [rsp+256]
mov rbx, [rsp+16]
mov rax, [rsp+248]
mov [rax], rbx
mov rax, rbx
mov [rsp+272], rax
jmp __tmp_label_1
__tmp_label_0:
mov rax, rsp
add rax, 0
mov [rsp+184], rax
mov rax, [rsp+0]
add rax, 0
mov [rsp+192], rax
mov rax, [rax]
mov [rsp+200], rax
mov rax, rsp
add rax, 16
mov [rsp+208], rax
mov rax, [rsp+200]
mov rbx, [rsp+16]
mov rax, [rsp+192]
mov [rax], rbx
mov rax, rbx
mov [rsp+216], rax
__tmp_label_1:
mov rsp, rbp
pop rbp
ret
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
mov rax, rsp
add rax, 0
mov [rsp+8], rax
call new_list
mov [rsp+16], rax
;define variable lst
mov rax, [rsp+16]
mov [rsp+0], rax
;end define variable lst
mov rax, rsp
add rax, 0
mov [rsp+24], rax
mov rax, [rsp+0]
mov [rsp+32], rax
mov rax, 123
mov [rsp+40], rax
mov rdi, [rsp+32]
mov rsi, [rsp+40]
mov rax, rsp
add rax, 0
mov [rsp+48], rax
call add_val
mov rax, rsp
add rax, 0
mov [rsp+56], rax
mov rax, [rsp+0]
mov [rsp+64], rax
mov rax, 432
mov [rsp+72], rax
mov rdi, [rsp+64]
mov rsi, [rsp+72]
mov rax, rsp
add rax, 0
mov [rsp+80], rax
call add_val
mov rax, rsp
add rax, 0
mov [rsp+88], rax
mov rax, [rsp+0]
mov [rsp+96], rax
mov rax, 999
mov [rsp+104], rax
mov rdi, [rsp+96]
mov rsi, [rsp+104]
mov rax, rsp
add rax, 0
mov [rsp+112], rax
call add_val
mov rax, rsp
add rax, 0
mov [rsp+120], rax
mov rax, [rsp+0]
mov [rsp+128], rax
mov rax, 873
mov [rsp+136], rax
mov rdi, [rsp+128]
mov rsi, [rsp+136]
mov rax, rsp
add rax, 0
mov [rsp+144], rax
call add_val
mov rax, rsp
add rax, 0
mov [rsp+160], rax
mov rax, [rsp+0]
add rax, 0
mov [rsp+168], rax
mov rax, [rax]
mov [rsp+176], rax
;define variable curr
mov rax, [rsp+176]
mov [rsp+152], rax
;end define variable curr
; enter loop
__tmp_label_4:
mov rax, rsp
add rax, 152
mov [rsp+184], rax
mov rax, [rsp+152]
cmp rax, 0
je __tmp_label_5
mov rax, __temp_str_2
mov [rsp+192], rax
mov rax, rsp
add rax, 152
mov [rsp+200], rax
mov rax, [rsp+152]
add rax, 0
mov [rsp+208], rax
mov rax, [rax]
mov [rsp+216], rax
mov rax, [rsp+216]
mov [rsp+224], rax
mov rdi, [rsp+192]
mov rsi, [rsp+224]
mov rax, rsp
add rax, 0
mov [rsp+232], rax
call printf
mov rax, rsp
add rax, 152
mov [rsp+240], rax
mov rax, rsp
add rax, 152
mov [rsp+248], rax
mov rax, [rsp+152]
add rax, 8
mov [rsp+256], rax
mov rax, [rax]
mov [rsp+264], rax
xor rax, rax
mov [rsp+272], rax
mov rax, [rsp+264]
mov [rsp+272], rax
mov rax, [rsp+152]
mov rbx, [rsp+272]
mov rax, [rsp+240]
mov [rax], rbx
mov rax, rbx
mov [rsp+280], rax
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
