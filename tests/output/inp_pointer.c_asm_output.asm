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
__main_size: equ 1392
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
xor rax, rax
mov [rsp+40], rax
mov rax, [rsp+32]
mov [rsp+40], rax
;define variable a
mov rax, [rsp+40]
mov [rsp+0], rax
;end define variable a
;define variable i
mov rax, 0
mov [rsp+48], rax
;end define variable i
; enter loop
__tmp_label_0:
mov rax, rsp
add rax, 48
mov [rsp+56], rax
mov rax, [rsp+48]
mov rbx, 10
cmp rax, rbx
jl __tmp_label_2
mov rax, 0
jmp __tmp_label_3
__tmp_label_2:
mov rax, 1
__tmp_label_3:
mov [rsp+72], rax
mov rax, [rsp+72]
cmp rax, 0
je __tmp_label_1
mov rax, rsp
add rax, 0
mov [rsp+80], rax
mov rax, rsp
add rax, 48
mov [rsp+88], rax
mov rax, [rsp+48]
mov rbx, 8
mul rbx
mov rbx, [rsp+0]
add rbx, rax
mov [rsp+96], rbx
mov rax, [rbx]
mov [rsp+104], rax
mov rax, rsp
add rax, 48
mov [rsp+112], rax
mov rax, 2
mov rbx, [rsp+48]
mul rbx
mov [rsp+120], rax
mov rax, [rsp+104]
mov rbx, [rsp+120]
mov rax, [rsp+96]
mov [rax], rbx
mov rax, rbx
mov [rsp+128], rax
mov rax, rsp
add rax, 48
mov [rsp+136], rax
mov rax, rsp
add rax, 48
mov [rsp+144], rax
mov rax, [rsp+48]
mov rbx, 1
add rax, rbx
mov [rsp+152], rax
mov rax, [rsp+48]
mov rbx, [rsp+152]
mov rax, [rsp+136]
mov [rax], rbx
mov rax, rbx
mov [rsp+160], rax
jmp __tmp_label_0
__tmp_label_1:
; exit loop
mov rax, __temp_str_0
mov [rsp+48], rax
mov rax, rsp
add rax, 0
mov [rsp+56], rax
mov rax, 4
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rsp+0]
add rax, rbx
mov [rsp+64], rax
mov rax, [rsp+64]
mov [rsp+72], rax
mov rax, [rax]
mov [rsp+80], rax
mov rax, [rsp+80]
mov [rsp+88], rax
mov rdi, [rsp+48]
mov rsi, [rsp+88]
mov rax, rsp
add rax, 0
mov [rsp+96], rax
call printf
;define variable i
mov rax, 0
mov [rsp+104], rax
;end define variable i
; enter loop
__tmp_label_4:
; postfix op apply
mov rax, rsp
add rax, 104
mov [rsp+112], rax
mov rax, [rsp+104]
mov [rsp+120], rax
add rax, 1
mov rbx, [rsp+112]
mov [rbx], rax
; postfix op finish
mov rax, [rsp+120]
mov rbx, 10
cmp rax, rbx
jl __tmp_label_6
mov rax, 0
jmp __tmp_label_7
__tmp_label_6:
mov rax, 1
__tmp_label_7:
mov [rsp+136], rax
mov rax, [rsp+136]
cmp rax, 0
je __tmp_label_5
mov rax, __temp_str_1
mov [rsp+144], rax
; postfix op apply
mov rax, rsp
add rax, 0
mov [rsp+152], rax
mov rax, [rsp+0]
mov [rsp+160], rax
add rax, 8
mov rbx, [rsp+152]
mov [rbx], rax
; postfix op finish
mov rax, [rsp+160]
mov [rsp+168], rax
mov rax, [rax]
mov [rsp+176], rax
mov rax, [rsp+176]
mov [rsp+184], rax
mov rdi, [rsp+144]
mov rsi, [rsp+184]
mov rax, rsp
add rax, 0
mov [rsp+192], rax
call printf
jmp __tmp_label_4
__tmp_label_5:
; exit loop
mov rax, __temp_str_2
mov [rsp+144], rax
; unary op apply
mov rax, rsp
add rax, 0
mov [rsp+152], rax
; operand code: [rsp+0]
mov rax, [rsp+0]
sub rax, 8
mov rbx, [rsp+152]
mov [rbx], rax
mov [rsp+160], rax
; unary op finish
mov rax, [rsp+160]
mov [rsp+168], rax
mov rax, [rax]
mov [rsp+176], rax
mov rax, [rsp+176]
mov [rsp+184], rax
mov rdi, [rsp+144]
mov rsi, [rsp+184]
mov rax, rsp
add rax, 0
mov [rsp+192], rax
call printf
mov rax, __temp_str_3
mov [rsp+200], rax
; unary op apply
mov rax, rsp
add rax, 0
mov [rsp+208], rax
; operand code: [rsp+0]
mov rax, [rsp+0]
sub rax, 8
mov rbx, [rsp+208]
mov [rbx], rax
mov [rsp+216], rax
; unary op finish
mov rax, [rsp+216]
mov [rsp+224], rax
mov rax, [rax]
mov [rsp+232], rax
mov rax, [rsp+232]
mov [rsp+240], rax
mov rdi, [rsp+200]
mov rsi, [rsp+240]
mov rax, rsp
add rax, 0
mov [rsp+248], rax
call printf
mov rax, 10
mov rbx, 1
mul rbx
mov [rsp+264], rax
mov rax, [rsp+264]
mov [rsp+272], rax
mov rdi, [rsp+272]
mov rax, rsp
add rax, 0
mov [rsp+280], rax
call malloc
mov [rsp+288], rax
xor rax, rax
mov [rsp+296], rax
mov rax, [rsp+288]
mov [rsp+296], rax
;define variable s
mov rax, [rsp+296]
mov [rsp+256], rax
;end define variable s
mov rax, rsp
add rax, 256
mov [rsp+304], rax
mov rax, 0
mov rbx, 1
mul rbx
mov rbx, [rsp+256]
add rbx, rax
mov [rsp+312], rbx
mov al, [rbx]
mov [rsp+320], al
mov al, [rsp+320]
mov bl, 49
mov rax, [rsp+312]
mov [rax], bl
mov al, bl
mov [rsp+321], al
mov rax, rsp
add rax, 256
mov [rsp+322], rax
mov rax, 1
mov rbx, 1
mul rbx
mov rbx, [rsp+256]
add rbx, rax
mov [rsp+330], rbx
mov al, [rbx]
mov [rsp+338], al
mov al, [rsp+338]
mov bl, 104
mov rax, [rsp+330]
mov [rax], bl
mov al, bl
mov [rsp+339], al
mov rax, rsp
add rax, 256
mov [rsp+340], rax
mov rax, 2
mov rbx, 1
mul rbx
mov rbx, [rsp+256]
add rbx, rax
mov [rsp+348], rbx
mov al, [rbx]
mov [rsp+356], al
mov al, [rsp+356]
mov bl, 101
mov rax, [rsp+348]
mov [rax], bl
mov al, bl
mov [rsp+357], al
mov rax, rsp
add rax, 256
mov [rsp+358], rax
mov rax, 3
mov rbx, 1
mul rbx
mov rbx, [rsp+256]
add rbx, rax
mov [rsp+366], rbx
mov al, [rbx]
mov [rsp+374], al
mov al, [rsp+374]
mov bl, 108
mov rax, [rsp+366]
mov [rax], bl
mov al, bl
mov [rsp+375], al
mov rax, rsp
add rax, 256
mov [rsp+376], rax
mov rax, 4
mov rbx, 1
mul rbx
mov rbx, [rsp+256]
add rbx, rax
mov [rsp+384], rbx
mov al, [rbx]
mov [rsp+392], al
mov al, [rsp+392]
mov bl, 108
mov rax, [rsp+384]
mov [rax], bl
mov al, bl
mov [rsp+393], al
mov rax, rsp
add rax, 256
mov [rsp+394], rax
mov rax, 5
mov rbx, 1
mul rbx
mov rbx, [rsp+256]
add rbx, rax
mov [rsp+402], rbx
mov al, [rbx]
mov [rsp+410], al
mov al, [rsp+410]
mov bl, 111
mov rax, [rsp+402]
mov [rax], bl
mov al, bl
mov [rsp+411], al
mov rax, rsp
add rax, 256
mov [rsp+412], rax
mov rax, 6
mov rbx, 1
mul rbx
mov rbx, [rsp+256]
add rbx, rax
mov [rsp+420], rbx
mov al, [rbx]
mov [rsp+428], al
mov al, [rsp+428]
mov bl, 10
mov rax, [rsp+420]
mov [rax], bl
mov al, bl
mov [rsp+429], al
mov rax, rsp
add rax, 256
mov [rsp+430], rax
mov rax, 7
mov rbx, 1
mul rbx
mov rbx, [rsp+256]
add rbx, rax
mov [rsp+438], rbx
mov al, [rbx]
mov [rsp+446], al
mov al, [rsp+446]
mov bl, 0
mov rax, [rsp+438]
mov [rax], bl
mov al, bl
mov [rsp+447], al
mov rax, __temp_str_4
mov [rsp+448], rax
; unary op apply
mov rax, rsp
add rax, 256
mov [rsp+456], rax
; operand code: [rsp+256]
mov rax, [rsp+256]
add rax, 1
mov rbx, [rsp+456]
mov [rbx], rax
mov [rsp+464], rax
; unary op finish
mov rax, [rsp+464]
mov [rsp+472], rax
mov al, [rax]
mov [rsp+480], al
mov al, [rsp+480]
mov [rsp+481], al
mov rdi, [rsp+448]
mov rsi, [rsp+481]
mov rax, rsp
add rax, 0
mov [rsp+482], rax
call printf
mov rax, __temp_str_5
mov [rsp+490], rax
mov rax, rsp
add rax, 256
mov [rsp+498], rax
mov rax, [rsp+256]
mov [rsp+506], rax
mov rdi, [rsp+490]
mov rsi, [rsp+506]
mov rax, rsp
add rax, 0
mov [rsp+514], rax
call printf
mov rax, 10
mov rbx, 8
mul rbx
mov [rsp+530], rax
mov rax, [rsp+530]
mov [rsp+538], rax
mov rdi, [rsp+538]
mov rax, rsp
add rax, 0
mov [rsp+546], rax
call malloc
mov [rsp+554], rax
xor rax, rax
mov [rsp+562], rax
mov rax, [rsp+554]
mov [rsp+562], rax
;define variable arr
mov rax, [rsp+562]
mov [rsp+522], rax
;end define variable arr
mov rax, rsp
add rax, 522
mov [rsp+570], rax
mov rax, [rsp+522]
mov [rsp+578], rax
mov rax, [rax]
mov [rsp+586], rax
mov rax, 10
mov rbx, 8
mul rbx
mov [rsp+594], rax
mov rax, [rsp+594]
mov [rsp+602], rax
mov rdi, [rsp+602]
mov rax, rsp
add rax, 0
mov [rsp+610], rax
call malloc
mov [rsp+618], rax
xor rax, rax
mov [rsp+626], rax
mov rax, [rsp+618]
mov [rsp+626], rax
mov rax, [rsp+586]
mov rbx, [rsp+626]
mov rax, [rsp+578]
mov [rax], rbx
mov rax, rbx
mov [rsp+634], rax
mov rax, rsp
add rax, 522
mov [rsp+642], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rsp+522]
add rax, rbx
mov [rsp+650], rax
mov rax, [rsp+650]
mov [rsp+658], rax
mov rax, [rax]
mov [rsp+666], rax
mov rax, 10
mov rbx, 8
mul rbx
mov [rsp+674], rax
mov rax, [rsp+674]
mov [rsp+682], rax
mov rdi, [rsp+682]
mov rax, rsp
add rax, 0
mov [rsp+690], rax
call malloc
mov [rsp+698], rax
xor rax, rax
mov [rsp+706], rax
mov rax, [rsp+698]
mov [rsp+706], rax
mov rax, [rsp+666]
mov rbx, [rsp+706]
mov rax, [rsp+658]
mov [rax], rbx
mov rax, rbx
mov [rsp+714], rax
mov rax, rsp
add rax, 522
mov [rsp+722], rax
mov rax, 2
mov rbx, 8
mul rbx
mov rbx, [rsp+522]
add rbx, rax
mov [rsp+730], rbx
mov rax, [rbx]
mov [rsp+738], rax
mov rax, 10
mov rbx, 8
mul rbx
mov [rsp+746], rax
mov rax, [rsp+746]
mov [rsp+754], rax
mov rdi, [rsp+754]
mov rax, rsp
add rax, 0
mov [rsp+762], rax
call malloc
mov [rsp+770], rax
xor rax, rax
mov [rsp+778], rax
mov rax, [rsp+770]
mov [rsp+778], rax
mov rax, [rsp+738]
mov rbx, [rsp+778]
mov rax, [rsp+730]
mov [rax], rbx
mov rax, rbx
mov [rsp+786], rax
mov rax, rsp
add rax, 522
mov [rsp+794], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+522]
add rbx, rax
mov [rsp+802], rbx
mov rax, [rbx]
mov [rsp+810], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+810]
add rbx, rax
mov [rsp+818], rbx
mov rax, [rbx]
mov [rsp+826], rax
mov rax, [rsp+826]
mov rbx, 69
mov rax, [rsp+818]
mov [rax], rbx
mov rax, rbx
mov [rsp+834], rax
mov rax, rsp
add rax, 522
mov [rsp+842], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rsp+522]
add rax, rbx
mov [rsp+850], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+850]
add rbx, rax
mov [rsp+858], rbx
mov rax, [rbx]
mov [rsp+866], rax
mov rax, [rsp+866]
mov [rsp+874], rax
mov rax, [rax]
mov [rsp+882], rax
mov rax, [rsp+882]
mov rbx, 99
mov rax, [rsp+874]
mov [rax], rbx
mov rax, rbx
mov [rsp+890], rax
mov rax, rsp
add rax, 522
mov [rsp+898], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rsp+522]
add rax, rbx
mov [rsp+906], rax
mov rax, [rsp+906]
mov [rsp+914], rax
mov rax, [rax]
mov [rsp+922], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rsp+922]
add rax, rbx
mov [rsp+930], rax
mov rax, [rsp+930]
mov [rsp+938], rax
mov rax, [rax]
mov [rsp+946], rax
mov rax, [rsp+946]
mov rbx, 109
mov rax, [rsp+938]
mov [rax], rbx
mov rax, rbx
mov [rsp+954], rax
mov rax, __temp_str_6
mov [rsp+962], rax
mov rax, rsp
add rax, 522
mov [rsp+970], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+522]
add rbx, rax
mov [rsp+978], rbx
mov rax, [rbx]
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
mov rdi, [rsp+962]
mov rsi, [rsp+1010]
mov rax, rsp
add rax, 0
mov [rsp+1018], rax
call printf
mov rax, __temp_str_7
mov [rsp+1026], rax
mov rax, rsp
add rax, 522
mov [rsp+1034], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rsp+522]
add rax, rbx
mov [rsp+1042], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rsp+1042]
add rbx, rax
mov [rsp+1050], rbx
mov rax, [rbx]
mov [rsp+1058], rax
mov rax, [rsp+1058]
mov [rsp+1066], rax
mov rax, [rax]
mov [rsp+1074], rax
mov rax, [rsp+1074]
mov [rsp+1082], rax
mov rdi, [rsp+1026]
mov rsi, [rsp+1082]
mov rax, rsp
add rax, 0
mov [rsp+1090], rax
call printf
mov rax, __temp_str_8
mov [rsp+1098], rax
mov rax, rsp
add rax, 522
mov [rsp+1106], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, [rsp+522]
add rbx, rax
mov [rsp+1114], rbx
mov rax, [rbx]
mov [rsp+1122], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, [rsp+1122]
add rbx, rax
mov [rsp+1130], rbx
mov rax, [rbx]
mov [rsp+1138], rax
mov rax, [rsp+1138]
mov [rsp+1146], rax
mov rdi, [rsp+1098]
mov rsi, [rsp+1146]
mov rax, rsp
add rax, 0
mov [rsp+1154], rax
call printf
;define variable b
mov rax, 0
mov [rsp+1162], rax
;end define variable b
mov rax, rsp
add rax, 1162
mov [rsp+1170], rax
mov rax, [rsp+1162]
mov rbx, 0
cmp rax, rbx
je __tmp_label_8
mov rax, 0
jmp __tmp_label_9
__tmp_label_8:
mov rax, 1
__tmp_label_9:
mov [rsp+1186], rax
mov rax, 0
cmp rax, [rsp+1186]
je __tmp_label_10
mov rax, __temp_str_9
mov [rsp+1194], rax
mov rdi, [rsp+1194]
mov rax, rsp
add rax, 0
mov [rsp+1202], rax
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
