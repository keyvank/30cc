section .data
__temp_str_0 db `1`, 0
__temp_str_1 db `Excellent!\n`, 0
__temp_str_2 db `Well done\n`, 0
__temp_str_3 db `You passed\n`, 0
__temp_str_4 db `Better try again\n`, 0
__temp_str_5 db `Invalid grade\n`, 0
__temp_str_6 db `default case\n`, 0
__temp_str_7 db `is two\n`, 0
__temp_str_8 db `%s\n`, 0
__main_size: equ 224
section .text
extern printf
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
;define variable grade
mov al, 66
mov [rbp-1], al
;end define variable grade
;start switch
mov rax, rbp
sub rax, 1
mov [rbp-17], rax
mov al, [rbp-1]
cmp al, 65
je case___tmp_label_0_1
cmp al, 66
je case___tmp_label_0_3
cmp al, 67
je case___tmp_label_0_3
cmp al, 68
je case___tmp_label_0_5
cmp al, 70
je case___tmp_label_0_7
jmp case___tmp_label_0_9
; stmt loc 0
mov rax, __temp_str_0
mov [rbp-25], rax
mov rdi, [rbp-25]
mov rax, rbp
sub rax, 8
mov [rbp-33], rax
call printf
; stmt loc 1
case___tmp_label_0_1:
mov rax, rbp
sub rax, 9
mov [rbp-41], rax
mov rax, [rbp-9]
mov rbx, __temp_str_1
mov rax, [rbp-41]
mov [rax], rbx
mov rax, rbx
mov [rbp-49], rax
; stmt loc 2
jmp __tmp_label_0
; stmt loc 3
case___tmp_label_0_3:
case___tmp_label_0_3:
mov rax, rbp
sub rax, 9
mov [rbp-65], rax
mov rax, [rbp-9]
mov rbx, __temp_str_2
mov rax, [rbp-65]
mov [rax], rbx
mov rax, rbx
mov [rbp-73], rax
; stmt loc 4
jmp __tmp_label_0
; stmt loc 5
case___tmp_label_0_5:
mov rax, rbp
sub rax, 9
mov [rbp-89], rax
mov rax, [rbp-9]
mov rbx, __temp_str_3
mov rax, [rbp-89]
mov [rax], rbx
mov rax, rbx
mov [rbp-97], rax
; stmt loc 6
jmp __tmp_label_0
; stmt loc 7
case___tmp_label_0_7:
mov rax, rbp
sub rax, 9
mov [rbp-113], rax
mov rax, [rbp-9]
mov rbx, __temp_str_4
mov rax, [rbp-113]
mov [rax], rbx
mov rax, rbx
mov [rbp-121], rax
; stmt loc 8
jmp __tmp_label_0
; stmt loc 9
case___tmp_label_0_9:
mov rax, rbp
sub rax, 9
mov [rbp-137], rax
mov rax, [rbp-9]
mov rbx, __temp_str_5
mov rax, [rbp-137]
mov [rax], rbx
mov rax, rbx
mov [rbp-145], rax
; end switch
__tmp_label_0:
;start switch
mov rax, 1
jmp case___tmp_label_1_0
; stmt loc 0
case___tmp_label_1_0:
mov rax, __temp_str_6
mov [rbp-161], rax
mov rdi, [rbp-161]
mov rax, rbp
sub rax, 8
mov [rbp-169], rax
call printf
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
mov rax, __temp_str_7
mov [rbp-177], rax
mov rdi, [rbp-177]
mov rax, rbp
sub rax, 8
mov [rbp-185], rax
call printf
; end switch
__tmp_label_2:
mov rax, __temp_str_8
mov [rbp-193], rax
mov rax, rbp
sub rax, 9
mov [rbp-201], rax
mov rax, [rbp-9]
mov [rbp-209], rax
mov rdi, [rbp-193]
mov rsi, [rbp-209]
mov rax, rbp
sub rax, 8
mov [rbp-217], rax
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
