section .data
__printf_size: equ 16
__temp_str_1 db `1`, 0
__temp_str_2 db `Excellent!\n`, 0
__temp_str_3 db `Well done\n`, 0
__temp_str_4 db `You passed\n`, 0
__temp_str_5 db `Better try again\n`, 0
__temp_str_6 db `Invalid grade\n`, 0
__temp_str_7 db `default case\n`, 0
__temp_str_8 db `is two\n`, 0
__temp_str_9 db `%s\n`, 0
__main_size: equ 176
section .text
extern printf
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
;define variable grade
mov rax, 66
mov [rsp+0], rax
;end define variable grade
;start switch
mov rax, rsp
add rax, 0
mov [rsp+9], rax
mov rax, [rsp+0]
cmp rax, 65
je case___tmp_label_0_1
cmp rax, 66
je case___tmp_label_0_3
cmp rax, 67
je case___tmp_label_0_3
cmp rax, 68
je case___tmp_label_0_5
cmp rax, 70
je case___tmp_label_0_7
jmp case___tmp_label_0_9
; stmt loc 0
mov rax, __temp_str_1
mov [rsp+10], rax
mov rdi, [rsp+10]
mov rax, rsp
add rax, 0
mov [rsp+18], rax
call printf
mov [rsp+26], rax
; stmt loc 1
case___tmp_label_0_1:
mov rax, rsp
add rax, 1
mov [rsp+26], rax
mov rax, [rsp+1]
mov rbx, __temp_str_2
mov rax, __temp_str_2
mov rbx, [rsp+26]
mov [rbx], rax
mov [rsp+34], rax
; stmt loc 2
jmp __tmp_label_0
; stmt loc 3
case___tmp_label_0_3:
case___tmp_label_0_3:
mov rax, rsp
add rax, 1
mov [rsp+42], rax
mov rax, [rsp+1]
mov rbx, __temp_str_3
mov rax, __temp_str_3
mov rbx, [rsp+42]
mov [rbx], rax
mov [rsp+50], rax
; stmt loc 4
jmp __tmp_label_0
; stmt loc 5
case___tmp_label_0_5:
mov rax, rsp
add rax, 1
mov [rsp+58], rax
mov rax, [rsp+1]
mov rbx, __temp_str_4
mov rax, __temp_str_4
mov rbx, [rsp+58]
mov [rbx], rax
mov [rsp+66], rax
; stmt loc 6
jmp __tmp_label_0
; stmt loc 7
case___tmp_label_0_7:
mov rax, rsp
add rax, 1
mov [rsp+74], rax
mov rax, [rsp+1]
mov rbx, __temp_str_5
mov rax, __temp_str_5
mov rbx, [rsp+74]
mov [rbx], rax
mov [rsp+82], rax
; stmt loc 8
jmp __tmp_label_0
; stmt loc 9
case___tmp_label_0_9:
mov rax, rsp
add rax, 1
mov [rsp+90], rax
mov rax, [rsp+1]
mov rbx, __temp_str_6
mov rax, __temp_str_6
mov rbx, [rsp+90]
mov [rbx], rax
mov [rsp+98], rax
; end switch
__tmp_label_0:
;start switch
mov rax, 1
jmp case___tmp_label_1_0
; stmt loc 0
case___tmp_label_1_0:
mov rax, __temp_str_7
mov [rsp+106], rax
mov rdi, [rsp+106]
mov rax, rsp
add rax, 0
mov [rsp+114], rax
call printf
mov [rsp+122], rax
; end switch
__tmp_label_1:
;start switch
mov rax, 2
cmp rax, 2
je case___tmp_label_2_0
jmp case___tmp_label_2_0
; stmt loc 0
case___tmp_label_2_0:
case___tmp_label_2_0:
mov rax, __temp_str_8
mov [rsp+122], rax
mov rdi, [rsp+122]
mov rax, rsp
add rax, 0
mov [rsp+130], rax
call printf
mov [rsp+138], rax
; end switch
__tmp_label_2:
mov rax, __temp_str_9
mov [rsp+138], rax
mov rax, rsp
add rax, 1
mov [rsp+146], rax
mov rax, [rsp+1]
mov [rsp+154], rax
mov rdi, [rsp+138]
mov rsi, [rsp+154]
mov rax, rsp
add rax, 0
mov [rsp+162], rax
call printf
mov [rsp+170], rax
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
