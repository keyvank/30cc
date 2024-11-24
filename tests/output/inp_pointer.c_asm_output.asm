section .data
__temp_str_0 db `a[4] %d\n`, 0
__temp_str_1 db `*a: %d\n`, 0
__temp_str_2 db `*--a %d\n`, 0
__temp_str_3 db `*--a %d\n`, 0
__temp_str_4 db `s %c\n`, 0
__temp_str_5 db `s %s`, 0
__temp_str_6 db `arr[0][0] %d\n`, 0
__temp_str_7 db `arr[1][0] %d\n`, 0
__temp_str_8 db `arr[1][1] %d\n`, 0
__temp_str_9 db `b is null pointer\n`, 0
__main_size: equ 1344
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
mov [rsp+64], rax
mov rax, [rsp+64]
cmp rax, 0
je __tmp_label_1
mov rax, rsp
add rax, 0
mov [rsp+72], rax
mov rax, rsp
add rax, 40
mov [rsp+80], rax
mov rax, [rsp+40]
mov rbx, 8
mul rbx
mov rbx, [rsp+0]
add rbx, rax
mov [rsp+88], rbx
mov rax, [rbx]
mov [rsp+96], rax
mov rax, rsp
add rax, 40
mov [rsp+104], rax
mov rax, 2
mov rbx, [rsp+40]
mul rbx
mov [rsp+112], rax
mov rax, [rsp+96]
mov rbx, [rsp+112]
mov rax, [rsp+88]
mov [rax], rbx
mov rax, rbx
mov [rsp+120], rax
mov rax, rsp
add rax, 40
mov [rsp+128], rax
mov rax, rsp
add rax, 40
mov [rsp+136], rax
mov rax, [rsp+40]
mov rbx, 1
add rax, rbx
mov [rsp+144], rax
mov rax, [rsp+40]
mov rbx, [rsp+144]
mov rax, [rsp+128]
mov [rax], rbx
mov rax, rbx
mov [rsp+152], rax
jmp __tmp_label_0
__tmp_label_1:
; exit loop
mov rax, __temp_str_0
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
mov [rsp+128], rax
mov rax, [rsp+128]
cmp rax, 0
je __tmp_label_5
mov rax, __temp_str_1
mov [rsp+136], rax
; postfix op apply
mov rax, rsp
add rax, 0
mov [rsp+144], rax
mov rax, [rsp+0]
mov [rsp+152], rax
add rax, 8
mov rbx, [rsp+144]
mov [rbx], rax
; postfix op finish
mov rax, [rsp+152]
mov [rsp+160], rax
mov rax, [rax]
mov [rsp+168], rax
mov rax, [rsp+168]
mov [rsp+176], rax
mov rdi, [rsp+136]
mov rsi, [rsp+176]
mov rax, rsp
add rax, 0
mov [rsp+184], rax
call printf
jmp __tmp_label_4
__tmp_label_5:
; exit loop
mov rax, __temp_str_2
mov [rsp+136], rax
; unary op apply
mov rax, rsp
add rax, 0
mov [rsp+144], rax
; operand code: [rsp+0]
mov rax, [rsp+0]
sub rax, 8
mov rbx, [rsp+144]
mov [rbx], rax
mov [rsp+152], rax
; unary op finish
mov rax, [rsp+152]
mov [rsp+160], rax
mov rax, [rax]
mov [rsp+168], rax
mov rax, [rsp+168]
mov [rsp+176], rax
mov rdi, [rsp+136]
mov rsi, [rsp+176]
mov rax, rsp
add rax, 0
mov [rsp+184], rax
call printf
mov rax, __temp_str_3
mov [rsp+192], rax
; unary op apply
mov rax, rsp
add rax, 0
mov [rsp+200], rax
; operand code: [rsp+0]
mov rax, [rsp+0]
sub rax, 8
mov rbx, [rsp+200]
mov [rbx], rax
mov [rsp+208], rax
; unary op finish
mov rax, [rsp+208]
mov [rsp+216], rax
mov rax, [rax]
mov [rsp+224], rax
mov rax, [rsp+224]
mov [rsp+232], rax
mov rdi, [rsp+192]
mov rsi, [rsp+232]
mov rax, rsp
add rax, 0
mov [rsp+240], rax
call printf
mov rax, 10
mov rbx, 1
mul rbx
mov [rsp+256], rax
mov rax, [rsp+256]
mov [rsp+264], rax
mov rdi, [rsp+264]
mov rax, rsp
add rax, 0
mov [rsp+272], rax
call malloc
mov [rsp+280], rax
;define variable s
mov rax, [rsp+280]
mov [rsp+248], rax
;end define variable s
mov rax, rsp
add rax, 248
mov [rsp+288], rax
mov rax, 0
mov rbx, 1
mul rbx
mov rbx, [rsp+248]
add rbx, rax
mov [rsp+296], rbx
mov al, [rbx]
mov [rsp+304], al
mov al, [rsp+304]
mov bl, 49
mov rax, [rsp+296]
mov [rax], bl
mov al, bl
mov [rsp+305], al
mov rax, rsp
add rax, 248
mov [rsp+306], rax
mov rax, 1
mov rbx, 1
mul rbx
mov rbx, [rsp+248]
add rbx, rax
mov [rsp+314], rbx
mov al, [rbx]
mov [rsp+322], al
mov al, [rsp+322]
mov bl, 104
mov rax, [rsp+314]
mov [rax], bl
mov al, bl
mov [rsp+323], al
mov rax, rsp
add rax, 248
mov [rsp+324], rax
mov rax, 2
mov rbx, 1
mul rbx
mov rbx, [rsp+248]
add rbx, rax
mov [rsp+332], rbx
mov al, [rbx]
mov [rsp+340], al
mov al, [rsp+340]
mov bl, 101
mov rax, [rsp+332]
mov [rax], bl
mov al, bl
mov [rsp+341], al
mov rax, rsp
add rax, 248
mov [rsp+342], rax
mov rax, 3
mov rbx, 1
mul rbx
mov rbx, [rsp+248]
add rbx, rax
mov [rsp+350], rbx
mov al, [rbx]
mov [rsp+358], al
mov al, [rsp+358]
mov bl, 108
mov rax, [rsp+350]
mov [rax], bl
mov al, bl
mov [rsp+359], al
mov rax, rsp
add rax, 248
mov [rsp+360], rax
mov rax, 4
mov rbx, 1
mul rbx
mov rbx, [rsp+248]
add rbx, rax
mov [rsp+368], rbx
mov al, [rbx]
mov [rsp+376], al
mov al, [rsp+376]
mov bl, 108
mov rax, [rsp+368]
mov [rax], bl
mov al, bl
mov [rsp+377], al
mov rax, rsp
add rax, 248
mov [rsp+378], rax
mov rax, 5
mov rbx, 1
mul rbx
mov rbx, [rsp+248]
add rbx, rax
mov [rsp+386], rbx
mov al, [rbx]
mov [rsp+394], al
mov al, [rsp+394]
mov bl, 111
mov rax, [rsp+386]
mov [rax], bl
mov al, bl
mov [rsp+395], al
mov rax, rsp
add rax, 248
mov [rsp+396], rax
mov rax, 6
mov rbx, 1
mul rbx
mov rbx, [rsp+248]
add rbx, rax
mov [rsp+404], rbx
mov al, [rbx]
mov [rsp+412], al
mov al, [rsp+412]
mov bl, 10
mov rax, [rsp+404]
mov [rax], bl
mov al, bl
mov [rsp+413], al
mov rax, rsp
add rax, 248
mov [rsp+414], rax
mov rax, 7
mov rbx, 1
mul rbx
mov rbx, [rsp+248]
add rbx, rax
mov [rsp+422], rbx
mov al, [rbx]
mov [rsp+430], al
mov al, [rsp+430]
mov bl, 0
mov rax, [rsp+422]
mov [rax], bl
mov al, bl
mov [rsp+431], al
mov rax, __temp_str_4
mov [rsp+432], rax
; unary op apply
mov rax, rsp
add rax, 248
mov [rsp+440], rax
; operand code: [rsp+248]
mov rax, [rsp+248]
add rax, 1
mov rbx, [rsp+440]
mov [rbx], rax
mov [rsp+448], rax
; unary op finish
mov rax, [rsp+448]
mov [rsp+456], rax
mov al, [rax]
mov [rsp+464], al
mov al, [rsp+464]
mov [rsp+465], al
mov rdi, [rsp+432]
mov rsi, [rsp+465]
mov rax, rsp
add rax, 0
mov [rsp+466], rax
call printf
mov rax, __temp_str_5
mov [rsp+474], rax
mov rax, rsp
add rax, 248
mov [rsp+482], rax
mov rax, [rsp+248]
mov [rsp+490], rax
mov rdi, [rsp+474]
mov rsi, [rsp+490]
mov rax, rsp
add rax, 0
mov [rsp+498], rax
call printf
mov rax, 10
mov rbx, 8
mul rbx
mov [rsp+514], rax
mov rax, [rsp+514]
mov [rsp+522], rax
mov rdi, [rsp+522]
mov rax, rsp
add rax, 0
mov [rsp+530], rax
call malloc
mov [rsp+538], rax
;define variable arr
mov rax, [rsp+538]
mov [rsp+506], rax
;end define variable arr
mov rax, rsp
add rax, 506
mov [rsp+546], rax
mov rax, [rsp+506]
mov [rsp+554], rax
mov rax, [rax]
mov [rsp+562], rax
mov rax, 10
mov rbx, 8
mul rbx
mov [rsp+570], rax
mov rax, [rsp+570]
mov [rsp+578], rax
mov rdi, [rsp+578]
mov rax, rsp
add rax, 0
mov [rsp+586], rax
call malloc
mov [rsp+594], rax
mov rax, [rsp+562]
mov rbx, [rsp+594]
mov rax, [rsp+554]
mov [rax], rbx
mov rax, rbx
mov [rsp+602], rax
mov rax, rsp
add rax, 506
mov [rsp+610], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rsp+506]
add rax, rbx
mov [rsp+618], rax
mov rax, [rsp+618]
mov [rsp+626], rax
mov rax, [rax]
mov [rsp+634], rax
mov rax, 10
mov rbx, 8
mul rbx
mov [rsp+642], rax
mov rax, [rsp+642]
mov [rsp+650], rax
mov rdi, [rsp+650]
mov rax, rsp
add rax, 0
mov [rsp+658], rax
call malloc
mov [rsp+666], rax
mov rax, [rsp+634]
mov rbx, [rsp+666]
mov rax, [rsp+626]
mov [rax], rbx
mov rax, rbx
mov [rsp+674], rax
mov rax, rsp
add rax, 506
mov [rsp+682], rax
mov rax, 2
mov rbx, 8
mul rbx
mov rbx, [rsp+506]
add rbx, rax
mov [rsp+690], rbx
mov rax, [rbx]
mov [rsp+698], rax
mov rax, 10
mov rbx, 8
mul rbx
mov [rsp+706], rax
mov rax, [rsp+706]
mov [rsp+714], rax
mov rdi, [rsp+714]
mov rax, rsp
add rax, 0
mov [rsp+722], rax
call malloc
mov [rsp+730], rax
mov rax, [rsp+698]
mov rbx, [rsp+730]
mov rax, [rsp+690]
mov [rax], rbx
mov rax, rbx
mov [rsp+738], rax
mov rax, rsp
add rax, 506
mov [rsp+746], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+506]
add rbx, rax
mov [rsp+754], rbx
mov rax, [rbx]
mov [rsp+762], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+762]
add rbx, rax
mov [rsp+770], rbx
mov rax, [rbx]
mov [rsp+778], rax
mov rax, [rsp+778]
mov rbx, 69
mov rax, [rsp+770]
mov [rax], rbx
mov rax, rbx
mov [rsp+786], rax
mov rax, rsp
add rax, 506
mov [rsp+794], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rsp+506]
add rax, rbx
mov [rsp+802], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+802]
add rbx, rax
mov [rsp+810], rbx
mov rax, [rbx]
mov [rsp+818], rax
mov rax, [rsp+818]
mov [rsp+826], rax
mov rax, [rax]
mov [rsp+834], rax
mov rax, [rsp+834]
mov rbx, 99
mov rax, [rsp+826]
mov [rax], rbx
mov rax, rbx
mov [rsp+842], rax
mov rax, rsp
add rax, 506
mov [rsp+850], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rsp+506]
add rax, rbx
mov [rsp+858], rax
mov rax, [rsp+858]
mov [rsp+866], rax
mov rax, [rax]
mov [rsp+874], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rsp+874]
add rax, rbx
mov [rsp+882], rax
mov rax, [rsp+882]
mov [rsp+890], rax
mov rax, [rax]
mov [rsp+898], rax
mov rax, [rsp+898]
mov rbx, 109
mov rax, [rsp+890]
mov [rax], rbx
mov rax, rbx
mov [rsp+906], rax
mov rax, __temp_str_6
mov [rsp+914], rax
mov rax, rsp
add rax, 506
mov [rsp+922], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+506]
add rbx, rax
mov [rsp+930], rbx
mov rax, [rbx]
mov [rsp+938], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+938]
add rbx, rax
mov [rsp+946], rbx
mov rax, [rbx]
mov [rsp+954], rax
mov rax, [rsp+954]
mov [rsp+962], rax
mov rdi, [rsp+914]
mov rsi, [rsp+962]
mov rax, rsp
add rax, 0
mov [rsp+970], rax
call printf
mov rax, __temp_str_7
mov [rsp+978], rax
mov rax, rsp
add rax, 506
mov [rsp+986], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rsp+506]
add rax, rbx
mov [rsp+994], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+994]
add rbx, rax
mov [rsp+1002], rbx
mov rax, [rbx]
mov [rsp+1010], rax
mov rax, [rsp+1010]
mov [rsp+1018], rax
mov rax, [rax]
mov [rsp+1026], rax
mov rax, [rsp+1026]
mov [rsp+1034], rax
mov rdi, [rsp+978]
mov rsi, [rsp+1034]
mov rax, rsp
add rax, 0
mov [rsp+1042], rax
call printf
mov rax, __temp_str_8
mov [rsp+1050], rax
mov rax, rsp
add rax, 506
mov [rsp+1058], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, [rsp+506]
add rbx, rax
mov [rsp+1066], rbx
mov rax, [rbx]
mov [rsp+1074], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, [rsp+1074]
add rbx, rax
mov [rsp+1082], rbx
mov rax, [rbx]
mov [rsp+1090], rax
mov rax, [rsp+1090]
mov [rsp+1098], rax
mov rdi, [rsp+1050]
mov rsi, [rsp+1098]
mov rax, rsp
add rax, 0
mov [rsp+1106], rax
call printf
;define variable b
mov rax, 0
mov [rsp+1114], rax
;end define variable b
mov rax, rsp
add rax, 1114
mov [rsp+1122], rax
mov rax, [rsp+1114]
mov rbx, 0
cmp rax, rbx
je __tmp_label_8
mov rax, 0
jmp __tmp_label_9
__tmp_label_8:
mov rax, 1
__tmp_label_9:
mov [rsp+1138], rax
mov rax, 0
cmp rax, [rsp+1138]
je __tmp_label_10
mov rax, __temp_str_9
mov [rsp+1146], rax
mov rdi, [rsp+1146]
mov rax, rsp
add rax, 0
mov [rsp+1154], rax
call printf
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
