section .data
__printf_size: equ 16
__doub_size: equ 32
__temp_str_2 db `Fact: %u\n`, 0
__fact_size: equ 112
__fibo_size: equ 144
__temp_str_5 db `I: %u\n`, 0
__temp_str_6 db `%c %c %u`, 0
__temp_str_7 db `\n`, 0
__temp_str_8 db `Result: %u\n`, 0
__temp_str_9 db `Addr of c - Addr of a: %u\n`, 0
__temp_str_10 db `Double of 123: %u\n`, 0
__temp_str_11 db `Factorial 5: %u\n`, 0
__temp_str_12 db `TRUE\n`, 0
__temp_str_13 db `FALSE\n`, 0
__temp_str_14 db `TRUE\n`, 0
__temp_str_15 db `FALSE\n`, 0
__temp_str_16 db `%u\n`, 0
__temp_str_17 db `%u `, 0
__temp_str_18 db `%u `, 0
__temp_str_19 db `%u `, 0
__temp_str_20 db `%u `, 0
__temp_str_21 db `%u `, 0
__temp_str_22 db `%u `, 0
__temp_str_23 db `%u `, 0
__temp_str_24 db `%u `, 0
__temp_str_25 db `%u\n`, 0
__temp_str_26 db `%u `, 0
__temp_str_27 db `\nDONE!\n`, 0
__temp_str_28 db `%u\n`, 0
__main_size: equ 1296
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
mov rax, __temp_str_2
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
mov [rsp+16], rax
mov rax, 0
cmp rax, [rsp+16]
je __tmp_label_4
mov rax, 1
mov rsp, rbp
pop rbp
ret
jmp __tmp_label_5
__tmp_label_4:
mov rax, rsp
add rax, 0
mov [rsp+24], rax
mov rax, [rsp+0]
mov rbx, 1
cmp rax, rbx
je __tmp_label_6
mov rax, 0
jmp __tmp_label_7
__tmp_label_6:
mov rax, 1
__tmp_label_7:
mov [rsp+32], rax
mov rax, 0
cmp rax, [rsp+32]
je __tmp_label_8
mov rax, 1
mov rsp, rbp
pop rbp
ret
jmp __tmp_label_9
__tmp_label_8:
mov rax, rsp
add rax, 0
mov [rsp+40], rax
mov rax, [rsp+0]
mov rbx, 1
sub rax, rbx
mov [rsp+48], rax
mov rax, [rsp+48]
mov [rsp+56], rax
mov rdi, [rsp+56]
mov rax, rsp
add rax, 0
mov [rsp+64], rax
call fibo
mov [rsp+72], rax
mov rax, rsp
add rax, 0
mov [rsp+80], rax
mov rax, [rsp+0]
mov rbx, 2
sub rax, rbx
mov [rsp+88], rax
mov rax, [rsp+88]
mov [rsp+96], rax
mov rdi, [rsp+96]
mov rax, rsp
add rax, 0
mov [rsp+104], rax
call fibo
mov [rsp+112], rax
mov rax, [rsp+72]
mov rbx, [rsp+112]
add rax, rbx
mov [rsp+120], rax
mov rax, [rsp+120]
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
mov [rsp+16], rax
mov rax, [rsp+16]
cmp rax, 0
je __tmp_label_11
mov rax, __temp_str_5
mov [rsp+24], rax
mov rax, rsp
add rax, 0
mov [rsp+32], rax
mov rax, [rsp+0]
mov [rsp+40], rax
mov rdi, [rsp+24]
mov rsi, [rsp+40]
mov rax, rsp
add rax, 0
mov [rsp+48], rax
call printf
mov rax, rsp
add rax, 0
mov [rsp+56], rax
mov rax, rsp
add rax, 0
mov [rsp+64], rax
mov rax, [rsp+0]
mov rbx, 1
add rax, rbx
mov [rsp+72], rax
mov rax, [rsp+0]
mov rbx, [rsp+72]
mov rax, [rsp+56]
mov [rax], rbx
mov [rsp+80], rax
jmp __tmp_label_10
__tmp_label_11:
; exit loop
mov rax, __temp_str_6
mov [rsp+24], rax
mov al, 97
mov [rsp+32], al
mov rax, 110
mov [rsp+33], rax
mov al, 99
mov [rsp+41], al
mov rdi, [rsp+24]
mov rsi, [rsp+32]
mov rdx, [rsp+33]
mov rcx, [rsp+41]
mov rax, rsp
add rax, 0
mov [rsp+42], rax
call printf
mov rax, __temp_str_7
mov [rsp+50], rax
mov rdi, [rsp+50]
mov rax, rsp
add rax, 0
mov [rsp+58], rax
call printf
;define variable a
mov rax, 10
mov [rsp+66], rax
;end define variable a
;define variable b
mov rax, 20
mov [rsp+74], rax
;end define variable b
mov rax, rsp
add rax, 66
mov [rsp+90], rax
mov rax, rsp
add rax, 74
mov [rsp+98], rax
mov rax, [rsp+66]
mov rbx, [rsp+74]
mul rbx
mov [rsp+106], rax
;define variable c
mov rax, [rsp+106]
mov [rsp+82], rax
;end define variable c
mov rax, rsp
add rax, 82
mov [rsp+122], rax
mov rax, rsp
add rax, 82
mov [rsp+130], rax
mov rax, rsp
add rax, 66
mov [rsp+138], rax
mov rax, [rsp+82]
mov rbx, [rsp+66]
add rax, rbx
mov [rsp+146], rax
mov rax, [rsp+82]
mov rbx, [rsp+146]
mul rbx
mov [rsp+154], rax
;define variable d
mov rax, [rsp+154]
mov [rsp+114], rax
;end define variable d
mov rax, __temp_str_8
mov [rsp+162], rax
mov rax, rsp
add rax, 82
mov [rsp+170], rax
mov rax, rsp
add rax, 82
mov [rsp+178], rax
mov rax, [rsp+82]
mov rbx, [rsp+82]
add rax, rbx
mov [rsp+186], rax
mov rax, rsp
add rax, 114
mov [rsp+194], rax
mov rax, [rsp+186]
mov rbx, [rsp+114]
add rax, rbx
mov [rsp+202], rax
mov rax, rsp
add rax, 74
mov [rsp+210], rax
mov rax, rsp
add rax, 66
mov [rsp+218], rax
mov rax, [rsp+74]
mov rbx, [rsp+66]
add rax, rbx
mov [rsp+226], rax
mov rax, rsp
add rax, 66
mov [rsp+234], rax
mov rax, [rsp+226]
mov rbx, [rsp+66]
mul rbx
mov [rsp+242], rax
mov rax, [rsp+202]
mov rbx, [rsp+242]
add rax, rbx
mov [rsp+250], rax
mov rax, [rsp+250]
mov [rsp+258], rax
mov rdi, [rsp+162]
mov rsi, [rsp+258]
mov rax, rsp
add rax, 0
mov [rsp+266], rax
call printf
mov rax, rsp
add rax, 82
mov [rsp+282], rax
mov rax, [rsp+282]
mov [rsp+290], rax
;define variable cc
mov rax, [rsp+290]
mov [rsp+274], rax
;end define variable cc
mov rax, __temp_str_9
mov [rsp+298], rax
mov rax, rsp
add rax, 274
mov [rsp+306], rax
mov rax, rsp
add rax, 66
mov [rsp+314], rax
mov rax, [rsp+314]
mov [rsp+322], rax
mov rax, [rsp+274]
mov rbx, [rsp+322]
sub rax, rbx
mov [rsp+330], rax
mov rax, [rsp+330]
mov [rsp+338], rax
mov rdi, [rsp+298]
mov rsi, [rsp+338]
mov rax, rsp
add rax, 0
mov [rsp+346], rax
call printf
mov rax, __temp_str_10
mov [rsp+354], rax
mov rax, 123
mov [rsp+362], rax
mov rdi, [rsp+362]
mov rax, rsp
add rax, 0
mov [rsp+370], rax
call doub
mov [rsp+378], rax
mov rax, 123
mov rbx, [rsp+378]
mul rbx
mov [rsp+386], rax
mov rax, [rsp+386]
mov [rsp+394], rax
mov rdi, [rsp+394]
mov rax, rsp
add rax, 0
mov [rsp+402], rax
call doub
mov [rsp+410], rax
mov rax, [rsp+410]
mov rbx, 2
mul rbx
mov [rsp+418], rax
mov rax, [rsp+418]
mov [rsp+426], rax
mov rdi, [rsp+426]
mov rax, rsp
add rax, 0
mov [rsp+434], rax
call doub
mov [rsp+442], rax
mov rax, [rsp+442]
mov rbx, 10
add rax, rbx
mov [rsp+450], rax
mov rax, [rsp+450]
mov [rsp+458], rax
mov rdi, [rsp+354]
mov rsi, [rsp+458]
mov rax, rsp
add rax, 0
mov [rsp+466], rax
call printf
mov rax, __temp_str_11
mov [rsp+474], rax
mov rax, 5
mov [rsp+482], rax
mov rdi, [rsp+482]
mov rax, rsp
add rax, 0
mov [rsp+490], rax
call fact
mov [rsp+498], rax
mov rax, [rsp+498]
mov [rsp+506], rax
mov rdi, [rsp+474]
mov rsi, [rsp+506]
mov rax, rsp
add rax, 0
mov [rsp+514], rax
call printf
mov rax, 0
cmp rax, 1
je __tmp_label_14
mov rax, __temp_str_12
mov [rsp+522], rax
mov rdi, [rsp+522]
mov rax, rsp
add rax, 0
mov [rsp+530], rax
call printf
jmp __tmp_label_15
__tmp_label_14:
mov rax, __temp_str_13
mov [rsp+522], rax
mov rdi, [rsp+522]
mov rax, rsp
add rax, 0
mov [rsp+530], rax
call printf
__tmp_label_15:
mov rax, 0
cmp rax, 1
je __tmp_label_16
mov rax, __temp_str_14
mov [rsp+522], rax
mov rdi, [rsp+522]
mov rax, rsp
add rax, 0
mov [rsp+530], rax
call printf
jmp __tmp_label_17
__tmp_label_16:
mov rax, __temp_str_15
mov [rsp+522], rax
mov rdi, [rsp+522]
mov rax, rsp
add rax, 0
mov [rsp+530], rax
call printf
__tmp_label_17:
mov rax, __temp_str_16
mov [rsp+522], rax
mov rax, 5
mov rbx, 1
cmp rax, rbx
jne __tmp_label_18
mov rax, 0
jmp __tmp_label_19
__tmp_label_18:
mov rax, 1
__tmp_label_19:
mov [rsp+530], rax
mov rax, [rsp+530]
mov [rsp+538], rax
mov rdi, [rsp+522]
mov rsi, [rsp+538]
mov rax, rsp
add rax, 0
mov [rsp+546], rax
call printf
mov rax, __temp_str_17
mov [rsp+554], rax
mov rax, 0
mov [rsp+562], rax
mov rdi, [rsp+562]
mov rax, rsp
add rax, 0
mov [rsp+570], rax
call fibo
mov [rsp+578], rax
mov rax, [rsp+578]
mov [rsp+586], rax
mov rdi, [rsp+554]
mov rsi, [rsp+586]
mov rax, rsp
add rax, 0
mov [rsp+594], rax
call printf
mov rax, __temp_str_18
mov [rsp+602], rax
mov rax, 1
mov [rsp+610], rax
mov rdi, [rsp+610]
mov rax, rsp
add rax, 0
mov [rsp+618], rax
call fibo
mov [rsp+626], rax
mov rax, [rsp+626]
mov [rsp+634], rax
mov rdi, [rsp+602]
mov rsi, [rsp+634]
mov rax, rsp
add rax, 0
mov [rsp+642], rax
call printf
mov rax, __temp_str_19
mov [rsp+650], rax
mov rax, 2
mov [rsp+658], rax
mov rdi, [rsp+658]
mov rax, rsp
add rax, 0
mov [rsp+666], rax
call fibo
mov [rsp+674], rax
mov rax, [rsp+674]
mov [rsp+682], rax
mov rdi, [rsp+650]
mov rsi, [rsp+682]
mov rax, rsp
add rax, 0
mov [rsp+690], rax
call printf
mov rax, __temp_str_20
mov [rsp+698], rax
mov rax, 3
mov [rsp+706], rax
mov rdi, [rsp+706]
mov rax, rsp
add rax, 0
mov [rsp+714], rax
call fibo
mov [rsp+722], rax
mov rax, [rsp+722]
mov [rsp+730], rax
mov rdi, [rsp+698]
mov rsi, [rsp+730]
mov rax, rsp
add rax, 0
mov [rsp+738], rax
call printf
mov rax, __temp_str_21
mov [rsp+746], rax
mov rax, 4
mov [rsp+754], rax
mov rdi, [rsp+754]
mov rax, rsp
add rax, 0
mov [rsp+762], rax
call fibo
mov [rsp+770], rax
mov rax, [rsp+770]
mov [rsp+778], rax
mov rdi, [rsp+746]
mov rsi, [rsp+778]
mov rax, rsp
add rax, 0
mov [rsp+786], rax
call printf
mov rax, __temp_str_22
mov [rsp+794], rax
mov rax, 5
mov [rsp+802], rax
mov rdi, [rsp+802]
mov rax, rsp
add rax, 0
mov [rsp+810], rax
call fibo
mov [rsp+818], rax
mov rax, [rsp+818]
mov [rsp+826], rax
mov rdi, [rsp+794]
mov rsi, [rsp+826]
mov rax, rsp
add rax, 0
mov [rsp+834], rax
call printf
mov rax, __temp_str_23
mov [rsp+842], rax
mov rax, 6
mov [rsp+850], rax
mov rdi, [rsp+850]
mov rax, rsp
add rax, 0
mov [rsp+858], rax
call fibo
mov [rsp+866], rax
mov rax, [rsp+866]
mov [rsp+874], rax
mov rdi, [rsp+842]
mov rsi, [rsp+874]
mov rax, rsp
add rax, 0
mov [rsp+882], rax
call printf
mov rax, __temp_str_24
mov [rsp+890], rax
mov rax, 7
mov [rsp+898], rax
mov rdi, [rsp+898]
mov rax, rsp
add rax, 0
mov [rsp+906], rax
call fibo
mov [rsp+914], rax
mov rax, [rsp+914]
mov [rsp+922], rax
mov rdi, [rsp+890]
mov rsi, [rsp+922]
mov rax, rsp
add rax, 0
mov [rsp+930], rax
call printf
mov rax, __temp_str_25
mov [rsp+938], rax
mov rax, 8
mov [rsp+946], rax
mov rdi, [rsp+946]
mov rax, rsp
add rax, 0
mov [rsp+954], rax
call fibo
mov [rsp+962], rax
mov rax, [rsp+962]
mov [rsp+970], rax
mov rdi, [rsp+938]
mov rsi, [rsp+970]
mov rax, rsp
add rax, 0
mov [rsp+978], rax
call printf
;define variable i
mov rax, 0
mov [rsp+986], rax
;end define variable i
; enter loop
__tmp_label_20:
mov rax, rsp
add rax, 986
mov [rsp+994], rax
mov rax, [rsp+986]
mov rbx, 20
cmp rax, rbx
jl __tmp_label_22
mov rax, 0
jmp __tmp_label_23
__tmp_label_22:
mov rax, 1
__tmp_label_23:
mov [rsp+1002], rax
mov rax, [rsp+1002]
cmp rax, 0
je __tmp_label_21
mov rax, __temp_str_26
mov [rsp+1010], rax
mov rax, rsp
add rax, 986
mov [rsp+1018], rax
mov rax, [rsp+986]
mov [rsp+1026], rax
mov rdi, [rsp+1026]
mov rax, rsp
add rax, 0
mov [rsp+1034], rax
call fibo
mov [rsp+1042], rax
mov rax, [rsp+1042]
mov [rsp+1050], rax
mov rdi, [rsp+1010]
mov rsi, [rsp+1050]
mov rax, rsp
add rax, 0
mov [rsp+1058], rax
call printf
mov rax, rsp
add rax, 986
mov [rsp+1010], rax
mov rax, rsp
add rax, 986
mov [rsp+1018], rax
mov rax, [rsp+986]
mov rbx, 1
add rax, rbx
mov [rsp+1026], rax
mov rax, [rsp+986]
mov rbx, [rsp+1026]
mov rax, [rsp+1010]
mov [rax], rbx
mov [rsp+1034], rax
jmp __tmp_label_20
__tmp_label_21:
; exit loop
mov rax, __temp_str_27
mov [rsp+986], rax
mov rdi, [rsp+986]
mov rax, rsp
add rax, 0
mov [rsp+994], rax
call printf
mov rax, __temp_str_28
mov [rsp+1002], rax
mov rax, 1
mov rbx, 1
cmp rax, 0
je __tmp_label_24
mov rax, rbx
jmp __tmp_label_25
__tmp_label_24:
mov rax, 0
__tmp_label_25:
mov [rsp+1010], rax
mov rax, 1
mov rbx, 1
cmp rax, 0
je __tmp_label_26
mov rax, rbx
jmp __tmp_label_27
__tmp_label_26:
mov rax, 0
__tmp_label_27:
mov [rsp+1018], rax
mov rax, [rsp+1010]
mov rbx, [rsp+1018]
cmp rax, 0
je __tmp_label_28
mov rax, rbx
jmp __tmp_label_29
__tmp_label_28:
mov rax, 0
__tmp_label_29:
mov [rsp+1026], rax
mov rax, [rsp+1026]
mov [rsp+1034], rax
mov rdi, [rsp+1002]
mov rsi, [rsp+1034]
mov rax, rsp
add rax, 0
mov [rsp+1042], rax
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
