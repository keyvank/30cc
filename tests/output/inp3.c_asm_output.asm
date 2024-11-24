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
__main_size: equ 1344
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
mov rax, rsp
add rax, 74
mov [rsp+322], rax
mov rax, [rsp+322]
mov [rsp+330], rax
mov rax, [rsp+282]
mov rbx, [rsp+330]
sub rax, rbx
mov [rsp+338], rax
mov rax, [rsp+338]
mov [rsp+346], rax
mov rdi, [rsp+306]
mov rsi, [rsp+346]
mov rax, rsp
add rax, 0
mov [rsp+354], rax
call printf
mov rax, __temp_str_9
mov [rsp+362], rax
mov rax, 123
mov [rsp+370], rax
mov rdi, [rsp+370]
mov rax, rsp
add rax, 0
mov [rsp+378], rax
call doub
mov [rsp+386], rax
mov rax, 123
mov rbx, [rsp+386]
mul rbx
mov [rsp+394], rax
mov rax, [rsp+394]
mov [rsp+402], rax
mov rdi, [rsp+402]
mov rax, rsp
add rax, 0
mov [rsp+410], rax
call doub
mov [rsp+418], rax
mov rax, [rsp+418]
mov rbx, 2
mul rbx
mov [rsp+426], rax
mov rax, [rsp+426]
mov [rsp+434], rax
mov rdi, [rsp+434]
mov rax, rsp
add rax, 0
mov [rsp+442], rax
call doub
mov [rsp+450], rax
mov rax, [rsp+450]
mov rbx, 10
add rax, rbx
mov [rsp+458], rax
mov rax, [rsp+458]
mov [rsp+466], rax
mov rdi, [rsp+362]
mov rsi, [rsp+466]
mov rax, rsp
add rax, 0
mov [rsp+474], rax
call printf
mov rax, __temp_str_10
mov [rsp+482], rax
mov rax, 5
mov [rsp+490], rax
mov rdi, [rsp+490]
mov rax, rsp
add rax, 0
mov [rsp+498], rax
call fact
mov [rsp+506], rax
mov rax, [rsp+506]
mov [rsp+514], rax
mov rdi, [rsp+482]
mov rsi, [rsp+514]
mov rax, rsp
add rax, 0
mov [rsp+522], rax
call printf
mov rax, 0
cmp rax, 1
je __tmp_label_14
mov rax, __temp_str_11
mov [rsp+530], rax
mov rdi, [rsp+530]
mov rax, rsp
add rax, 0
mov [rsp+538], rax
call printf
jmp __tmp_label_15
__tmp_label_14:
mov rax, __temp_str_12
mov [rsp+530], rax
mov rdi, [rsp+530]
mov rax, rsp
add rax, 0
mov [rsp+538], rax
call printf
__tmp_label_15:
mov rax, 0
cmp rax, 1
je __tmp_label_16
mov rax, __temp_str_13
mov [rsp+530], rax
mov rdi, [rsp+530]
mov rax, rsp
add rax, 0
mov [rsp+538], rax
call printf
jmp __tmp_label_17
__tmp_label_16:
mov rax, __temp_str_14
mov [rsp+530], rax
mov rdi, [rsp+530]
mov rax, rsp
add rax, 0
mov [rsp+538], rax
call printf
__tmp_label_17:
mov rax, __temp_str_15
mov [rsp+530], rax
mov rax, 5
mov rbx, 1
cmp rax, rbx
jne __tmp_label_18
mov rax, 0
jmp __tmp_label_19
__tmp_label_18:
mov rax, 1
__tmp_label_19:
mov [rsp+546], rax
mov rax, [rsp+546]
mov [rsp+554], rax
mov rdi, [rsp+530]
mov rsi, [rsp+554]
mov rax, rsp
add rax, 0
mov [rsp+562], rax
call printf
mov rax, __temp_str_16
mov [rsp+570], rax
mov rax, 0
mov [rsp+578], rax
mov rdi, [rsp+578]
mov rax, rsp
add rax, 0
mov [rsp+586], rax
call fibo
mov [rsp+594], rax
mov rax, [rsp+594]
mov [rsp+602], rax
mov rdi, [rsp+570]
mov rsi, [rsp+602]
mov rax, rsp
add rax, 0
mov [rsp+610], rax
call printf
mov rax, __temp_str_17
mov [rsp+618], rax
mov rax, 1
mov [rsp+626], rax
mov rdi, [rsp+626]
mov rax, rsp
add rax, 0
mov [rsp+634], rax
call fibo
mov [rsp+642], rax
mov rax, [rsp+642]
mov [rsp+650], rax
mov rdi, [rsp+618]
mov rsi, [rsp+650]
mov rax, rsp
add rax, 0
mov [rsp+658], rax
call printf
mov rax, __temp_str_18
mov [rsp+666], rax
mov rax, 2
mov [rsp+674], rax
mov rdi, [rsp+674]
mov rax, rsp
add rax, 0
mov [rsp+682], rax
call fibo
mov [rsp+690], rax
mov rax, [rsp+690]
mov [rsp+698], rax
mov rdi, [rsp+666]
mov rsi, [rsp+698]
mov rax, rsp
add rax, 0
mov [rsp+706], rax
call printf
mov rax, __temp_str_19
mov [rsp+714], rax
mov rax, 3
mov [rsp+722], rax
mov rdi, [rsp+722]
mov rax, rsp
add rax, 0
mov [rsp+730], rax
call fibo
mov [rsp+738], rax
mov rax, [rsp+738]
mov [rsp+746], rax
mov rdi, [rsp+714]
mov rsi, [rsp+746]
mov rax, rsp
add rax, 0
mov [rsp+754], rax
call printf
mov rax, __temp_str_20
mov [rsp+762], rax
mov rax, 4
mov [rsp+770], rax
mov rdi, [rsp+770]
mov rax, rsp
add rax, 0
mov [rsp+778], rax
call fibo
mov [rsp+786], rax
mov rax, [rsp+786]
mov [rsp+794], rax
mov rdi, [rsp+762]
mov rsi, [rsp+794]
mov rax, rsp
add rax, 0
mov [rsp+802], rax
call printf
mov rax, __temp_str_21
mov [rsp+810], rax
mov rax, 5
mov [rsp+818], rax
mov rdi, [rsp+818]
mov rax, rsp
add rax, 0
mov [rsp+826], rax
call fibo
mov [rsp+834], rax
mov rax, [rsp+834]
mov [rsp+842], rax
mov rdi, [rsp+810]
mov rsi, [rsp+842]
mov rax, rsp
add rax, 0
mov [rsp+850], rax
call printf
mov rax, __temp_str_22
mov [rsp+858], rax
mov rax, 6
mov [rsp+866], rax
mov rdi, [rsp+866]
mov rax, rsp
add rax, 0
mov [rsp+874], rax
call fibo
mov [rsp+882], rax
mov rax, [rsp+882]
mov [rsp+890], rax
mov rdi, [rsp+858]
mov rsi, [rsp+890]
mov rax, rsp
add rax, 0
mov [rsp+898], rax
call printf
mov rax, __temp_str_23
mov [rsp+906], rax
mov rax, 7
mov [rsp+914], rax
mov rdi, [rsp+914]
mov rax, rsp
add rax, 0
mov [rsp+922], rax
call fibo
mov [rsp+930], rax
mov rax, [rsp+930]
mov [rsp+938], rax
mov rdi, [rsp+906]
mov rsi, [rsp+938]
mov rax, rsp
add rax, 0
mov [rsp+946], rax
call printf
mov rax, __temp_str_24
mov [rsp+954], rax
mov rax, 8
mov [rsp+962], rax
mov rdi, [rsp+962]
mov rax, rsp
add rax, 0
mov [rsp+970], rax
call fibo
mov [rsp+978], rax
mov rax, [rsp+978]
mov [rsp+986], rax
mov rdi, [rsp+954]
mov rsi, [rsp+986]
mov rax, rsp
add rax, 0
mov [rsp+994], rax
call printf
;define variable i
mov rax, 0
mov [rsp+1002], rax
;end define variable i
; enter loop
__tmp_label_20:
mov rax, rsp
add rax, 1002
mov [rsp+1010], rax
mov rax, [rsp+1002]
mov rbx, 20
cmp rax, rbx
jl __tmp_label_22
mov rax, 0
jmp __tmp_label_23
__tmp_label_22:
mov rax, 1
__tmp_label_23:
mov [rsp+1026], rax
mov rax, [rsp+1026]
cmp rax, 0
je __tmp_label_21
mov rax, __temp_str_25
mov [rsp+1034], rax
mov rax, rsp
add rax, 1002
mov [rsp+1042], rax
mov rax, [rsp+1002]
mov [rsp+1050], rax
mov rdi, [rsp+1050]
mov rax, rsp
add rax, 0
mov [rsp+1058], rax
call fibo
mov [rsp+1066], rax
mov rax, [rsp+1066]
mov [rsp+1074], rax
mov rdi, [rsp+1034]
mov rsi, [rsp+1074]
mov rax, rsp
add rax, 0
mov [rsp+1082], rax
call printf
mov rax, rsp
add rax, 1002
mov [rsp+1034], rax
mov rax, rsp
add rax, 1002
mov [rsp+1042], rax
mov rax, [rsp+1002]
mov rbx, 1
add rax, rbx
mov [rsp+1050], rax
mov rax, [rsp+1002]
mov rbx, [rsp+1050]
mov rax, [rsp+1034]
mov [rax], rbx
mov rax, rbx
mov [rsp+1058], rax
jmp __tmp_label_20
__tmp_label_21:
; exit loop
mov rax, __temp_str_26
mov [rsp+1002], rax
mov rdi, [rsp+1002]
mov rax, rsp
add rax, 0
mov [rsp+1010], rax
call printf
mov rax, __temp_str_27
mov [rsp+1018], rax
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
mov [rsp+1034], rax
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
mov [rsp+1050], rax
mov rax, [rsp+1034]
mov rbx, [rsp+1050]
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
mov [rsp+1066], rax
mov rax, [rsp+1066]
mov [rsp+1074], rax
mov rdi, [rsp+1018]
mov rsi, [rsp+1074]
mov rax, rsp
add rax, 0
mov [rsp+1082], rax
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
