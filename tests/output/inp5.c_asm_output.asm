section .data
__temp_str_0 db `Arg %u: %s\n`, 0
__temp_str_1 db `%u\n`, 0
__temp_str_2 db `%u\n`, 0
__temp_str_3 db `%s`, 0
__main_size: equ 832
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
xor rax, rax
mov [rsp+56], rax
mov rax, [rsp+48]
mov [rsp+56], rax
;define variable a
mov rax, [rsp+56]
mov [rsp+16], rax
;end define variable a
;define variable i
mov rax, 0
mov [rsp+64], rax
;end define variable i
; enter loop
__tmp_label_4:
mov rax, rsp
add rax, 64
mov [rsp+72], rax
mov rax, [rsp+64]
mov rbx, 10
cmp rax, rbx
jl __tmp_label_6
mov rax, 0
jmp __tmp_label_7
__tmp_label_6:
mov rax, 1
__tmp_label_7:
mov [rsp+88], rax
mov rax, [rsp+88]
cmp rax, 0
je __tmp_label_5
mov rax, rsp
add rax, 16
mov [rsp+96], rax
mov rax, rsp
add rax, 64
mov [rsp+104], rax
mov rax, [rsp+64]
mov rbx, 8
mul rbx
mov rbx, [rsp+16]
add rbx, rax
mov [rsp+112], rbx
mov rax, [rbx]
mov [rsp+120], rax
mov rax, rsp
add rax, 64
mov [rsp+128], rax
mov rax, 2
mov rbx, [rsp+64]
mul rbx
mov [rsp+136], rax
mov rax, [rsp+120]
mov rbx, [rsp+136]
mov rax, [rsp+112]
mov [rax], rbx
mov rax, rbx
mov [rsp+144], rax
mov rax, rsp
add rax, 64
mov [rsp+152], rax
mov rax, rsp
add rax, 64
mov [rsp+160], rax
mov rax, [rsp+64]
mov rbx, 1
add rax, rbx
mov [rsp+168], rax
mov rax, [rsp+64]
mov rbx, [rsp+168]
mov rax, [rsp+152]
mov [rax], rbx
mov rax, rbx
mov [rsp+176], rax
jmp __tmp_label_4
__tmp_label_5:
; exit loop
;define variable i
mov rax, 0
mov [rsp+64], rax
;end define variable i
; enter loop
__tmp_label_8:
mov rax, rsp
add rax, 64
mov [rsp+72], rax
mov rax, [rsp+64]
mov rbx, 10
cmp rax, rbx
jl __tmp_label_10
mov rax, 0
jmp __tmp_label_11
__tmp_label_10:
mov rax, 1
__tmp_label_11:
mov [rsp+88], rax
mov rax, [rsp+88]
cmp rax, 0
je __tmp_label_9
mov rax, __temp_str_1
mov [rsp+96], rax
mov rax, rsp
add rax, 16
mov [rsp+104], rax
mov rax, rsp
add rax, 64
mov [rsp+112], rax
mov rax, [rsp+64]
mov rbx, 8
mul rbx
mov rbx, [rsp+16]
add rbx, rax
mov [rsp+120], rbx
mov rax, [rbx]
mov [rsp+128], rax
mov rax, [rsp+128]
mov [rsp+136], rax
mov rdi, [rsp+96]
mov rsi, [rsp+136]
mov rax, rsp
add rax, 0
mov [rsp+144], rax
call printf
mov rax, rsp
add rax, 64
mov [rsp+152], rax
mov rax, [rsp+64]
mov rbx, 1
add rax, rbx
mov rbx, [rsp+152]
mov [rbx], rax
mov [rsp+160], rax
jmp __tmp_label_8
__tmp_label_9:
; exit loop
mov rax, 1024
mov rbx, 8
mul rbx
mov [rsp+72], rax
mov rax, [rsp+72]
mov [rsp+80], rax
mov rdi, [rsp+80]
mov rax, rsp
add rax, 0
mov [rsp+88], rax
call malloc
mov [rsp+96], rax
xor rax, rax
mov [rsp+104], rax
mov rax, [rsp+96]
mov [rsp+104], rax
;define variable b
mov rax, [rsp+104]
mov [rsp+64], rax
;end define variable b
;define variable c
mov rax, 123
mov [rsp+112], rax
;end define variable c
mov rax, rsp
add rax, 64
mov [rsp+120], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+64]
add rbx, rax
mov [rsp+128], rbx
mov rax, [rbx]
mov [rsp+136], rax
mov rax, rsp
add rax, 112
mov [rsp+144], rax
mov rax, [rsp+144]
mov [rsp+152], rax
mov rax, [rsp+136]
mov rbx, [rsp+152]
mov rax, [rsp+128]
mov [rax], rbx
mov rax, rbx
mov [rsp+160], rax
mov rax, rsp
add rax, 64
mov [rsp+168], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+64]
add rbx, rax
mov [rsp+176], rbx
mov rax, [rbx]
mov [rsp+184], rax
mov rax, [rsp+184]
mov [rsp+192], rax
mov rax, [rax]
mov [rsp+200], rax
mov rax, rsp
add rax, 64
mov [rsp+208], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+64]
add rbx, rax
mov [rsp+216], rbx
mov rax, [rbx]
mov [rsp+224], rax
mov rax, [rsp+224]
mov [rsp+232], rax
mov rax, [rax]
mov [rsp+240], rax
mov rax, [rsp+240]
mov rbx, 2
mul rbx
mov [rsp+248], rax
mov rax, [rsp+200]
mov rbx, [rsp+248]
mov rax, [rsp+192]
mov [rax], rbx
mov rax, rbx
mov [rsp+256], rax
mov rax, __temp_str_2
mov [rsp+264], rax
mov rax, rsp
add rax, 112
mov [rsp+272], rax
mov rax, [rsp+112]
mov [rsp+280], rax
mov rdi, [rsp+264]
mov rsi, [rsp+280]
mov rax, rsp
add rax, 0
mov [rsp+288], rax
call printf
mov rax, 20
mov rbx, 1
mul rbx
mov [rsp+304], rax
mov rax, [rsp+304]
mov [rsp+312], rax
mov rdi, [rsp+312]
mov rax, rsp
add rax, 0
mov [rsp+320], rax
call malloc
mov [rsp+328], rax
xor rax, rax
mov [rsp+336], rax
mov rax, [rsp+328]
mov [rsp+336], rax
;define variable str
mov rax, [rsp+336]
mov [rsp+296], rax
;end define variable str
mov rax, rsp
add rax, 296
mov [rsp+344], rax
mov rax, 0
mov rbx, 1
mul rbx
mov rbx, [rsp+296]
add rbx, rax
mov [rsp+352], rbx
mov al, [rbx]
mov [rsp+360], al
mov al, [rsp+360]
mov bl, 104
mov rax, [rsp+352]
mov [rax], bl
mov al, bl
mov [rsp+361], al
mov rax, rsp
add rax, 296
mov [rsp+362], rax
mov rax, 1
mov rbx, 1
mul rbx
mov rbx, [rsp+296]
add rbx, rax
mov [rsp+370], rbx
mov al, [rbx]
mov [rsp+378], al
mov al, [rsp+378]
mov bl, 105
mov rax, [rsp+370]
mov [rax], bl
mov al, bl
mov [rsp+379], al
mov rax, rsp
add rax, 296
mov [rsp+380], rax
mov rax, 2
mov rbx, 1
mul rbx
mov rbx, [rsp+296]
add rbx, rax
mov [rsp+388], rbx
mov al, [rbx]
mov [rsp+396], al
mov al, [rsp+396]
mov bl, 33
mov rax, [rsp+388]
mov [rax], bl
mov al, bl
mov [rsp+397], al
mov rax, rsp
add rax, 296
mov [rsp+398], rax
mov rax, 3
mov rbx, 1
mul rbx
mov rbx, [rsp+296]
add rbx, rax
mov [rsp+406], rbx
mov al, [rbx]
mov [rsp+414], al
mov al, [rsp+414]
mov bl, 10
mov rax, [rsp+406]
mov [rax], bl
mov al, bl
mov [rsp+415], al
mov rax, rsp
add rax, 296
mov [rsp+416], rax
mov rax, 4
mov rbx, 1
mul rbx
mov rbx, [rsp+296]
add rbx, rax
mov [rsp+424], rbx
mov al, [rbx]
mov [rsp+432], al
mov al, [rsp+432]
mov bl, 0
mov rax, [rsp+424]
mov [rax], bl
mov al, bl
mov [rsp+433], al
mov rax, __temp_str_3
mov [rsp+434], rax
mov rax, rsp
add rax, 296
mov [rsp+442], rax
mov rax, [rsp+296]
mov [rsp+450], rax
mov rdi, [rsp+434]
mov rsi, [rsp+450]
mov rax, rsp
add rax, 0
mov [rsp+458], rax
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
