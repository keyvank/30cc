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
mov [rbp-8], rdi
mov rax, rbp
sub rax, 8
mov [rbp-16], rax
mov rax, [rbp-8]
mov rbx, 2
mul rbx
mov [rbp-24], rax
mov rax, [rbp-24]
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
mov [rbp-72], rax
mov rax, [rbp-72]
mov [rbp-80], rax
mov rdi, [rbp-80]
mov rax, rbp
sub rax, 8
mov [rbp-88], rax
call fact
mov [rbp-96], rax
mov rax, [rbp-8]
mov rbx, [rbp-96]
mul rbx
mov [rbp-104], rax
mov rax, [rbp-104]
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
mov [rbp-32], rax
mov rax, 0
cmp rax, [rbp-32]
je __tmp_label_4
mov rax, 1
mov rsp, rbp
pop rbp
ret
jmp __tmp_label_5
__tmp_label_4:
mov rax, rbp
sub rax, 8
mov [rbp-40], rax
mov rax, [rbp-8]
mov rbx, 1
cmp rax, rbx
je __tmp_label_6
mov rax, 0
jmp __tmp_label_7
__tmp_label_6:
mov rax, 1
__tmp_label_7:
mov [rbp-56], rax
mov rax, 0
cmp rax, [rbp-56]
je __tmp_label_8
mov rax, 1
mov rsp, rbp
pop rbp
ret
jmp __tmp_label_9
__tmp_label_8:
mov rax, rbp
sub rax, 8
mov [rbp-64], rax
mov rax, [rbp-8]
mov rbx, 1
sub rax, rbx
mov [rbp-72], rax
mov rax, [rbp-72]
mov [rbp-80], rax
mov rdi, [rbp-80]
mov rax, rbp
sub rax, 8
mov [rbp-88], rax
call fibo
mov [rbp-96], rax
mov rax, rbp
sub rax, 8
mov [rbp-104], rax
mov rax, [rbp-8]
mov rbx, 2
sub rax, rbx
mov [rbp-112], rax
mov rax, [rbp-112]
mov [rbp-120], rax
mov rdi, [rbp-120]
mov rax, rbp
sub rax, 8
mov [rbp-128], rax
call fibo
mov [rbp-136], rax
mov rax, [rbp-96]
mov rbx, [rbp-136]
add rax, rbx
mov [rbp-144], rax
mov rax, [rbp-144]
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
mov [rbp-32], rax
mov rax, [rbp-32]
cmp rax, 0
je __tmp_label_11
mov rax, __temp_str_4
mov [rbp-40], rax
mov rax, rbp
sub rax, 8
mov [rbp-48], rax
mov rax, [rbp-8]
mov [rbp-56], rax
mov rdi, [rbp-40]
mov rsi, [rbp-56]
mov rax, rbp
sub rax, 8
mov [rbp-64], rax
call printf
mov rax, rbp
sub rax, 8
mov [rbp-72], rax
mov rax, rbp
sub rax, 8
mov [rbp-80], rax
mov rax, [rbp-8]
mov rbx, 1
add rax, rbx
mov [rbp-88], rax
mov rax, [rbp-8]
mov rbx, [rbp-88]
mov rax, [rbp-72]
mov [rax], rbx
mov rax, rbx
mov [rbp-96], rax
jmp __tmp_label_10
__tmp_label_11:
; exit loop
mov rax, __temp_str_5
mov [rbp-40], rax
mov al, 97
mov [rbp-41], al
mov rax, 110
mov [rbp-49], rax
mov al, 99
mov [rbp-50], al
mov rdi, [rbp-40]
mov sil, [rbp-41]
mov rdx, [rbp-49]
mov cl, [rbp-50]
mov rax, rbp
sub rax, 8
mov [rbp-58], rax
call printf
mov rax, __temp_str_6
mov [rbp-66], rax
mov rdi, [rbp-66]
mov rax, rbp
sub rax, 8
mov [rbp-74], rax
call printf
;define variable a
mov rax, 10
mov [rbp-82], rax
;end define variable a
;define variable b
mov rax, 20
mov [rbp-90], rax
;end define variable b
mov rax, rbp
sub rax, 82
mov [rbp-106], rax
mov rax, rbp
sub rax, 90
mov [rbp-114], rax
mov rax, [rbp-82]
mov rbx, [rbp-90]
mul rbx
mov [rbp-122], rax
;define variable c
mov rax, [rbp-122]
mov [rbp-98], rax
;end define variable c
mov rax, rbp
sub rax, 98
mov [rbp-138], rax
mov rax, rbp
sub rax, 98
mov [rbp-146], rax
mov rax, rbp
sub rax, 82
mov [rbp-154], rax
mov rax, [rbp-98]
mov rbx, [rbp-82]
add rax, rbx
mov [rbp-162], rax
mov rax, [rbp-98]
mov rbx, [rbp-162]
mul rbx
mov [rbp-170], rax
;define variable d
mov rax, [rbp-170]
mov [rbp-130], rax
;end define variable d
mov rax, __temp_str_7
mov [rbp-178], rax
mov rax, rbp
sub rax, 98
mov [rbp-186], rax
mov rax, rbp
sub rax, 98
mov [rbp-194], rax
mov rax, [rbp-98]
mov rbx, [rbp-98]
add rax, rbx
mov [rbp-202], rax
mov rax, rbp
sub rax, 130
mov [rbp-210], rax
mov rax, [rbp-202]
mov rbx, [rbp-130]
add rax, rbx
mov [rbp-218], rax
mov rax, rbp
sub rax, 90
mov [rbp-226], rax
mov rax, rbp
sub rax, 82
mov [rbp-234], rax
mov rax, [rbp-90]
mov rbx, [rbp-82]
add rax, rbx
mov [rbp-242], rax
mov rax, rbp
sub rax, 82
mov [rbp-250], rax
mov rax, [rbp-242]
mov rbx, [rbp-82]
mul rbx
mov [rbp-258], rax
mov rax, [rbp-218]
mov rbx, [rbp-258]
add rax, rbx
mov [rbp-266], rax
mov rax, [rbp-266]
mov [rbp-274], rax
mov rdi, [rbp-178]
mov rsi, [rbp-274]
mov rax, rbp
sub rax, 8
mov [rbp-282], rax
call printf
mov rax, rbp
sub rax, 98
mov [rbp-298], rax
mov rax, [rbp-298]
mov [rbp-306], rax
;define variable cc
mov rax, [rbp-306]
mov [rbp-290], rax
;end define variable cc
mov rax, __temp_str_8
mov [rbp-314], rax
mov rax, rbp
sub rax, 82
mov [rbp-322], rax
mov rax, [rbp-322]
mov [rbp-330], rax
xor rax, rax
mov [rbp-338], rax
mov rax, [rbp-330]
mov [rbp-338], rax
mov rax, rbp
sub rax, 290
mov [rbp-346], rax
xor rax, rax
mov [rbp-354], rax
mov rax, [rbp-290]
mov [rbp-354], rax
mov rax, [rbp-338]
mov rbx, [rbp-354]
sub rax, rbx
mov [rbp-362], rax
mov rax, [rbp-362]
mov [rbp-370], rax
mov rdi, [rbp-314]
mov rsi, [rbp-370]
mov rax, rbp
sub rax, 8
mov [rbp-378], rax
call printf
mov rax, __temp_str_9
mov [rbp-386], rax
mov rax, 123
mov [rbp-394], rax
mov rdi, [rbp-394]
mov rax, rbp
sub rax, 8
mov [rbp-402], rax
call doub
mov [rbp-410], rax
mov rax, 123
mov rbx, [rbp-410]
mul rbx
mov [rbp-418], rax
mov rax, [rbp-418]
mov [rbp-426], rax
mov rdi, [rbp-426]
mov rax, rbp
sub rax, 8
mov [rbp-434], rax
call doub
mov [rbp-442], rax
mov rax, [rbp-442]
mov rbx, 2
mul rbx
mov [rbp-450], rax
mov rax, [rbp-450]
mov [rbp-458], rax
mov rdi, [rbp-458]
mov rax, rbp
sub rax, 8
mov [rbp-466], rax
call doub
mov [rbp-474], rax
mov rax, [rbp-474]
mov rbx, 10
add rax, rbx
mov [rbp-482], rax
mov rax, [rbp-482]
mov [rbp-490], rax
mov rdi, [rbp-386]
mov rsi, [rbp-490]
mov rax, rbp
sub rax, 8
mov [rbp-498], rax
call printf
mov rax, __temp_str_10
mov [rbp-506], rax
mov rax, 5
mov [rbp-514], rax
mov rdi, [rbp-514]
mov rax, rbp
sub rax, 8
mov [rbp-522], rax
call fact
mov [rbp-530], rax
mov rax, [rbp-530]
mov [rbp-538], rax
mov rdi, [rbp-506]
mov rsi, [rbp-538]
mov rax, rbp
sub rax, 8
mov [rbp-546], rax
call printf
mov rax, 0
cmp rax, 1
je __tmp_label_14
mov rax, __temp_str_11
mov [rbp-554], rax
mov rdi, [rbp-554]
mov rax, rbp
sub rax, 8
mov [rbp-562], rax
call printf
jmp __tmp_label_15
__tmp_label_14:
mov rax, __temp_str_12
mov [rbp-554], rax
mov rdi, [rbp-554]
mov rax, rbp
sub rax, 8
mov [rbp-562], rax
call printf
__tmp_label_15:
mov rax, 0
cmp rax, 1
je __tmp_label_16
mov rax, __temp_str_13
mov [rbp-554], rax
mov rdi, [rbp-554]
mov rax, rbp
sub rax, 8
mov [rbp-562], rax
call printf
jmp __tmp_label_17
__tmp_label_16:
mov rax, __temp_str_14
mov [rbp-554], rax
mov rdi, [rbp-554]
mov rax, rbp
sub rax, 8
mov [rbp-562], rax
call printf
__tmp_label_17:
mov rax, __temp_str_15
mov [rbp-554], rax
mov rax, 5
mov rbx, 1
cmp rax, rbx
jne __tmp_label_18
mov rax, 0
jmp __tmp_label_19
__tmp_label_18:
mov rax, 1
__tmp_label_19:
mov [rbp-570], rax
mov rax, [rbp-570]
mov [rbp-578], rax
mov rdi, [rbp-554]
mov rsi, [rbp-578]
mov rax, rbp
sub rax, 8
mov [rbp-586], rax
call printf
mov rax, __temp_str_16
mov [rbp-594], rax
mov rax, 0
mov [rbp-602], rax
mov rdi, [rbp-602]
mov rax, rbp
sub rax, 8
mov [rbp-610], rax
call fibo
mov [rbp-618], rax
mov rax, [rbp-618]
mov [rbp-626], rax
mov rdi, [rbp-594]
mov rsi, [rbp-626]
mov rax, rbp
sub rax, 8
mov [rbp-634], rax
call printf
mov rax, __temp_str_17
mov [rbp-642], rax
mov rax, 1
mov [rbp-650], rax
mov rdi, [rbp-650]
mov rax, rbp
sub rax, 8
mov [rbp-658], rax
call fibo
mov [rbp-666], rax
mov rax, [rbp-666]
mov [rbp-674], rax
mov rdi, [rbp-642]
mov rsi, [rbp-674]
mov rax, rbp
sub rax, 8
mov [rbp-682], rax
call printf
mov rax, __temp_str_18
mov [rbp-690], rax
mov rax, 2
mov [rbp-698], rax
mov rdi, [rbp-698]
mov rax, rbp
sub rax, 8
mov [rbp-706], rax
call fibo
mov [rbp-714], rax
mov rax, [rbp-714]
mov [rbp-722], rax
mov rdi, [rbp-690]
mov rsi, [rbp-722]
mov rax, rbp
sub rax, 8
mov [rbp-730], rax
call printf
mov rax, __temp_str_19
mov [rbp-738], rax
mov rax, 3
mov [rbp-746], rax
mov rdi, [rbp-746]
mov rax, rbp
sub rax, 8
mov [rbp-754], rax
call fibo
mov [rbp-762], rax
mov rax, [rbp-762]
mov [rbp-770], rax
mov rdi, [rbp-738]
mov rsi, [rbp-770]
mov rax, rbp
sub rax, 8
mov [rbp-778], rax
call printf
mov rax, __temp_str_20
mov [rbp-786], rax
mov rax, 4
mov [rbp-794], rax
mov rdi, [rbp-794]
mov rax, rbp
sub rax, 8
mov [rbp-802], rax
call fibo
mov [rbp-810], rax
mov rax, [rbp-810]
mov [rbp-818], rax
mov rdi, [rbp-786]
mov rsi, [rbp-818]
mov rax, rbp
sub rax, 8
mov [rbp-826], rax
call printf
mov rax, __temp_str_21
mov [rbp-834], rax
mov rax, 5
mov [rbp-842], rax
mov rdi, [rbp-842]
mov rax, rbp
sub rax, 8
mov [rbp-850], rax
call fibo
mov [rbp-858], rax
mov rax, [rbp-858]
mov [rbp-866], rax
mov rdi, [rbp-834]
mov rsi, [rbp-866]
mov rax, rbp
sub rax, 8
mov [rbp-874], rax
call printf
mov rax, __temp_str_22
mov [rbp-882], rax
mov rax, 6
mov [rbp-890], rax
mov rdi, [rbp-890]
mov rax, rbp
sub rax, 8
mov [rbp-898], rax
call fibo
mov [rbp-906], rax
mov rax, [rbp-906]
mov [rbp-914], rax
mov rdi, [rbp-882]
mov rsi, [rbp-914]
mov rax, rbp
sub rax, 8
mov [rbp-922], rax
call printf
mov rax, __temp_str_23
mov [rbp-930], rax
mov rax, 7
mov [rbp-938], rax
mov rdi, [rbp-938]
mov rax, rbp
sub rax, 8
mov [rbp-946], rax
call fibo
mov [rbp-954], rax
mov rax, [rbp-954]
mov [rbp-962], rax
mov rdi, [rbp-930]
mov rsi, [rbp-962]
mov rax, rbp
sub rax, 8
mov [rbp-970], rax
call printf
mov rax, __temp_str_24
mov [rbp-978], rax
mov rax, 8
mov [rbp-986], rax
mov rdi, [rbp-986]
mov rax, rbp
sub rax, 8
mov [rbp-994], rax
call fibo
mov [rbp-1002], rax
mov rax, [rbp-1002]
mov [rbp-1010], rax
mov rdi, [rbp-978]
mov rsi, [rbp-1010]
mov rax, rbp
sub rax, 8
mov [rbp-1018], rax
call printf
;define variable i
mov rax, 0
mov [rbp-1026], rax
;end define variable i
; enter loop
jmp __tmp_label_22
__tmp_label_20:
mov rax, rbp
sub rax, 1026
mov [rbp-1034], rax
mov rax, rbp
sub rax, 1026
mov [rbp-1042], rax
mov rax, [rbp-1026]
mov rbx, 1
add rax, rbx
mov [rbp-1050], rax
mov rax, [rbp-1026]
mov rbx, [rbp-1050]
mov rax, [rbp-1034]
mov [rax], rbx
mov rax, rbx
mov [rbp-1058], rax
__tmp_label_22:
mov rax, rbp
sub rax, 1026
mov [rbp-1066], rax
mov rax, [rbp-1026]
mov rbx, 20
cmp rax, rbx
jl __tmp_label_23
mov rax, 0
jmp __tmp_label_24
__tmp_label_23:
mov rax, 1
__tmp_label_24:
mov [rbp-1082], rax
mov rax, [rbp-1082]
cmp rax, 0
je __tmp_label_21
mov rax, __temp_str_25
mov [rbp-1090], rax
mov rax, rbp
sub rax, 1026
mov [rbp-1098], rax
mov rax, [rbp-1026]
mov [rbp-1106], rax
mov rdi, [rbp-1106]
mov rax, rbp
sub rax, 8
mov [rbp-1114], rax
call fibo
mov [rbp-1122], rax
mov rax, [rbp-1122]
mov [rbp-1130], rax
mov rdi, [rbp-1090]
mov rsi, [rbp-1130]
mov rax, rbp
sub rax, 8
mov [rbp-1138], rax
call printf
jmp __tmp_label_20
__tmp_label_21:
; exit loop
mov rax, __temp_str_26
mov [rbp-1026], rax
mov rdi, [rbp-1026]
mov rax, rbp
sub rax, 8
mov [rbp-1034], rax
call printf
mov rax, __temp_str_27
mov [rbp-1042], rax
mov rax, 1
mov rbx, 1
cmp rax, 0
je __tmp_label_25
mov rax, rbx
jmp __tmp_label_26
__tmp_label_25:
mov rax, 0
__tmp_label_26:
cmp rax, 0
jne __tmp_label_27
jmp __tmp_label_28
__tmp_label_27:
mov rax, 1
__tmp_label_28:
mov [rbp-1058], rax
mov rax, 1
mov rbx, 1
cmp rax, 0
je __tmp_label_29
mov rax, rbx
jmp __tmp_label_30
__tmp_label_29:
mov rax, 0
__tmp_label_30:
cmp rax, 0
jne __tmp_label_31
jmp __tmp_label_32
__tmp_label_31:
mov rax, 1
__tmp_label_32:
mov [rbp-1074], rax
mov rax, [rbp-1058]
mov rbx, [rbp-1074]
cmp rax, 0
je __tmp_label_33
mov rax, rbx
jmp __tmp_label_34
__tmp_label_33:
mov rax, 0
__tmp_label_34:
cmp rax, 0
jne __tmp_label_35
jmp __tmp_label_36
__tmp_label_35:
mov rax, 1
__tmp_label_36:
mov [rbp-1090], rax
mov rax, [rbp-1090]
mov [rbp-1098], rax
mov rdi, [rbp-1042]
mov rsi, [rbp-1098]
mov rax, rbp
sub rax, 8
mov [rbp-1106], rax
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
