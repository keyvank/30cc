section .data
__doub_size: equ 48
__temp_str_1 db `Fact: %u\n`, 0
__fact_size: equ 128
__fibo_size: equ 192
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
__main_size: equ 1536
section .text
extern printf
global doub
doub:
push rbp
mov rbp, rsp
sub rsp, __doub_size
mov [rbp-8], rdi
mov rax, rbp
sub rax, 8
mov [rbp-16], rax
mov rax, [rbp-8]
mov rbx, 2
mul rbx
mov [rbp-32], rax
mov rax, [rbp-32]
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
mov [rbp-8], rdi
mov rax, __temp_str_1
mov [rbp-16], rax
mov rax, rbp
sub rax, 8
mov [rbp-24], rax
mov rax, [rbp-8]
mov [rbp-32], rax
mov rdi, [rbp-16]
mov rsi, [rbp-32]
mov rax, rbp
sub rax, 8
mov [rbp-40], rax
call printf
mov rax, rbp
sub rax, 8
mov [rbp-48], rax
mov rax, 0
cmp rax, [rbp-8]
je __tmp_label_0
mov rax, rbp
sub rax, 8
mov [rbp-56], rax
mov rax, rbp
sub rax, 8
mov [rbp-64], rax
mov rax, [rbp-8]
mov rbx, 1
sub rax, rbx
mov [rbp-80], rax
mov rax, [rbp-80]
mov [rbp-88], rax
mov rdi, [rbp-88]
mov rax, rbp
sub rax, 8
mov [rbp-96], rax
call fact
mov [rbp-104], rax
mov rax, [rbp-8]
mov rbx, [rbp-104]
mul rbx
mov [rbp-120], rax
mov rax, [rbp-120]
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
mov [rbp-8], rdi
mov rax, rbp
sub rax, 8
mov [rbp-16], rax
mov rax, [rbp-8]
mov rbx, 0
cmp rax, rbx
je __tmp_label_2
mov rax, 0
jmp __tmp_label_3
__tmp_label_2:
mov rax, 1
__tmp_label_3:
mov [rbp-40], rax
mov rax, 0
cmp rax, [rbp-40]
je __tmp_label_4
mov rax, 1
mov rsp, rbp
pop rbp
ret
jmp __tmp_label_5
__tmp_label_4:
mov rax, rbp
sub rax, 8
mov [rbp-48], rax
mov rax, [rbp-8]
mov rbx, 1
cmp rax, rbx
je __tmp_label_6
mov rax, 0
jmp __tmp_label_7
__tmp_label_6:
mov rax, 1
__tmp_label_7:
mov [rbp-72], rax
mov rax, 0
cmp rax, [rbp-72]
je __tmp_label_8
mov rax, 1
mov rsp, rbp
pop rbp
ret
jmp __tmp_label_9
__tmp_label_8:
mov rax, rbp
sub rax, 8
mov [rbp-80], rax
mov rax, [rbp-8]
mov rbx, 1
sub rax, rbx
mov [rbp-96], rax
mov rax, [rbp-96]
mov [rbp-104], rax
mov rdi, [rbp-104]
mov rax, rbp
sub rax, 8
mov [rbp-112], rax
call fibo
mov [rbp-120], rax
mov rax, rbp
sub rax, 8
mov [rbp-128], rax
mov rax, [rbp-8]
mov rbx, 2
sub rax, rbx
mov [rbp-144], rax
mov rax, [rbp-144]
mov [rbp-152], rax
mov rdi, [rbp-152]
mov rax, rbp
sub rax, 8
mov [rbp-160], rax
call fibo
mov [rbp-168], rax
mov rax, [rbp-120]
mov rbx, [rbp-168]
add rax, rbx
mov [rbp-184], rax
mov rax, [rbp-184]
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
mov [rbp-8], rax
;end define variable i2
; enter loop
__tmp_label_10:
mov rax, rbp
sub rax, 8
mov [rbp-16], rax
mov rax, [rbp-8]
mov rbx, 10
cmp rax, rbx
jl __tmp_label_12
mov rax, 0
jmp __tmp_label_13
__tmp_label_12:
mov rax, 1
__tmp_label_13:
mov [rbp-40], rax
mov rax, [rbp-40]
cmp rax, 0
je __tmp_label_11
mov rax, __temp_str_4
mov [rbp-48], rax
mov rax, rbp
sub rax, 8
mov [rbp-56], rax
mov rax, [rbp-8]
mov [rbp-64], rax
mov rdi, [rbp-48]
mov rsi, [rbp-64]
mov rax, rbp
sub rax, 8
mov [rbp-72], rax
call printf
mov rax, rbp
sub rax, 8
mov [rbp-80], rax
mov rax, rbp
sub rax, 8
mov [rbp-88], rax
mov rax, [rbp-8]
mov rbx, 1
add rax, rbx
mov [rbp-104], rax
mov rax, [rbp-8]
mov rbx, [rbp-104]
mov rax, [rbp-80]
mov [rax], rbx
mov rax, rbx
mov [rbp-120], rax
jmp __tmp_label_10
__tmp_label_11:
; exit loop
mov rax, __temp_str_5
mov [rbp-48], rax
mov al, 97
mov [rbp-49], al
mov rax, 110
mov [rbp-57], rax
mov al, 99
mov [rbp-58], al
mov rdi, [rbp-48]
mov sil, [rbp-49]
mov rdx, [rbp-57]
mov cl, [rbp-58]
mov rax, rbp
sub rax, 8
mov [rbp-66], rax
call printf
mov rax, __temp_str_6
mov [rbp-74], rax
mov rdi, [rbp-74]
mov rax, rbp
sub rax, 8
mov [rbp-82], rax
call printf
;define variable a
mov rax, 10
mov [rbp-90], rax
;end define variable a
;define variable b
mov rax, 20
mov [rbp-98], rax
;end define variable b
mov rax, rbp
sub rax, 90
mov [rbp-114], rax
mov rax, rbp
sub rax, 98
mov [rbp-122], rax
mov rax, [rbp-90]
mov rbx, [rbp-98]
mul rbx
mov [rbp-138], rax
;define variable c
mov rax, [rbp-138]
mov [rbp-106], rax
;end define variable c
mov rax, rbp
sub rax, 106
mov [rbp-154], rax
mov rax, rbp
sub rax, 106
mov [rbp-162], rax
mov rax, rbp
sub rax, 90
mov [rbp-170], rax
mov rax, [rbp-106]
mov rbx, [rbp-90]
add rax, rbx
mov [rbp-186], rax
mov rax, [rbp-106]
mov rbx, [rbp-186]
mul rbx
mov [rbp-202], rax
;define variable d
mov rax, [rbp-202]
mov [rbp-146], rax
;end define variable d
mov rax, __temp_str_7
mov [rbp-210], rax
mov rax, rbp
sub rax, 106
mov [rbp-218], rax
mov rax, rbp
sub rax, 106
mov [rbp-226], rax
mov rax, [rbp-106]
mov rbx, [rbp-106]
add rax, rbx
mov [rbp-242], rax
mov rax, rbp
sub rax, 146
mov [rbp-250], rax
mov rax, [rbp-242]
mov rbx, [rbp-146]
add rax, rbx
mov [rbp-266], rax
mov rax, rbp
sub rax, 98
mov [rbp-274], rax
mov rax, rbp
sub rax, 90
mov [rbp-282], rax
mov rax, [rbp-98]
mov rbx, [rbp-90]
add rax, rbx
mov [rbp-298], rax
mov rax, rbp
sub rax, 90
mov [rbp-306], rax
mov rax, [rbp-298]
mov rbx, [rbp-90]
mul rbx
mov [rbp-322], rax
mov rax, [rbp-266]
mov rbx, [rbp-322]
add rax, rbx
mov [rbp-338], rax
mov rax, [rbp-338]
mov [rbp-346], rax
mov rdi, [rbp-210]
mov rsi, [rbp-346]
mov rax, rbp
sub rax, 8
mov [rbp-354], rax
call printf
mov rax, rbp
sub rax, 106
mov [rbp-370], rax
mov rax, [rbp-370]
mov [rbp-378], rax
;define variable cc
mov rax, [rbp-378]
mov [rbp-362], rax
;end define variable cc
mov rax, __temp_str_8
mov [rbp-386], rax
mov rax, rbp
sub rax, 362
mov [rbp-394], rax
xor rax, rax
mov [rbp-402], rax
mov rax, [rbp-362]
mov [rbp-402], rax
mov rax, rbp
sub rax, 90
mov [rbp-410], rax
mov rax, [rbp-410]
mov [rbp-418], rax
xor rax, rax
mov [rbp-426], rax
mov rax, [rbp-418]
mov [rbp-426], rax
mov rax, [rbp-402]
mov rbx, [rbp-426]
sub rax, rbx
mov [rbp-442], rax
mov rax, [rbp-442]
mov [rbp-450], rax
mov rdi, [rbp-386]
mov rsi, [rbp-450]
mov rax, rbp
sub rax, 8
mov [rbp-458], rax
call printf
mov rax, __temp_str_9
mov [rbp-466], rax
mov rax, 123
mov [rbp-474], rax
mov rdi, [rbp-474]
mov rax, rbp
sub rax, 8
mov [rbp-482], rax
call doub
mov [rbp-490], rax
mov rax, 123
mov rbx, [rbp-490]
mul rbx
mov [rbp-506], rax
mov rax, [rbp-506]
mov [rbp-514], rax
mov rdi, [rbp-514]
mov rax, rbp
sub rax, 8
mov [rbp-522], rax
call doub
mov [rbp-530], rax
mov rax, [rbp-530]
mov rbx, 2
mul rbx
mov [rbp-546], rax
mov rax, [rbp-546]
mov [rbp-554], rax
mov rdi, [rbp-554]
mov rax, rbp
sub rax, 8
mov [rbp-562], rax
call doub
mov [rbp-570], rax
mov rax, [rbp-570]
mov rbx, 10
add rax, rbx
mov [rbp-586], rax
mov rax, [rbp-586]
mov [rbp-594], rax
mov rdi, [rbp-466]
mov rsi, [rbp-594]
mov rax, rbp
sub rax, 8
mov [rbp-602], rax
call printf
mov rax, __temp_str_10
mov [rbp-610], rax
mov rax, 5
mov [rbp-618], rax
mov rdi, [rbp-618]
mov rax, rbp
sub rax, 8
mov [rbp-626], rax
call fact
mov [rbp-634], rax
mov rax, [rbp-634]
mov [rbp-642], rax
mov rdi, [rbp-610]
mov rsi, [rbp-642]
mov rax, rbp
sub rax, 8
mov [rbp-650], rax
call printf
mov rax, 0
cmp rax, 1
je __tmp_label_14
mov rax, __temp_str_11
mov [rbp-658], rax
mov rdi, [rbp-658]
mov rax, rbp
sub rax, 8
mov [rbp-666], rax
call printf
jmp __tmp_label_15
__tmp_label_14:
mov rax, __temp_str_12
mov [rbp-658], rax
mov rdi, [rbp-658]
mov rax, rbp
sub rax, 8
mov [rbp-666], rax
call printf
__tmp_label_15:
mov rax, 0
cmp rax, 1
je __tmp_label_16
mov rax, __temp_str_13
mov [rbp-658], rax
mov rdi, [rbp-658]
mov rax, rbp
sub rax, 8
mov [rbp-666], rax
call printf
jmp __tmp_label_17
__tmp_label_16:
mov rax, __temp_str_14
mov [rbp-658], rax
mov rdi, [rbp-658]
mov rax, rbp
sub rax, 8
mov [rbp-666], rax
call printf
__tmp_label_17:
mov rax, __temp_str_15
mov [rbp-658], rax
mov rax, 5
mov rbx, 1
cmp rax, rbx
jne __tmp_label_18
mov rax, 0
jmp __tmp_label_19
__tmp_label_18:
mov rax, 1
__tmp_label_19:
mov [rbp-682], rax
mov rax, [rbp-682]
mov [rbp-690], rax
mov rdi, [rbp-658]
mov rsi, [rbp-690]
mov rax, rbp
sub rax, 8
mov [rbp-698], rax
call printf
mov rax, __temp_str_16
mov [rbp-706], rax
mov rax, 0
mov [rbp-714], rax
mov rdi, [rbp-714]
mov rax, rbp
sub rax, 8
mov [rbp-722], rax
call fibo
mov [rbp-730], rax
mov rax, [rbp-730]
mov [rbp-738], rax
mov rdi, [rbp-706]
mov rsi, [rbp-738]
mov rax, rbp
sub rax, 8
mov [rbp-746], rax
call printf
mov rax, __temp_str_17
mov [rbp-754], rax
mov rax, 1
mov [rbp-762], rax
mov rdi, [rbp-762]
mov rax, rbp
sub rax, 8
mov [rbp-770], rax
call fibo
mov [rbp-778], rax
mov rax, [rbp-778]
mov [rbp-786], rax
mov rdi, [rbp-754]
mov rsi, [rbp-786]
mov rax, rbp
sub rax, 8
mov [rbp-794], rax
call printf
mov rax, __temp_str_18
mov [rbp-802], rax
mov rax, 2
mov [rbp-810], rax
mov rdi, [rbp-810]
mov rax, rbp
sub rax, 8
mov [rbp-818], rax
call fibo
mov [rbp-826], rax
mov rax, [rbp-826]
mov [rbp-834], rax
mov rdi, [rbp-802]
mov rsi, [rbp-834]
mov rax, rbp
sub rax, 8
mov [rbp-842], rax
call printf
mov rax, __temp_str_19
mov [rbp-850], rax
mov rax, 3
mov [rbp-858], rax
mov rdi, [rbp-858]
mov rax, rbp
sub rax, 8
mov [rbp-866], rax
call fibo
mov [rbp-874], rax
mov rax, [rbp-874]
mov [rbp-882], rax
mov rdi, [rbp-850]
mov rsi, [rbp-882]
mov rax, rbp
sub rax, 8
mov [rbp-890], rax
call printf
mov rax, __temp_str_20
mov [rbp-898], rax
mov rax, 4
mov [rbp-906], rax
mov rdi, [rbp-906]
mov rax, rbp
sub rax, 8
mov [rbp-914], rax
call fibo
mov [rbp-922], rax
mov rax, [rbp-922]
mov [rbp-930], rax
mov rdi, [rbp-898]
mov rsi, [rbp-930]
mov rax, rbp
sub rax, 8
mov [rbp-938], rax
call printf
mov rax, __temp_str_21
mov [rbp-946], rax
mov rax, 5
mov [rbp-954], rax
mov rdi, [rbp-954]
mov rax, rbp
sub rax, 8
mov [rbp-962], rax
call fibo
mov [rbp-970], rax
mov rax, [rbp-970]
mov [rbp-978], rax
mov rdi, [rbp-946]
mov rsi, [rbp-978]
mov rax, rbp
sub rax, 8
mov [rbp-986], rax
call printf
mov rax, __temp_str_22
mov [rbp-994], rax
mov rax, 6
mov [rbp-1002], rax
mov rdi, [rbp-1002]
mov rax, rbp
sub rax, 8
mov [rbp-1010], rax
call fibo
mov [rbp-1018], rax
mov rax, [rbp-1018]
mov [rbp-1026], rax
mov rdi, [rbp-994]
mov rsi, [rbp-1026]
mov rax, rbp
sub rax, 8
mov [rbp-1034], rax
call printf
mov rax, __temp_str_23
mov [rbp-1042], rax
mov rax, 7
mov [rbp-1050], rax
mov rdi, [rbp-1050]
mov rax, rbp
sub rax, 8
mov [rbp-1058], rax
call fibo
mov [rbp-1066], rax
mov rax, [rbp-1066]
mov [rbp-1074], rax
mov rdi, [rbp-1042]
mov rsi, [rbp-1074]
mov rax, rbp
sub rax, 8
mov [rbp-1082], rax
call printf
mov rax, __temp_str_24
mov [rbp-1090], rax
mov rax, 8
mov [rbp-1098], rax
mov rdi, [rbp-1098]
mov rax, rbp
sub rax, 8
mov [rbp-1106], rax
call fibo
mov [rbp-1114], rax
mov rax, [rbp-1114]
mov [rbp-1122], rax
mov rdi, [rbp-1090]
mov rsi, [rbp-1122]
mov rax, rbp
sub rax, 8
mov [rbp-1130], rax
call printf
;define variable i
mov rax, 0
mov [rbp-1138], rax
;end define variable i
; enter loop
__tmp_label_20:
mov rax, rbp
sub rax, 1138
mov [rbp-1146], rax
mov rax, [rbp-1138]
mov rbx, 20
cmp rax, rbx
jl __tmp_label_22
mov rax, 0
jmp __tmp_label_23
__tmp_label_22:
mov rax, 1
__tmp_label_23:
mov [rbp-1170], rax
mov rax, [rbp-1170]
cmp rax, 0
je __tmp_label_21
mov rax, __temp_str_25
mov [rbp-1178], rax
mov rax, rbp
sub rax, 1138
mov [rbp-1186], rax
mov rax, [rbp-1138]
mov [rbp-1194], rax
mov rdi, [rbp-1194]
mov rax, rbp
sub rax, 8
mov [rbp-1202], rax
call fibo
mov [rbp-1210], rax
mov rax, [rbp-1210]
mov [rbp-1218], rax
mov rdi, [rbp-1178]
mov rsi, [rbp-1218]
mov rax, rbp
sub rax, 8
mov [rbp-1226], rax
call printf
mov rax, rbp
sub rax, 1138
mov [rbp-1178], rax
mov rax, rbp
sub rax, 1138
mov [rbp-1186], rax
mov rax, [rbp-1138]
mov rbx, 1
add rax, rbx
mov [rbp-1202], rax
mov rax, [rbp-1138]
mov rbx, [rbp-1202]
mov rax, [rbp-1178]
mov [rax], rbx
mov rax, rbx
mov [rbp-1218], rax
jmp __tmp_label_20
__tmp_label_21:
; exit loop
mov rax, __temp_str_26
mov [rbp-1138], rax
mov rdi, [rbp-1138]
mov rax, rbp
sub rax, 8
mov [rbp-1146], rax
call printf
mov rax, __temp_str_27
mov [rbp-1154], rax
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
mov [rbp-1178], rax
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
mov [rbp-1202], rax
mov rax, [rbp-1178]
mov rbx, [rbp-1202]
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
mov [rbp-1226], rax
mov rax, [rbp-1226]
mov [rbp-1234], rax
mov rdi, [rbp-1154]
mov rsi, [rbp-1234]
mov rax, rbp
sub rax, 8
mov [rbp-1242], rax
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
