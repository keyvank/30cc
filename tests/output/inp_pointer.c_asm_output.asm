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
__main_size: equ 1600
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
mov [rbp-24], rax
mov rax, [rbp-24]
mov [rbp-32], rax
mov rdi, [rbp-32]
mov rax, rbp
sub rax, 8
mov [rbp-40], rax
call malloc
mov [rbp-48], rax
xor rax, rax
mov [rbp-56], rax
mov rax, [rbp-48]
mov [rbp-56], rax
;define variable a
mov rax, [rbp-56]
mov [rbp-8], rax
;end define variable a
;define variable i
mov rax, 0
mov [rbp-64], rax
;end define variable i
; enter loop
__tmp_label_0:
mov rax, rbp
sub rax, 64
mov [rbp-72], rax
mov rax, [rbp-64]
mov rbx, 10
cmp rax, rbx
jl __tmp_label_2
mov rax, 0
jmp __tmp_label_3
__tmp_label_2:
mov rax, 1
__tmp_label_3:
mov [rbp-96], rax
mov rax, [rbp-96]
cmp rax, 0
je __tmp_label_1
mov rax, rbp
sub rax, 8
mov [rbp-104], rax
mov rax, rbp
sub rax, 64
mov [rbp-112], rax
mov rax, [rbp-64]
mov rbx, 8
mul rbx
mov rbx, [rbp-8]
add rbx, rax
mov [rbp-120], rbx
mov rax, [rbx]
mov [rbp-128], rax
mov rax, rbp
sub rax, 64
mov [rbp-136], rax
mov rax, 2
mov rbx, [rbp-64]
mul rbx
mov [rbp-152], rax
mov rax, [rbp-128]
mov rbx, [rbp-152]
mov rax, [rbp-120]
mov [rax], rbx
mov rax, rbx
mov [rbp-168], rax
mov rax, rbp
sub rax, 64
mov [rbp-176], rax
mov rax, rbp
sub rax, 64
mov [rbp-184], rax
mov rax, [rbp-64]
mov rbx, 1
add rax, rbx
mov [rbp-200], rax
mov rax, [rbp-64]
mov rbx, [rbp-200]
mov rax, [rbp-176]
mov [rax], rbx
mov rax, rbx
mov [rbp-216], rax
jmp __tmp_label_0
__tmp_label_1:
; exit loop
mov rax, __temp_str_0
mov [rbp-64], rax
mov rax, rbp
sub rax, 8
mov [rbp-72], rax
mov rax, 4
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rbp-8]
add rax, rbx
mov [rbp-80], rax
mov rax, [rbp-80]
mov [rbp-96], rax
mov rax, [rax]
mov [rbp-104], rax
mov rax, [rbp-104]
mov [rbp-112], rax
mov rdi, [rbp-64]
mov rsi, [rbp-112]
mov rax, rbp
sub rax, 8
mov [rbp-120], rax
call printf
;define variable i
mov rax, 0
mov [rbp-128], rax
;end define variable i
; enter loop
__tmp_label_4:
; postfix op apply
mov rax, rbp
sub rax, 128
mov [rbp-136], rax
mov rax, [rbp-128]
mov [rbp-144], rax
add rax, 1
mov rbx, [rbp-136]
mov [rbx], rax
; postfix op finish
mov rax, [rbp-144]
mov rbx, 10
cmp rax, rbx
jl __tmp_label_6
mov rax, 0
jmp __tmp_label_7
__tmp_label_6:
mov rax, 1
__tmp_label_7:
mov [rbp-168], rax
mov rax, [rbp-168]
cmp rax, 0
je __tmp_label_5
mov rax, __temp_str_1
mov [rbp-176], rax
; postfix op apply
mov rax, rbp
sub rax, 8
mov [rbp-184], rax
mov rax, [rbp-8]
mov [rbp-192], rax
add rax, 8
mov rbx, [rbp-184]
mov [rbx], rax
; postfix op finish
mov rax, [rbp-192]
mov [rbp-200], rax
mov rax, [rax]
mov [rbp-208], rax
mov rax, [rbp-208]
mov [rbp-216], rax
mov rdi, [rbp-176]
mov rsi, [rbp-216]
mov rax, rbp
sub rax, 8
mov [rbp-224], rax
call printf
jmp __tmp_label_4
__tmp_label_5:
; exit loop
mov rax, __temp_str_2
mov [rbp-176], rax
; unary op apply
mov rax, rbp
sub rax, 8
mov [rbp-184], rax
; operand code: [rbp-8]
mov rax, [rbp-8]
sub rax, 8
mov rbx, [rbp-184]
mov [rbx], rax
mov [rbp-192], rax
; unary op finish
mov rax, [rbp-192]
mov [rbp-200], rax
mov rax, [rax]
mov [rbp-208], rax
mov rax, [rbp-208]
mov [rbp-216], rax
mov rdi, [rbp-176]
mov rsi, [rbp-216]
mov rax, rbp
sub rax, 8
mov [rbp-224], rax
call printf
mov rax, __temp_str_3
mov [rbp-232], rax
; unary op apply
mov rax, rbp
sub rax, 8
mov [rbp-240], rax
; operand code: [rbp-8]
mov rax, [rbp-8]
sub rax, 8
mov rbx, [rbp-240]
mov [rbx], rax
mov [rbp-248], rax
; unary op finish
mov rax, [rbp-248]
mov [rbp-256], rax
mov rax, [rax]
mov [rbp-264], rax
mov rax, [rbp-264]
mov [rbp-272], rax
mov rdi, [rbp-232]
mov rsi, [rbp-272]
mov rax, rbp
sub rax, 8
mov [rbp-280], rax
call printf
mov rax, 10
mov rbx, 1
mul rbx
mov [rbp-304], rax
mov rax, [rbp-304]
mov [rbp-312], rax
mov rdi, [rbp-312]
mov rax, rbp
sub rax, 8
mov [rbp-320], rax
call malloc
mov [rbp-328], rax
xor rax, rax
mov [rbp-336], rax
mov rax, [rbp-328]
mov [rbp-336], rax
;define variable s
mov rax, [rbp-336]
mov [rbp-288], rax
;end define variable s
mov rax, rbp
sub rax, 288
mov [rbp-344], rax
mov rax, 0
mov rbx, 1
mul rbx
mov rbx, [rbp-288]
add rbx, rax
mov [rbp-352], rbx
mov al, [rbx]
mov [rbp-353], al
mov al, [rbp-353]
mov bl, 49
mov rax, [rbp-352]
mov [rax], bl
mov al, bl
mov [rbp-355], al
mov rax, rbp
sub rax, 288
mov [rbp-363], rax
mov rax, 1
mov rbx, 1
mul rbx
mov rbx, [rbp-288]
add rbx, rax
mov [rbp-371], rbx
mov al, [rbx]
mov [rbp-372], al
mov al, [rbp-372]
mov bl, 104
mov rax, [rbp-371]
mov [rax], bl
mov al, bl
mov [rbp-374], al
mov rax, rbp
sub rax, 288
mov [rbp-382], rax
mov rax, 2
mov rbx, 1
mul rbx
mov rbx, [rbp-288]
add rbx, rax
mov [rbp-390], rbx
mov al, [rbx]
mov [rbp-391], al
mov al, [rbp-391]
mov bl, 101
mov rax, [rbp-390]
mov [rax], bl
mov al, bl
mov [rbp-393], al
mov rax, rbp
sub rax, 288
mov [rbp-401], rax
mov rax, 3
mov rbx, 1
mul rbx
mov rbx, [rbp-288]
add rbx, rax
mov [rbp-409], rbx
mov al, [rbx]
mov [rbp-410], al
mov al, [rbp-410]
mov bl, 108
mov rax, [rbp-409]
mov [rax], bl
mov al, bl
mov [rbp-412], al
mov rax, rbp
sub rax, 288
mov [rbp-420], rax
mov rax, 4
mov rbx, 1
mul rbx
mov rbx, [rbp-288]
add rbx, rax
mov [rbp-428], rbx
mov al, [rbx]
mov [rbp-429], al
mov al, [rbp-429]
mov bl, 108
mov rax, [rbp-428]
mov [rax], bl
mov al, bl
mov [rbp-431], al
mov rax, rbp
sub rax, 288
mov [rbp-439], rax
mov rax, 5
mov rbx, 1
mul rbx
mov rbx, [rbp-288]
add rbx, rax
mov [rbp-447], rbx
mov al, [rbx]
mov [rbp-448], al
mov al, [rbp-448]
mov bl, 111
mov rax, [rbp-447]
mov [rax], bl
mov al, bl
mov [rbp-450], al
mov rax, rbp
sub rax, 288
mov [rbp-458], rax
mov rax, 6
mov rbx, 1
mul rbx
mov rbx, [rbp-288]
add rbx, rax
mov [rbp-466], rbx
mov al, [rbx]
mov [rbp-467], al
mov al, [rbp-467]
mov bl, 10
mov rax, [rbp-466]
mov [rax], bl
mov al, bl
mov [rbp-469], al
mov rax, rbp
sub rax, 288
mov [rbp-477], rax
mov rax, 7
mov rbx, 1
mul rbx
mov rbx, [rbp-288]
add rbx, rax
mov [rbp-485], rbx
mov al, [rbx]
mov [rbp-486], al
mov al, [rbp-486]
mov bl, 0
mov rax, [rbp-485]
mov [rax], bl
mov al, bl
mov [rbp-488], al
mov rax, __temp_str_4
mov [rbp-496], rax
; unary op apply
mov rax, rbp
sub rax, 288
mov [rbp-504], rax
; operand code: [rbp-288]
mov rax, [rbp-288]
add rax, 1
mov rbx, [rbp-504]
mov [rbx], rax
mov [rbp-512], rax
; unary op finish
mov rax, [rbp-512]
mov [rbp-520], rax
mov al, [rax]
mov [rbp-521], al
mov al, [rbp-521]
mov [rbp-522], al
mov rdi, [rbp-496]
mov sil, [rbp-522]
mov rax, rbp
sub rax, 8
mov [rbp-530], rax
call printf
mov rax, __temp_str_5
mov [rbp-538], rax
mov rax, rbp
sub rax, 288
mov [rbp-546], rax
mov rax, [rbp-288]
mov [rbp-554], rax
mov rdi, [rbp-538]
mov rsi, [rbp-554]
mov rax, rbp
sub rax, 8
mov [rbp-562], rax
call printf
mov rax, 10
mov rbx, 8
mul rbx
mov [rbp-586], rax
mov rax, [rbp-586]
mov [rbp-594], rax
mov rdi, [rbp-594]
mov rax, rbp
sub rax, 8
mov [rbp-602], rax
call malloc
mov [rbp-610], rax
xor rax, rax
mov [rbp-618], rax
mov rax, [rbp-610]
mov [rbp-618], rax
;define variable arr
mov rax, [rbp-618]
mov [rbp-570], rax
;end define variable arr
mov rax, rbp
sub rax, 570
mov [rbp-626], rax
mov rax, [rbp-570]
mov [rbp-634], rax
mov rax, [rax]
mov [rbp-642], rax
mov rax, 10
mov rbx, 8
mul rbx
mov [rbp-658], rax
mov rax, [rbp-658]
mov [rbp-666], rax
mov rdi, [rbp-666]
mov rax, rbp
sub rax, 8
mov [rbp-674], rax
call malloc
mov [rbp-682], rax
xor rax, rax
mov [rbp-690], rax
mov rax, [rbp-682]
mov [rbp-690], rax
mov rax, [rbp-642]
mov rbx, [rbp-690]
mov rax, [rbp-634]
mov [rax], rbx
mov rax, rbx
mov [rbp-698], rax
mov rax, rbp
sub rax, 570
mov [rbp-714], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rbp-570]
add rax, rbx
mov [rbp-730], rax
mov rax, [rbp-730]
mov [rbp-738], rax
mov rax, [rax]
mov [rbp-746], rax
mov rax, 10
mov rbx, 8
mul rbx
mov [rbp-762], rax
mov rax, [rbp-762]
mov [rbp-770], rax
mov rdi, [rbp-770]
mov rax, rbp
sub rax, 8
mov [rbp-778], rax
call malloc
mov [rbp-786], rax
xor rax, rax
mov [rbp-794], rax
mov rax, [rbp-786]
mov [rbp-794], rax
mov rax, [rbp-746]
mov rbx, [rbp-794]
mov rax, [rbp-738]
mov [rax], rbx
mov rax, rbx
mov [rbp-802], rax
mov rax, rbp
sub rax, 570
mov [rbp-818], rax
mov rax, 2
mov rbx, 8
mul rbx
mov rbx, [rbp-570]
add rbx, rax
mov [rbp-826], rbx
mov rax, [rbx]
mov [rbp-834], rax
mov rax, 10
mov rbx, 8
mul rbx
mov [rbp-850], rax
mov rax, [rbp-850]
mov [rbp-858], rax
mov rdi, [rbp-858]
mov rax, rbp
sub rax, 8
mov [rbp-866], rax
call malloc
mov [rbp-874], rax
xor rax, rax
mov [rbp-882], rax
mov rax, [rbp-874]
mov [rbp-882], rax
mov rax, [rbp-834]
mov rbx, [rbp-882]
mov rax, [rbp-826]
mov [rax], rbx
mov rax, rbx
mov [rbp-890], rax
mov rax, rbp
sub rax, 570
mov [rbp-906], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rbp-570]
add rbx, rax
mov [rbp-914], rbx
mov rax, [rbx]
mov [rbp-922], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rbp-922]
add rbx, rax
mov [rbp-930], rbx
mov rax, [rbx]
mov [rbp-938], rax
mov rax, [rbp-938]
mov rbx, 69
mov rax, [rbp-930]
mov [rax], rbx
mov rax, rbx
mov [rbp-954], rax
mov rax, rbp
sub rax, 570
mov [rbp-962], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rbp-570]
add rax, rbx
mov [rbp-978], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rbp-978]
add rbx, rax
mov [rbp-986], rbx
mov rax, [rbx]
mov [rbp-994], rax
mov rax, [rbp-994]
mov [rbp-1002], rax
mov rax, [rax]
mov [rbp-1010], rax
mov rax, [rbp-1010]
mov rbx, 99
mov rax, [rbp-1002]
mov [rax], rbx
mov rax, rbx
mov [rbp-1026], rax
mov rax, rbp
sub rax, 570
mov [rbp-1034], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rbp-570]
add rax, rbx
mov [rbp-1050], rax
mov rax, [rbp-1050]
mov [rbp-1058], rax
mov rax, [rax]
mov [rbp-1066], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rbp-1066]
add rax, rbx
mov [rbp-1082], rax
mov rax, [rbp-1082]
mov [rbp-1090], rax
mov rax, [rax]
mov [rbp-1098], rax
mov rax, [rbp-1098]
mov rbx, 109
mov rax, [rbp-1090]
mov [rax], rbx
mov rax, rbx
mov [rbp-1114], rax
mov rax, __temp_str_6
mov [rbp-1122], rax
mov rax, rbp
sub rax, 570
mov [rbp-1130], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rbp-570]
add rbx, rax
mov [rbp-1138], rbx
mov rax, [rbx]
mov [rbp-1146], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rbp-1146]
add rbx, rax
mov [rbp-1154], rbx
mov rax, [rbx]
mov [rbp-1162], rax
mov rax, [rbp-1162]
mov [rbp-1170], rax
mov rdi, [rbp-1122]
mov rsi, [rbp-1170]
mov rax, rbp
sub rax, 8
mov [rbp-1178], rax
call printf
mov rax, __temp_str_7
mov [rbp-1186], rax
mov rax, rbp
sub rax, 570
mov [rbp-1194], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rbp-570]
add rax, rbx
mov [rbp-1210], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rbp-1210]
add rbx, rax
mov [rbp-1218], rbx
mov rax, [rbx]
mov [rbp-1226], rax
mov rax, [rbp-1226]
mov [rbp-1234], rax
mov rax, [rax]
mov [rbp-1242], rax
mov rax, [rbp-1242]
mov [rbp-1250], rax
mov rdi, [rbp-1186]
mov rsi, [rbp-1250]
mov rax, rbp
sub rax, 8
mov [rbp-1258], rax
call printf
mov rax, __temp_str_8
mov [rbp-1266], rax
mov rax, rbp
sub rax, 570
mov [rbp-1274], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, [rbp-570]
add rbx, rax
mov [rbp-1282], rbx
mov rax, [rbx]
mov [rbp-1290], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, [rbp-1290]
add rbx, rax
mov [rbp-1298], rbx
mov rax, [rbx]
mov [rbp-1306], rax
mov rax, [rbp-1306]
mov [rbp-1314], rax
mov rdi, [rbp-1266]
mov rsi, [rbp-1314]
mov rax, rbp
sub rax, 8
mov [rbp-1322], rax
call printf
;define variable b
mov rax, 0
mov [rbp-1330], rax
;end define variable b
mov rax, rbp
sub rax, 1330
mov [rbp-1338], rax
mov rax, [rbp-1330]
mov rbx, 0
cmp rax, rbx
je __tmp_label_8
mov rax, 0
jmp __tmp_label_9
__tmp_label_8:
mov rax, 1
__tmp_label_9:
mov [rbp-1362], rax
mov rax, 0
cmp rax, [rbp-1362]
je __tmp_label_10
mov rax, __temp_str_9
mov [rbp-1370], rax
mov rdi, [rbp-1370]
mov rax, rbp
sub rax, 8
mov [rbp-1378], rax
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
