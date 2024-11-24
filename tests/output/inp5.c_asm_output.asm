section .data
__temp_str_0 db `Arg %u: %s\n`, 0
__temp_str_1 db `%u\n`, 0
__temp_str_2 db `%u\n`, 0
__temp_str_3 db `%s`, 0
__main_size: equ 800
section .text
extern printf
extern malloc
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
mov [rsp+0], rdi
mov [rsp+8], rsi
;define variable i
mov rax, 0
mov [rsp+16], rax
;end define variable i
; enter loop
__tmp_label_0:
mov rax, rsp
add rax, 16
mov [rsp+24], rax
mov rax, rsp
add rax, 0
mov [rsp+32], rax
mov rax, [rsp+16]
mov rbx, [rsp+0]
cmp rax, rbx
jl __tmp_label_2
mov rax, 0
jmp __tmp_label_3
__tmp_label_2:
mov rax, 1
__tmp_label_3:
mov [rsp+48], rax
mov rax, [rsp+48]
cmp rax, 0
je __tmp_label_1
mov rax, __temp_str_0
mov [rsp+56], rax
mov rax, rsp
add rax, 16
mov [rsp+64], rax
mov rax, [rsp+16]
mov [rsp+72], rax
mov rax, rsp
add rax, 8
mov [rsp+80], rax
mov rax, rsp
add rax, 16
mov [rsp+88], rax
mov rax, [rsp+16]
mov rbx, 8
mul rbx
mov rbx, [rsp+8]
add rbx, rax
mov [rsp+96], rbx
mov rax, [rbx]
mov [rsp+104], rax
mov rax, [rsp+104]
mov [rsp+112], rax
mov rdi, [rsp+56]
mov rsi, [rsp+72]
mov rdx, [rsp+112]
mov rax, rsp
add rax, 0
mov [rsp+120], rax
call printf
mov rax, rsp
add rax, 16
mov [rsp+56], rax
mov rax, [rsp+16]
mov rbx, 1
add rax, rbx
mov rbx, [rsp+56]
mov [rbx], rax
mov [rsp+64], rax
jmp __tmp_label_0
__tmp_label_1:
; exit loop
mov rax, 10
mov rbx, 8
mul rbx
mov [rsp+24], rax
mov rax, [rsp+24]
mov [rsp+32], rax
mov rdi, [rsp+32]
mov rax, rsp
add rax, 0
mov [rsp+40], rax
call malloc
mov [rsp+48], rax
;define variable a
mov rax, [rsp+48]
mov [rsp+16], rax
;end define variable a
;define variable i
mov rax, 0
mov [rsp+56], rax
;end define variable i
; enter loop
__tmp_label_4:
mov rax, rsp
add rax, 56
mov [rsp+64], rax
mov rax, [rsp+56]
mov rbx, 10
cmp rax, rbx
jl __tmp_label_6
mov rax, 0
jmp __tmp_label_7
__tmp_label_6:
mov rax, 1
__tmp_label_7:
mov [rsp+80], rax
mov rax, [rsp+80]
cmp rax, 0
je __tmp_label_5
mov rax, rsp
add rax, 16
mov [rsp+88], rax
mov rax, rsp
add rax, 56
mov [rsp+96], rax
mov rax, [rsp+56]
mov rbx, 8
mul rbx
mov rbx, [rsp+16]
add rbx, rax
mov [rsp+104], rbx
mov rax, [rbx]
mov [rsp+112], rax
mov rax, rsp
add rax, 56
mov [rsp+120], rax
mov rax, 2
mov rbx, [rsp+56]
mul rbx
mov [rsp+128], rax
mov rax, [rsp+112]
mov rbx, [rsp+128]
mov rax, [rsp+104]
mov [rax], rbx
mov rax, rbx
mov [rsp+136], rax
mov rax, rsp
add rax, 56
mov [rsp+144], rax
mov rax, rsp
add rax, 56
mov [rsp+152], rax
mov rax, [rsp+56]
mov rbx, 1
add rax, rbx
mov [rsp+160], rax
mov rax, [rsp+56]
mov rbx, [rsp+160]
mov rax, [rsp+144]
mov [rax], rbx
mov rax, rbx
mov [rsp+168], rax
jmp __tmp_label_4
__tmp_label_5:
; exit loop
;define variable i
mov rax, 0
mov [rsp+56], rax
;end define variable i
; enter loop
__tmp_label_8:
mov rax, rsp
add rax, 56
mov [rsp+64], rax
mov rax, [rsp+56]
mov rbx, 10
cmp rax, rbx
jl __tmp_label_10
mov rax, 0
jmp __tmp_label_11
__tmp_label_10:
mov rax, 1
__tmp_label_11:
mov [rsp+80], rax
mov rax, [rsp+80]
cmp rax, 0
je __tmp_label_9
mov rax, __temp_str_1
mov [rsp+88], rax
mov rax, rsp
add rax, 16
mov [rsp+96], rax
mov rax, rsp
add rax, 56
mov [rsp+104], rax
mov rax, [rsp+56]
mov rbx, 8
mul rbx
mov rbx, [rsp+16]
add rbx, rax
mov [rsp+112], rbx
mov rax, [rbx]
mov [rsp+120], rax
mov rax, [rsp+120]
mov [rsp+128], rax
mov rdi, [rsp+88]
mov rsi, [rsp+128]
mov rax, rsp
add rax, 0
mov [rsp+136], rax
call printf
mov rax, rsp
add rax, 56
mov [rsp+144], rax
mov rax, [rsp+56]
mov rbx, 1
add rax, rbx
mov rbx, [rsp+144]
mov [rbx], rax
mov [rsp+152], rax
jmp __tmp_label_8
__tmp_label_9:
; exit loop
mov rax, 1024
mov rbx, 8
mul rbx
mov [rsp+64], rax
mov rax, [rsp+64]
mov [rsp+72], rax
mov rdi, [rsp+72]
mov rax, rsp
add rax, 0
mov [rsp+80], rax
call malloc
mov [rsp+88], rax
;define variable b
mov rax, [rsp+88]
mov [rsp+56], rax
;end define variable b
;define variable c
mov rax, 123
mov [rsp+96], rax
;end define variable c
mov rax, rsp
add rax, 56
mov [rsp+104], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+56]
add rbx, rax
mov [rsp+112], rbx
mov rax, [rbx]
mov [rsp+120], rax
mov rax, rsp
add rax, 96
mov [rsp+128], rax
mov rax, [rsp+128]
mov [rsp+136], rax
mov rax, [rsp+120]
mov rbx, [rsp+136]
mov rax, [rsp+112]
mov [rax], rbx
mov rax, rbx
mov [rsp+144], rax
mov rax, rsp
add rax, 56
mov [rsp+152], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+56]
add rbx, rax
mov [rsp+160], rbx
mov rax, [rbx]
mov [rsp+168], rax
mov rax, [rsp+168]
mov [rsp+176], rax
mov rax, [rax]
mov [rsp+184], rax
mov rax, rsp
add rax, 56
mov [rsp+192], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+56]
add rbx, rax
mov [rsp+200], rbx
mov rax, [rbx]
mov [rsp+208], rax
mov rax, [rsp+208]
mov [rsp+216], rax
mov rax, [rax]
mov [rsp+224], rax
mov rax, [rsp+224]
mov rbx, 2
mul rbx
mov [rsp+232], rax
mov rax, [rsp+184]
mov rbx, [rsp+232]
mov rax, [rsp+176]
mov [rax], rbx
mov rax, rbx
mov [rsp+240], rax
mov rax, __temp_str_2
mov [rsp+248], rax
mov rax, rsp
add rax, 96
mov [rsp+256], rax
mov rax, [rsp+96]
mov [rsp+264], rax
mov rdi, [rsp+248]
mov rsi, [rsp+264]
mov rax, rsp
add rax, 0
mov [rsp+272], rax
call printf
mov rax, 20
mov rbx, 1
mul rbx
mov [rsp+288], rax
mov rax, [rsp+288]
mov [rsp+296], rax
mov rdi, [rsp+296]
mov rax, rsp
add rax, 0
mov [rsp+304], rax
call malloc
mov [rsp+312], rax
;define variable str
mov rax, [rsp+312]
mov [rsp+280], rax
;end define variable str
mov rax, rsp
add rax, 280
mov [rsp+320], rax
mov rax, 0
mov rbx, 1
mul rbx
mov rbx, [rsp+280]
add rbx, rax
mov [rsp+328], rbx
mov al, [rbx]
mov [rsp+336], al
mov al, [rsp+336]
mov bl, 104
mov rax, [rsp+328]
mov [rax], bl
mov al, bl
mov [rsp+337], al
mov rax, rsp
add rax, 280
mov [rsp+338], rax
mov rax, 1
mov rbx, 1
mul rbx
mov rbx, [rsp+280]
add rbx, rax
mov [rsp+346], rbx
mov al, [rbx]
mov [rsp+354], al
mov al, [rsp+354]
mov bl, 105
mov rax, [rsp+346]
mov [rax], bl
mov al, bl
mov [rsp+355], al
mov rax, rsp
add rax, 280
mov [rsp+356], rax
mov rax, 2
mov rbx, 1
mul rbx
mov rbx, [rsp+280]
add rbx, rax
mov [rsp+364], rbx
mov al, [rbx]
mov [rsp+372], al
mov al, [rsp+372]
mov bl, 33
mov rax, [rsp+364]
mov [rax], bl
mov al, bl
mov [rsp+373], al
mov rax, rsp
add rax, 280
mov [rsp+374], rax
mov rax, 3
mov rbx, 1
mul rbx
mov rbx, [rsp+280]
add rbx, rax
mov [rsp+382], rbx
mov al, [rbx]
mov [rsp+390], al
mov al, [rsp+390]
mov bl, 10
mov rax, [rsp+382]
mov [rax], bl
mov al, bl
mov [rsp+391], al
mov rax, rsp
add rax, 280
mov [rsp+392], rax
mov rax, 4
mov rbx, 1
mul rbx
mov rbx, [rsp+280]
add rbx, rax
mov [rsp+400], rbx
mov al, [rbx]
mov [rsp+408], al
mov al, [rsp+408]
mov bl, 0
mov rax, [rsp+400]
mov [rax], bl
mov al, bl
mov [rsp+409], al
mov rax, __temp_str_3
mov [rsp+410], rax
mov rax, rsp
add rax, 280
mov [rsp+418], rax
mov rax, [rsp+280]
mov [rsp+426], rax
mov rdi, [rsp+410]
mov rsi, [rsp+426]
mov rax, rsp
add rax, 0
mov [rsp+434], rax
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
