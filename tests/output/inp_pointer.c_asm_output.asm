section .data
__printf_size: equ 16
__malloc_size: equ 16
__temp_str_2 db `a[4] %d\n`, 0
__temp_str_3 db `*a: %d\n`, 0
__temp_str_4 db `*--a %d\n`, 0
__temp_str_5 db `*--a %d\n`, 0
__temp_str_6 db `s %c\n`, 0
__temp_str_7 db `s %s`, 0
__temp_str_8 db `arr[0][0] %d\n`, 0
__temp_str_9 db `arr[1][0] %d\n`, 0
__temp_str_10 db `arr[1][1] %d\n`, 0
__temp_str_11 db `b is null pointer\n`, 0
__main_size: equ 1328
section .text
extern printf
extern malloc
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
mov rax, 10
mov rbx, 8
mul rbx
mov [rsp+8], rax
mov rax, [rsp+8]
mov [rsp+16], rax
mov rdi, [rsp+16]
mov rax, rsp
add rax, 0
mov [rsp+24], rax
call malloc
mov [rsp+32], rax
;define variable a
mov rax, [rsp+32]
mov [rsp+0], rax
;end define variable a
;define variable i
mov rax, 0
mov [rsp+40], rax
;end define variable i
; enter loop
__tmp_label_0:
mov rax, rsp
add rax, 40
mov [rsp+48], rax
mov rax, [rsp+40]
mov rbx, 10
cmp rax, rbx
jl __tmp_label_2
mov rax, 0
jmp __tmp_label_3
__tmp_label_2:
mov rax, 1
__tmp_label_3:
mov [rsp+56], rax
mov rax, [rsp+56]
cmp rax, 0
je __tmp_label_1
mov rax, rsp
add rax, 0
mov [rsp+64], rax
mov rax, rsp
add rax, 40
mov [rsp+72], rax
mov rax, [rsp+40]
mov rbx, 8
mul rbx
mov rbx, [rsp+0]
add rbx, rax
mov [rsp+80], rbx
mov rax, [rbx]
mov [rsp+88], rax
mov rax, rsp
add rax, 40
mov [rsp+96], rax
mov rax, 2
mov rbx, [rsp+40]
mul rbx
mov [rsp+104], rax
mov rax, [rsp+88]
mov rbx, [rsp+104]
mov rax, [rsp+104]
mov rbx, [rsp+80]
mov [rbx], rax
mov [rsp+112], rax
mov rax, rsp
add rax, 40
mov [rsp+120], rax
mov rax, rsp
add rax, 40
mov [rsp+128], rax
mov rax, [rsp+40]
mov rbx, 1
add rax, rbx
mov [rsp+136], rax
mov rax, [rsp+40]
mov rbx, [rsp+136]
mov rax, [rsp+136]
mov rbx, [rsp+120]
mov [rbx], rax
mov [rsp+144], rax
jmp __tmp_label_0
__tmp_label_1:
; exit loop
mov rax, __temp_str_2
mov [rsp+40], rax
mov rax, rsp
add rax, 0
mov [rsp+48], rax
mov rax, 4
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rsp+0]
add rax, rbx
mov [rsp+56], rax
mov rax, [rsp+56]
mov [rsp+64], rax
mov rax, [rax]
mov [rsp+72], rax
mov rax, [rsp+72]
mov [rsp+80], rax
mov rdi, [rsp+40]
mov rsi, [rsp+80]
mov rax, rsp
add rax, 0
mov [rsp+88], rax
call printf
mov [rsp+96], rax
;define variable i
mov rax, 0
mov [rsp+96], rax
;end define variable i
; enter loop
__tmp_label_4:
; postfix op apply
mov rax, rsp
add rax, 96
mov [rsp+104], rax
mov rax, [rsp+96]
mov [rsp+112], rax
add rax, 1
mov rbx, [rsp+104]
mov [rbx], rax
; postfix op finish
mov rax, [rsp+112]
mov rbx, 10
cmp rax, rbx
jl __tmp_label_6
mov rax, 0
jmp __tmp_label_7
__tmp_label_6:
mov rax, 1
__tmp_label_7:
mov [rsp+120], rax
mov rax, [rsp+120]
cmp rax, 0
je __tmp_label_5
mov rax, __temp_str_3
mov [rsp+128], rax
; postfix op apply
mov rax, rsp
add rax, 0
mov [rsp+136], rax
mov rax, [rsp+0]
mov [rsp+144], rax
add rax, 8
mov rbx, [rsp+136]
mov [rbx], rax
; postfix op finish
mov rax, [rsp+144]
mov [rsp+152], rax
mov rax, [rax]
mov [rsp+160], rax
mov rax, [rsp+160]
mov [rsp+168], rax
mov rdi, [rsp+128]
mov rsi, [rsp+168]
mov rax, rsp
add rax, 0
mov [rsp+176], rax
call printf
mov [rsp+184], rax
jmp __tmp_label_4
__tmp_label_5:
; exit loop
mov rax, __temp_str_4
mov [rsp+128], rax
; unary op apply
mov rax, rsp
add rax, 0
mov [rsp+136], rax
; operand code: [rsp+0]
mov rax, [rsp+0]
sub rax, 8
mov rbx, [rsp+136]
mov [rbx], rax
mov [rsp+144], rax
; unary op finish
mov rax, [rsp+144]
mov [rsp+152], rax
mov rax, [rax]
mov [rsp+160], rax
mov rax, [rsp+160]
mov [rsp+168], rax
mov rdi, [rsp+128]
mov rsi, [rsp+168]
mov rax, rsp
add rax, 0
mov [rsp+176], rax
call printf
mov [rsp+184], rax
mov rax, __temp_str_5
mov [rsp+184], rax
; unary op apply
mov rax, rsp
add rax, 0
mov [rsp+192], rax
; operand code: [rsp+0]
mov rax, [rsp+0]
sub rax, 8
mov rbx, [rsp+192]
mov [rbx], rax
mov [rsp+200], rax
; unary op finish
mov rax, [rsp+200]
mov [rsp+208], rax
mov rax, [rax]
mov [rsp+216], rax
mov rax, [rsp+216]
mov [rsp+224], rax
mov rdi, [rsp+184]
mov rsi, [rsp+224]
mov rax, rsp
add rax, 0
mov [rsp+232], rax
call printf
mov [rsp+240], rax
mov rax, 10
mov rbx, 1
mul rbx
mov [rsp+248], rax
mov rax, [rsp+248]
mov [rsp+256], rax
mov rdi, [rsp+256]
mov rax, rsp
add rax, 0
mov [rsp+264], rax
call malloc
mov [rsp+272], rax
;define variable s
mov rax, [rsp+272]
mov [rsp+240], rax
;end define variable s
mov rax, rsp
add rax, 240
mov [rsp+280], rax
mov rax, 0
mov rbx, 1
mul rbx
mov rbx, [rsp+240]
add rbx, rax
mov [rsp+288], rbx
mov rax, [rbx]
mov [rsp+296], rax
mov rax, [rsp+296]
mov rbx, 49
mov rax, 49
mov rbx, [rsp+288]
mov [rbx], rax
mov [rsp+297], rax
mov rax, rsp
add rax, 240
mov [rsp+298], rax
mov rax, 1
mov rbx, 1
mul rbx
mov rbx, [rsp+240]
add rbx, rax
mov [rsp+306], rbx
mov rax, [rbx]
mov [rsp+314], rax
mov rax, [rsp+314]
mov rbx, 104
mov rax, 104
mov rbx, [rsp+306]
mov [rbx], rax
mov [rsp+315], rax
mov rax, rsp
add rax, 240
mov [rsp+316], rax
mov rax, 2
mov rbx, 1
mul rbx
mov rbx, [rsp+240]
add rbx, rax
mov [rsp+324], rbx
mov rax, [rbx]
mov [rsp+332], rax
mov rax, [rsp+332]
mov rbx, 101
mov rax, 101
mov rbx, [rsp+324]
mov [rbx], rax
mov [rsp+333], rax
mov rax, rsp
add rax, 240
mov [rsp+334], rax
mov rax, 3
mov rbx, 1
mul rbx
mov rbx, [rsp+240]
add rbx, rax
mov [rsp+342], rbx
mov rax, [rbx]
mov [rsp+350], rax
mov rax, [rsp+350]
mov rbx, 108
mov rax, 108
mov rbx, [rsp+342]
mov [rbx], rax
mov [rsp+351], rax
mov rax, rsp
add rax, 240
mov [rsp+352], rax
mov rax, 4
mov rbx, 1
mul rbx
mov rbx, [rsp+240]
add rbx, rax
mov [rsp+360], rbx
mov rax, [rbx]
mov [rsp+368], rax
mov rax, [rsp+368]
mov rbx, 108
mov rax, 108
mov rbx, [rsp+360]
mov [rbx], rax
mov [rsp+369], rax
mov rax, rsp
add rax, 240
mov [rsp+370], rax
mov rax, 5
mov rbx, 1
mul rbx
mov rbx, [rsp+240]
add rbx, rax
mov [rsp+378], rbx
mov rax, [rbx]
mov [rsp+386], rax
mov rax, [rsp+386]
mov rbx, 111
mov rax, 111
mov rbx, [rsp+378]
mov [rbx], rax
mov [rsp+387], rax
mov rax, rsp
add rax, 240
mov [rsp+388], rax
mov rax, 6
mov rbx, 1
mul rbx
mov rbx, [rsp+240]
add rbx, rax
mov [rsp+396], rbx
mov rax, [rbx]
mov [rsp+404], rax
mov rax, [rsp+404]
mov rbx, 10
mov rax, 10
mov rbx, [rsp+396]
mov [rbx], rax
mov [rsp+405], rax
mov rax, rsp
add rax, 240
mov [rsp+406], rax
mov rax, 7
mov rbx, 1
mul rbx
mov rbx, [rsp+240]
add rbx, rax
mov [rsp+414], rbx
mov rax, [rbx]
mov [rsp+422], rax
mov rax, [rsp+422]
mov rbx, 0
mov rax, 0
mov rbx, [rsp+414]
mov [rbx], rax
mov [rsp+423], rax
mov rax, __temp_str_6
mov [rsp+424], rax
; unary op apply
mov rax, rsp
add rax, 240
mov [rsp+432], rax
; operand code: [rsp+240]
mov rax, [rsp+240]
add rax, 1
mov rbx, [rsp+432]
mov [rbx], rax
mov [rsp+440], rax
; unary op finish
mov rax, [rsp+440]
mov [rsp+448], rax
mov rax, [rax]
mov [rsp+456], rax
mov rax, [rsp+456]
mov [rsp+457], rax
mov rdi, [rsp+424]
mov rsi, [rsp+457]
mov rax, rsp
add rax, 0
mov [rsp+458], rax
call printf
mov [rsp+466], rax
mov rax, __temp_str_7
mov [rsp+466], rax
mov rax, rsp
add rax, 240
mov [rsp+474], rax
mov rax, [rsp+240]
mov [rsp+482], rax
mov rdi, [rsp+466]
mov rsi, [rsp+482]
mov rax, rsp
add rax, 0
mov [rsp+490], rax
call printf
mov [rsp+498], rax
mov rax, 10
mov rbx, 8
mul rbx
mov [rsp+506], rax
mov rax, [rsp+506]
mov [rsp+514], rax
mov rdi, [rsp+514]
mov rax, rsp
add rax, 0
mov [rsp+522], rax
call malloc
mov [rsp+530], rax
;define variable arr
mov rax, [rsp+530]
mov [rsp+498], rax
;end define variable arr
mov rax, rsp
add rax, 498
mov [rsp+538], rax
mov rax, [rsp+498]
mov [rsp+546], rax
mov rax, [rax]
mov [rsp+554], rax
mov rax, 10
mov rbx, 8
mul rbx
mov [rsp+562], rax
mov rax, [rsp+562]
mov [rsp+570], rax
mov rdi, [rsp+570]
mov rax, rsp
add rax, 0
mov [rsp+578], rax
call malloc
mov [rsp+586], rax
mov rax, [rsp+554]
mov rbx, [rsp+586]
mov rax, [rsp+586]
mov rbx, [rsp+546]
mov [rbx], rax
mov [rsp+594], rax
mov rax, rsp
add rax, 498
mov [rsp+602], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rsp+498]
add rax, rbx
mov [rsp+610], rax
mov rax, [rsp+610]
mov [rsp+618], rax
mov rax, [rax]
mov [rsp+626], rax
mov rax, 10
mov rbx, 8
mul rbx
mov [rsp+634], rax
mov rax, [rsp+634]
mov [rsp+642], rax
mov rdi, [rsp+642]
mov rax, rsp
add rax, 0
mov [rsp+650], rax
call malloc
mov [rsp+658], rax
mov rax, [rsp+626]
mov rbx, [rsp+658]
mov rax, [rsp+658]
mov rbx, [rsp+618]
mov [rbx], rax
mov [rsp+666], rax
mov rax, rsp
add rax, 498
mov [rsp+674], rax
mov rax, 2
mov rbx, 8
mul rbx
mov rbx, [rsp+498]
add rbx, rax
mov [rsp+682], rbx
mov rax, [rbx]
mov [rsp+690], rax
mov rax, 10
mov rbx, 8
mul rbx
mov [rsp+698], rax
mov rax, [rsp+698]
mov [rsp+706], rax
mov rdi, [rsp+706]
mov rax, rsp
add rax, 0
mov [rsp+714], rax
call malloc
mov [rsp+722], rax
mov rax, [rsp+690]
mov rbx, [rsp+722]
mov rax, [rsp+722]
mov rbx, [rsp+682]
mov [rbx], rax
mov [rsp+730], rax
mov rax, rsp
add rax, 498
mov [rsp+738], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+498]
add rbx, rax
mov [rsp+746], rbx
mov rax, [rbx]
mov [rsp+754], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+754]
add rbx, rax
mov [rsp+762], rbx
mov rax, [rbx]
mov [rsp+770], rax
mov rax, [rsp+770]
mov rbx, 69
mov rax, 69
mov rbx, [rsp+762]
mov [rbx], rax
mov [rsp+778], rax
mov rax, rsp
add rax, 498
mov [rsp+786], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rsp+498]
add rax, rbx
mov [rsp+794], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+794]
add rbx, rax
mov [rsp+802], rbx
mov rax, [rbx]
mov [rsp+810], rax
mov rax, [rsp+810]
mov [rsp+818], rax
mov rax, [rax]
mov [rsp+826], rax
mov rax, [rsp+826]
mov rbx, 99
mov rax, 99
mov rbx, [rsp+818]
mov [rbx], rax
mov [rsp+834], rax
mov rax, rsp
add rax, 498
mov [rsp+842], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rsp+498]
add rax, rbx
mov [rsp+850], rax
mov rax, [rsp+850]
mov [rsp+858], rax
mov rax, [rax]
mov [rsp+866], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rsp+866]
add rax, rbx
mov [rsp+874], rax
mov rax, [rsp+874]
mov [rsp+882], rax
mov rax, [rax]
mov [rsp+890], rax
mov rax, [rsp+890]
mov rbx, 109
mov rax, 109
mov rbx, [rsp+882]
mov [rbx], rax
mov [rsp+898], rax
mov rax, __temp_str_8
mov [rsp+906], rax
mov rax, rsp
add rax, 498
mov [rsp+914], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+498]
add rbx, rax
mov [rsp+922], rbx
mov rax, [rbx]
mov [rsp+930], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+930]
add rbx, rax
mov [rsp+938], rbx
mov rax, [rbx]
mov [rsp+946], rax
mov rax, [rsp+946]
mov [rsp+954], rax
mov rdi, [rsp+906]
mov rsi, [rsp+954]
mov rax, rsp
add rax, 0
mov [rsp+962], rax
call printf
mov [rsp+970], rax
mov rax, __temp_str_9
mov [rsp+970], rax
mov rax, rsp
add rax, 498
mov [rsp+978], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rsp+498]
add rax, rbx
mov [rsp+986], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+986]
add rbx, rax
mov [rsp+994], rbx
mov rax, [rbx]
mov [rsp+1002], rax
mov rax, [rsp+1002]
mov [rsp+1010], rax
mov rax, [rax]
mov [rsp+1018], rax
mov rax, [rsp+1018]
mov [rsp+1026], rax
mov rdi, [rsp+970]
mov rsi, [rsp+1026]
mov rax, rsp
add rax, 0
mov [rsp+1034], rax
call printf
mov [rsp+1042], rax
mov rax, __temp_str_10
mov [rsp+1042], rax
mov rax, rsp
add rax, 498
mov [rsp+1050], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, [rsp+498]
add rbx, rax
mov [rsp+1058], rbx
mov rax, [rbx]
mov [rsp+1066], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, [rsp+1066]
add rbx, rax
mov [rsp+1074], rbx
mov rax, [rbx]
mov [rsp+1082], rax
mov rax, [rsp+1082]
mov [rsp+1090], rax
mov rdi, [rsp+1042]
mov rsi, [rsp+1090]
mov rax, rsp
add rax, 0
mov [rsp+1098], rax
call printf
mov [rsp+1106], rax
;define variable b
mov rax, 0
mov [rsp+1106], rax
;end define variable b
mov rax, rsp
add rax, 1106
mov [rsp+1114], rax
mov rax, [rsp+1106]
mov rbx, 0
cmp rax, rbx
je __tmp_label_8
mov rax, 0
jmp __tmp_label_9
__tmp_label_8:
mov rax, 1
__tmp_label_9:
mov [rsp+1122], rax
mov rax, 0
cmp rax, [rsp+1122]
je __tmp_label_10
mov rax, __temp_str_11
mov [rsp+1130], rax
mov rdi, [rsp+1130]
mov rax, rsp
add rax, 0
mov [rsp+1138], rax
call printf
mov [rsp+1146], rax
__tmp_label_10:
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
