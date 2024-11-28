section .data
__doub_size: equ 32
__temp_str_1 db `Fact: %u\n`, 0
__fact_size: equ 112
__fibo_size: equ 160
__temp_str_4 db `I: %u\n`, 0
__temp_str_5 db `%c %c %u`, 0
__temp_str_6 db `\n`, 0
__temp_str_7 db `Result: %u\n`, 0
__temp_str_8 db `Addr of c - Addr of a: %u\n`, 0
__temp_str_9 db `Double of 123: %u\n`, 0
__temp_str_10 db `Factorial 5: %u\n`, 0
__temp_str_11 db `TRUE\n`, 0
__temp_str_12 db `FALSE\n`, 0
__temp_str_13 db `TRUE\n`, 0
__temp_str_14 db `FALSE\n`, 0
__temp_str_15 db `%u\n`, 0
__temp_str_16 db `%u `, 0
__temp_str_17 db `%u `, 0
__temp_str_18 db `%u `, 0
__temp_str_19 db `%u `, 0
__temp_str_20 db `%u `, 0
__temp_str_21 db `%u `, 0
__temp_str_22 db `%u `, 0
__temp_str_23 db `%u `, 0
__temp_str_24 db `%u\n`, 0
__temp_str_25 db `%u `, 0
__temp_str_26 db `\nDONE!\n`, 0
__temp_str_27 db `%u\n`, 0
__main_size: equ 1360
section .text
extern printf
global doub
doub:
push rbp
mov rbp, rsp
sub rsp, __doub_size
mov [rsp+0], rdi
mov rax, rsp
add rax, 0
mov [rsp+8], rax
mov rax, [rsp+0]
mov rbx, 2
mul rbx
mov [rsp+16], rax
mov rax, [rsp+16]
mov rsp, rbp
pop rbp
ret
mov rsp, rbp
pop rbp
ret
global fact
fact:
push rbp
mov rbp, rsp
sub rsp, __fact_size
mov [rsp+0], rdi
mov rax, __temp_str_1
mov [rsp+8], rax
mov rax, rsp
add rax, 0
mov [rsp+16], rax
mov rax, [rsp+0]
mov [rsp+24], rax
mov rdi, [rsp+8]
mov rsi, [rsp+24]
mov rax, rsp
add rax, 0
mov [rsp+32], rax
call printf
mov rax, rsp
add rax, 0
mov [rsp+40], rax
mov rax, 0
cmp rax, [rsp+0]
je __tmp_label_0
mov rax, rsp
add rax, 0
mov [rsp+48], rax
mov rax, rsp
add rax, 0
mov [rsp+56], rax
mov rax, [rsp+0]
mov rbx, 1
sub rax, rbx
mov [rsp+64], rax
mov rax, [rsp+64]
mov [rsp+72], rax
mov rdi, [rsp+72]
mov rax, rsp
add rax, 0
mov [rsp+80], rax
call fact
mov [rsp+88], rax
mov rax, [rsp+0]
mov rbx, [rsp+88]
mul rbx
mov [rsp+96], rax
mov rax, [rsp+96]
mov rsp, rbp
pop rbp
ret
jmp __tmp_label_1
__tmp_label_0:
mov rax, 1
mov rsp, rbp
pop rbp
ret
__tmp_label_1:
mov rsp, rbp
pop rbp
ret
global fibo
fibo:
push rbp
mov rbp, rsp
sub rsp, __fibo_size
mov [rsp+0], rdi
mov rax, rsp
add rax, 0
mov [rsp+8], rax
mov rax, [rsp+0]
mov rbx, 0
cmp rax, rbx
je __tmp_label_2
mov rax, 0
jmp __tmp_label_3
__tmp_label_2:
mov rax, 1
__tmp_label_3:
mov [rsp+24], rax
mov rax, 0
cmp rax, [rsp+24]
je __tmp_label_4
mov rax, 1
mov rsp, rbp
pop rbp
ret
jmp __tmp_label_5
__tmp_label_4:
mov rax, rsp
add rax, 0
mov [rsp+32], rax
mov rax, [rsp+0]
mov rbx, 1
cmp rax, rbx
je __tmp_label_6
mov rax, 0
jmp __tmp_label_7
__tmp_label_6:
mov rax, 1
__tmp_label_7:
mov [rsp+48], rax
mov rax, 0
cmp rax, [rsp+48]
je __tmp_label_8
mov rax, 1
mov rsp, rbp
pop rbp
ret
jmp __tmp_label_9
__tmp_label_8:
mov rax, rsp
add rax, 0
mov [rsp+56], rax
mov rax, [rsp+0]
mov rbx, 1
sub rax, rbx
mov [rsp+64], rax
mov rax, [rsp+64]
mov [rsp+72], rax
mov rdi, [rsp+72]
mov rax, rsp
add rax, 0
mov [rsp+80], rax
call fibo
mov [rsp+88], rax
mov rax, rsp
add rax, 0
mov [rsp+96], rax
mov rax, [rsp+0]
mov rbx, 2
sub rax, rbx
mov [rsp+104], rax
mov rax, [rsp+104]
mov [rsp+112], rax
mov rdi, [rsp+112]
mov rax, rsp
add rax, 0
mov [rsp+120], rax
call fibo
mov [rsp+128], rax
mov rax, [rsp+88]
mov rbx, [rsp+128]
add rax, rbx
mov [rsp+136], rax
mov rax, [rsp+136]
mov rsp, rbp
pop rbp
ret
__tmp_label_9:
__tmp_label_5:
mov rsp, rbp
pop rbp
ret
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
;define variable i2
mov rax, 0
mov [rsp+0], rax
;end define variable i2
; enter loop
__tmp_label_10:
mov rax, rsp
add rax, 0
mov [rsp+8], rax
mov rax, [rsp+0]
mov rbx, 10
cmp rax, rbx
jl __tmp_label_12
mov rax, 0
jmp __tmp_label_13
__tmp_label_12:
mov rax, 1
__tmp_label_13:
mov [rsp+24], rax
mov rax, [rsp+24]
cmp rax, 0
je __tmp_label_11
mov rax, __temp_str_4
mov [rsp+32], rax
mov rax, rsp
add rax, 0
mov [rsp+40], rax
mov rax, [rsp+0]
mov [rsp+48], rax
mov rdi, [rsp+32]
mov rsi, [rsp+48]
mov rax, rsp
add rax, 0
mov [rsp+56], rax
call printf
mov rax, rsp
add rax, 0
mov [rsp+64], rax
mov rax, rsp
add rax, 0
mov [rsp+72], rax
mov rax, [rsp+0]
mov rbx, 1
add rax, rbx
mov [rsp+80], rax
mov rax, [rsp+0]
mov rbx, [rsp+80]
mov rax, [rsp+64]
mov [rax], rbx
mov rax, rbx
mov [rsp+88], rax
jmp __tmp_label_10
__tmp_label_11:
; exit loop
mov rax, __temp_str_5
mov [rsp+32], rax
mov al, 97
mov [rsp+40], al
mov rax, 110
mov [rsp+41], rax
mov al, 99
mov [rsp+49], al
mov rdi, [rsp+32]
mov rsi, [rsp+40]
mov rdx, [rsp+41]
mov rcx, [rsp+49]
mov rax, rsp
add rax, 0
mov [rsp+50], rax
call printf
mov rax, __temp_str_6
mov [rsp+58], rax
mov rdi, [rsp+58]
mov rax, rsp
add rax, 0
mov [rsp+66], rax
call printf
;define variable a
mov rax, 10
mov [rsp+74], rax
;end define variable a
;define variable b
mov rax, 20
mov [rsp+82], rax
;end define variable b
mov rax, rsp
add rax, 74
mov [rsp+98], rax
mov rax, rsp
add rax, 82
mov [rsp+106], rax
mov rax, [rsp+74]
mov rbx, [rsp+82]
mul rbx
mov [rsp+114], rax
;define variable c
mov rax, [rsp+114]
mov [rsp+90], rax
;end define variable c
mov rax, rsp
add rax, 90
mov [rsp+130], rax
mov rax, rsp
add rax, 90
mov [rsp+138], rax
mov rax, rsp
add rax, 74
mov [rsp+146], rax
mov rax, [rsp+90]
mov rbx, [rsp+74]
add rax, rbx
mov [rsp+154], rax
mov rax, [rsp+90]
mov rbx, [rsp+154]
mul rbx
mov [rsp+162], rax
;define variable d
mov rax, [rsp+162]
mov [rsp+122], rax
;end define variable d
mov rax, __temp_str_7
mov [rsp+170], rax
mov rax, rsp
add rax, 90
mov [rsp+178], rax
mov rax, rsp
add rax, 90
mov [rsp+186], rax
mov rax, [rsp+90]
mov rbx, [rsp+90]
add rax, rbx
mov [rsp+194], rax
mov rax, rsp
add rax, 122
mov [rsp+202], rax
mov rax, [rsp+194]
mov rbx, [rsp+122]
add rax, rbx
mov [rsp+210], rax
mov rax, rsp
add rax, 82
mov [rsp+218], rax
mov rax, rsp
add rax, 74
mov [rsp+226], rax
mov rax, [rsp+82]
mov rbx, [rsp+74]
add rax, rbx
mov [rsp+234], rax
mov rax, rsp
add rax, 74
mov [rsp+242], rax
mov rax, [rsp+234]
mov rbx, [rsp+74]
mul rbx
mov [rsp+250], rax
mov rax, [rsp+210]
mov rbx, [rsp+250]
add rax, rbx
mov [rsp+258], rax
mov rax, [rsp+258]
mov [rsp+266], rax
mov rdi, [rsp+170]
mov rsi, [rsp+266]
mov rax, rsp
add rax, 0
mov [rsp+274], rax
call printf
mov rax, rsp
add rax, 90
mov [rsp+290], rax
mov rax, [rsp+290]
mov [rsp+298], rax
;define variable cc
mov rax, [rsp+298]
mov [rsp+282], rax
;end define variable cc
mov rax, __temp_str_8
mov [rsp+306], rax
mov rax, rsp
add rax, 282
mov [rsp+314], rax
xor rax, rax
mov [rsp+322], rax
mov rax, [rsp+282]
mov [rsp+322], rax
mov rax, rsp
add rax, 74
mov [rsp+330], rax
mov rax, [rsp+330]
mov [rsp+338], rax
xor rax, rax
mov [rsp+346], rax
mov rax, [rsp+338]
mov [rsp+346], rax
mov rax, [rsp+322]
mov rbx, [rsp+346]
sub rax, rbx
mov [rsp+354], rax
mov rax, [rsp+354]
mov [rsp+362], rax
mov rdi, [rsp+306]
mov rsi, [rsp+362]
mov rax, rsp
add rax, 0
mov [rsp+370], rax
call printf
mov rax, __temp_str_9
mov [rsp+378], rax
mov rax, 123
mov [rsp+386], rax
mov rdi, [rsp+386]
mov rax, rsp
add rax, 0
mov [rsp+394], rax
call doub
mov [rsp+402], rax
mov rax, 123
mov rbx, [rsp+402]
mul rbx
mov [rsp+410], rax
mov rax, [rsp+410]
mov [rsp+418], rax
mov rdi, [rsp+418]
mov rax, rsp
add rax, 0
mov [rsp+426], rax
call doub
mov [rsp+434], rax
mov rax, [rsp+434]
mov rbx, 2
mul rbx
mov [rsp+442], rax
mov rax, [rsp+442]
mov [rsp+450], rax
mov rdi, [rsp+450]
mov rax, rsp
add rax, 0
mov [rsp+458], rax
call doub
mov [rsp+466], rax
mov rax, [rsp+466]
mov rbx, 10
add rax, rbx
mov [rsp+474], rax
mov rax, [rsp+474]
mov [rsp+482], rax
mov rdi, [rsp+378]
mov rsi, [rsp+482]
mov rax, rsp
add rax, 0
mov [rsp+490], rax
call printf
mov rax, __temp_str_10
mov [rsp+498], rax
mov rax, 5
mov [rsp+506], rax
mov rdi, [rsp+506]
mov rax, rsp
add rax, 0
mov [rsp+514], rax
call fact
mov [rsp+522], rax
mov rax, [rsp+522]
mov [rsp+530], rax
mov rdi, [rsp+498]
mov rsi, [rsp+530]
mov rax, rsp
add rax, 0
mov [rsp+538], rax
call printf
mov rax, 0
cmp rax, 1
je __tmp_label_14
mov rax, __temp_str_11
mov [rsp+546], rax
mov rdi, [rsp+546]
mov rax, rsp
add rax, 0
mov [rsp+554], rax
call printf
jmp __tmp_label_15
__tmp_label_14:
mov rax, __temp_str_12
mov [rsp+546], rax
mov rdi, [rsp+546]
mov rax, rsp
add rax, 0
mov [rsp+554], rax
call printf
__tmp_label_15:
mov rax, 0
cmp rax, 1
je __tmp_label_16
mov rax, __temp_str_13
mov [rsp+546], rax
mov rdi, [rsp+546]
mov rax, rsp
add rax, 0
mov [rsp+554], rax
call printf
jmp __tmp_label_17
__tmp_label_16:
mov rax, __temp_str_14
mov [rsp+546], rax
mov rdi, [rsp+546]
mov rax, rsp
add rax, 0
mov [rsp+554], rax
call printf
__tmp_label_17:
mov rax, __temp_str_15
mov [rsp+546], rax
mov rax, 5
mov rbx, 1
cmp rax, rbx
jne __tmp_label_18
mov rax, 0
jmp __tmp_label_19
__tmp_label_18:
mov rax, 1
__tmp_label_19:
mov [rsp+562], rax
mov rax, [rsp+562]
mov [rsp+570], rax
mov rdi, [rsp+546]
mov rsi, [rsp+570]
mov rax, rsp
add rax, 0
mov [rsp+578], rax
call printf
mov rax, __temp_str_16
mov [rsp+586], rax
mov rax, 0
mov [rsp+594], rax
mov rdi, [rsp+594]
mov rax, rsp
add rax, 0
mov [rsp+602], rax
call fibo
mov [rsp+610], rax
mov rax, [rsp+610]
mov [rsp+618], rax
mov rdi, [rsp+586]
mov rsi, [rsp+618]
mov rax, rsp
add rax, 0
mov [rsp+626], rax
call printf
mov rax, __temp_str_17
mov [rsp+634], rax
mov rax, 1
mov [rsp+642], rax
mov rdi, [rsp+642]
mov rax, rsp
add rax, 0
mov [rsp+650], rax
call fibo
mov [rsp+658], rax
mov rax, [rsp+658]
mov [rsp+666], rax
mov rdi, [rsp+634]
mov rsi, [rsp+666]
mov rax, rsp
add rax, 0
mov [rsp+674], rax
call printf
mov rax, __temp_str_18
mov [rsp+682], rax
mov rax, 2
mov [rsp+690], rax
mov rdi, [rsp+690]
mov rax, rsp
add rax, 0
mov [rsp+698], rax
call fibo
mov [rsp+706], rax
mov rax, [rsp+706]
mov [rsp+714], rax
mov rdi, [rsp+682]
mov rsi, [rsp+714]
mov rax, rsp
add rax, 0
mov [rsp+722], rax
call printf
mov rax, __temp_str_19
mov [rsp+730], rax
mov rax, 3
mov [rsp+738], rax
mov rdi, [rsp+738]
mov rax, rsp
add rax, 0
mov [rsp+746], rax
call fibo
mov [rsp+754], rax
mov rax, [rsp+754]
mov [rsp+762], rax
mov rdi, [rsp+730]
mov rsi, [rsp+762]
mov rax, rsp
add rax, 0
mov [rsp+770], rax
call printf
mov rax, __temp_str_20
mov [rsp+778], rax
mov rax, 4
mov [rsp+786], rax
mov rdi, [rsp+786]
mov rax, rsp
add rax, 0
mov [rsp+794], rax
call fibo
mov [rsp+802], rax
mov rax, [rsp+802]
mov [rsp+810], rax
mov rdi, [rsp+778]
mov rsi, [rsp+810]
mov rax, rsp
add rax, 0
mov [rsp+818], rax
call printf
mov rax, __temp_str_21
mov [rsp+826], rax
mov rax, 5
mov [rsp+834], rax
mov rdi, [rsp+834]
mov rax, rsp
add rax, 0
mov [rsp+842], rax
call fibo
mov [rsp+850], rax
mov rax, [rsp+850]
mov [rsp+858], rax
mov rdi, [rsp+826]
mov rsi, [rsp+858]
mov rax, rsp
add rax, 0
mov [rsp+866], rax
call printf
mov rax, __temp_str_22
mov [rsp+874], rax
mov rax, 6
mov [rsp+882], rax
mov rdi, [rsp+882]
mov rax, rsp
add rax, 0
mov [rsp+890], rax
call fibo
mov [rsp+898], rax
mov rax, [rsp+898]
mov [rsp+906], rax
mov rdi, [rsp+874]
mov rsi, [rsp+906]
mov rax, rsp
add rax, 0
mov [rsp+914], rax
call printf
mov rax, __temp_str_23
mov [rsp+922], rax
mov rax, 7
mov [rsp+930], rax
mov rdi, [rsp+930]
mov rax, rsp
add rax, 0
mov [rsp+938], rax
call fibo
mov [rsp+946], rax
mov rax, [rsp+946]
mov [rsp+954], rax
mov rdi, [rsp+922]
mov rsi, [rsp+954]
mov rax, rsp
add rax, 0
mov [rsp+962], rax
call printf
mov rax, __temp_str_24
mov [rsp+970], rax
mov rax, 8
mov [rsp+978], rax
mov rdi, [rsp+978]
mov rax, rsp
add rax, 0
mov [rsp+986], rax
call fibo
mov [rsp+994], rax
mov rax, [rsp+994]
mov [rsp+1002], rax
mov rdi, [rsp+970]
mov rsi, [rsp+1002]
mov rax, rsp
add rax, 0
mov [rsp+1010], rax
call printf
;define variable i
mov rax, 0
mov [rsp+1018], rax
;end define variable i
; enter loop
__tmp_label_20:
mov rax, rsp
add rax, 1018
mov [rsp+1026], rax
mov rax, [rsp+1018]
mov rbx, 20
cmp rax, rbx
jl __tmp_label_22
mov rax, 0
jmp __tmp_label_23
__tmp_label_22:
mov rax, 1
__tmp_label_23:
mov [rsp+1042], rax
mov rax, [rsp+1042]
cmp rax, 0
je __tmp_label_21
mov rax, __temp_str_25
mov [rsp+1050], rax
mov rax, rsp
add rax, 1018
mov [rsp+1058], rax
mov rax, [rsp+1018]
mov [rsp+1066], rax
mov rdi, [rsp+1066]
mov rax, rsp
add rax, 0
mov [rsp+1074], rax
call fibo
mov [rsp+1082], rax
mov rax, [rsp+1082]
mov [rsp+1090], rax
mov rdi, [rsp+1050]
mov rsi, [rsp+1090]
mov rax, rsp
add rax, 0
mov [rsp+1098], rax
call printf
mov rax, rsp
add rax, 1018
mov [rsp+1050], rax
mov rax, rsp
add rax, 1018
mov [rsp+1058], rax
mov rax, [rsp+1018]
mov rbx, 1
add rax, rbx
mov [rsp+1066], rax
mov rax, [rsp+1018]
mov rbx, [rsp+1066]
mov rax, [rsp+1050]
mov [rax], rbx
mov rax, rbx
mov [rsp+1074], rax
jmp __tmp_label_20
__tmp_label_21:
; exit loop
mov rax, __temp_str_26
mov [rsp+1018], rax
mov rdi, [rsp+1018]
mov rax, rsp
add rax, 0
mov [rsp+1026], rax
call printf
mov rax, __temp_str_27
mov [rsp+1034], rax
mov rax, 1
mov rbx, 1
cmp rax, 0
je __tmp_label_24
mov rax, rbx
jmp __tmp_label_25
__tmp_label_24:
mov rax, 0
__tmp_label_25:
cmp rax, 0
jne __tmp_label_26
jmp __tmp_label_27
__tmp_label_26:
mov rax, 1
__tmp_label_27:
mov [rsp+1050], rax
mov rax, 1
mov rbx, 1
cmp rax, 0
je __tmp_label_28
mov rax, rbx
jmp __tmp_label_29
__tmp_label_28:
mov rax, 0
__tmp_label_29:
cmp rax, 0
jne __tmp_label_30
jmp __tmp_label_31
__tmp_label_30:
mov rax, 1
__tmp_label_31:
mov [rsp+1066], rax
mov rax, [rsp+1050]
mov rbx, [rsp+1066]
cmp rax, 0
je __tmp_label_32
mov rax, rbx
jmp __tmp_label_33
__tmp_label_32:
mov rax, 0
__tmp_label_33:
cmp rax, 0
jne __tmp_label_34
jmp __tmp_label_35
__tmp_label_34:
mov rax, 1
__tmp_label_35:
mov [rsp+1082], rax
mov rax, [rsp+1082]
mov [rsp+1090], rax
mov rdi, [rsp+1034]
mov rsi, [rsp+1090]
mov rax, rsp
add rax, 0
mov [rsp+1098], rax
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
