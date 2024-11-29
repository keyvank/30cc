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
mov [rbp-16], rax
mov rax, [rbp-16]
mov [rbp-24], rax
mov rdi, [rbp-24]
mov rax, rbp
sub rax, 8
mov [rbp-32], rax
call malloc
mov [rbp-40], rax
xor rax, rax
mov [rbp-48], rax
mov rax, [rbp-40]
mov [rbp-48], rax
;define variable a
mov rax, [rbp-48]
mov [rbp-8], rax
;end define variable a
;define variable i
mov rax, 0
mov [rbp-56], rax
;end define variable i
; enter loop
__tmp_label_0:
mov rax, rbp
sub rax, 56
mov [rbp-64], rax
mov rax, [rbp-56]
mov rbx, 10
cmp rax, rbx
jl __tmp_label_2
mov rax, 0
jmp __tmp_label_3
__tmp_label_2:
mov rax, 1
__tmp_label_3:
mov [rbp-80], rax
mov rax, [rbp-80]
cmp rax, 0
je __tmp_label_1
mov rax, rbp
sub rax, 8
mov [rbp-88], rax
mov rax, rbp
sub rax, 56
mov [rbp-96], rax
mov rax, [rbp-56]
mov rbx, 8
mul rbx
mov rbx, [rbp-8]
add rbx, rax
mov [rbp-104], rbx
mov rax, [rbx]
mov [rbp-112], rax
mov rax, rbp
sub rax, 56
mov [rbp-120], rax
mov rax, 2
mov rbx, [rbp-56]
mul rbx
mov [rbp-128], rax
mov rax, [rbp-112]
mov rbx, [rbp-128]
mov rax, [rbp-104]
mov [rax], rbx
mov rax, rbx
mov [rbp-136], rax
mov rax, rbp
sub rax, 56
mov [rbp-144], rax
mov rax, rbp
sub rax, 56
mov [rbp-152], rax
mov rax, [rbp-56]
mov rbx, 1
add rax, rbx
mov [rbp-160], rax
mov rax, [rbp-56]
mov rbx, [rbp-160]
mov rax, [rbp-144]
mov [rax], rbx
mov rax, rbx
mov [rbp-168], rax
jmp __tmp_label_0
__tmp_label_1:
; exit loop
mov rax, __temp_str_0
mov [rbp-56], rax
mov rax, rbp
sub rax, 8
mov [rbp-64], rax
mov rax, 4
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rbp-8]
add rax, rbx
mov [rbp-72], rax
mov rax, [rbp-72]
mov [rbp-80], rax
mov rax, [rax]
mov [rbp-88], rax
mov rax, [rbp-88]
mov [rbp-96], rax
mov rdi, [rbp-56]
mov rsi, [rbp-96]
mov rax, rbp
sub rax, 8
mov [rbp-104], rax
call printf
;define variable i
mov rax, 0
mov [rbp-112], rax
;end define variable i
; enter loop
__tmp_label_4:
; postfix op apply
mov rax, rbp
sub rax, 112
mov [rbp-120], rax
mov rax, [rbp-112]
mov [rbp-128], rax
add rax, 1
mov rbx, [rbp-120]
mov [rbx], rax
; postfix op finish
mov rax, [rbp-128]
mov rbx, 10
cmp rax, rbx
jl __tmp_label_6
mov rax, 0
jmp __tmp_label_7
__tmp_label_6:
mov rax, 1
__tmp_label_7:
mov [rbp-144], rax
mov rax, [rbp-144]
cmp rax, 0
je __tmp_label_5
mov rax, __temp_str_1
mov [rbp-152], rax
; postfix op apply
mov rax, rbp
sub rax, 8
mov [rbp-160], rax
mov rax, [rbp-8]
mov [rbp-168], rax
add rax, 8
mov rbx, [rbp-160]
mov [rbx], rax
; postfix op finish
mov rax, [rbp-168]
mov [rbp-176], rax
mov rax, [rax]
mov [rbp-184], rax
mov rax, [rbp-184]
mov [rbp-192], rax
mov rdi, [rbp-152]
mov rsi, [rbp-192]
mov rax, rbp
sub rax, 8
mov [rbp-200], rax
call printf
jmp __tmp_label_4
__tmp_label_5:
; exit loop
mov rax, __temp_str_2
mov [rbp-152], rax
; unary op apply
mov rax, rbp
sub rax, 8
mov [rbp-160], rax
; operand code: [rbp-8]
mov rax, [rbp-8]
sub rax, 8
mov rbx, [rbp-160]
mov [rbx], rax
mov [rbp-168], rax
; unary op finish
mov rax, [rbp-168]
mov [rbp-176], rax
mov rax, [rax]
mov [rbp-184], rax
mov rax, [rbp-184]
mov [rbp-192], rax
mov rdi, [rbp-152]
mov rsi, [rbp-192]
mov rax, rbp
sub rax, 8
mov [rbp-200], rax
call printf
mov rax, __temp_str_3
mov [rbp-208], rax
; unary op apply
mov rax, rbp
sub rax, 8
mov [rbp-216], rax
; operand code: [rbp-8]
mov rax, [rbp-8]
sub rax, 8
mov rbx, [rbp-216]
mov [rbx], rax
mov [rbp-224], rax
; unary op finish
mov rax, [rbp-224]
mov [rbp-232], rax
mov rax, [rax]
mov [rbp-240], rax
mov rax, [rbp-240]
mov [rbp-248], rax
mov rdi, [rbp-208]
mov rsi, [rbp-248]
mov rax, rbp
sub rax, 8
mov [rbp-256], rax
call printf
mov rax, 10
mov rbx, 1
mul rbx
mov [rbp-272], rax
mov rax, [rbp-272]
mov [rbp-280], rax
mov rdi, [rbp-280]
mov rax, rbp
sub rax, 8
mov [rbp-288], rax
call malloc
mov [rbp-296], rax
xor rax, rax
mov [rbp-304], rax
mov rax, [rbp-296]
mov [rbp-304], rax
;define variable s
mov rax, [rbp-304]
mov [rbp-264], rax
;end define variable s
mov rax, rbp
sub rax, 264
mov [rbp-312], rax
mov rax, 0
mov rbx, 1
mul rbx
mov rbx, [rbp-264]
add rbx, rax
mov [rbp-320], rbx
mov al, [rbx]
mov [rbp-321], al
mov al, [rbp-321]
mov bl, 49
mov rax, [rbp-320]
mov [rax], bl
mov al, bl
mov [rbp-322], al
mov rax, rbp
sub rax, 264
mov [rbp-330], rax
mov rax, 1
mov rbx, 1
mul rbx
mov rbx, [rbp-264]
add rbx, rax
mov [rbp-338], rbx
mov al, [rbx]
mov [rbp-339], al
mov al, [rbp-339]
mov bl, 104
mov rax, [rbp-338]
mov [rax], bl
mov al, bl
mov [rbp-340], al
mov rax, rbp
sub rax, 264
mov [rbp-348], rax
mov rax, 2
mov rbx, 1
mul rbx
mov rbx, [rbp-264]
add rbx, rax
mov [rbp-356], rbx
mov al, [rbx]
mov [rbp-357], al
mov al, [rbp-357]
mov bl, 101
mov rax, [rbp-356]
mov [rax], bl
mov al, bl
mov [rbp-358], al
mov rax, rbp
sub rax, 264
mov [rbp-366], rax
mov rax, 3
mov rbx, 1
mul rbx
mov rbx, [rbp-264]
add rbx, rax
mov [rbp-374], rbx
mov al, [rbx]
mov [rbp-375], al
mov al, [rbp-375]
mov bl, 108
mov rax, [rbp-374]
mov [rax], bl
mov al, bl
mov [rbp-376], al
mov rax, rbp
sub rax, 264
mov [rbp-384], rax
mov rax, 4
mov rbx, 1
mul rbx
mov rbx, [rbp-264]
add rbx, rax
mov [rbp-392], rbx
mov al, [rbx]
mov [rbp-393], al
mov al, [rbp-393]
mov bl, 108
mov rax, [rbp-392]
mov [rax], bl
mov al, bl
mov [rbp-394], al
mov rax, rbp
sub rax, 264
mov [rbp-402], rax
mov rax, 5
mov rbx, 1
mul rbx
mov rbx, [rbp-264]
add rbx, rax
mov [rbp-410], rbx
mov al, [rbx]
mov [rbp-411], al
mov al, [rbp-411]
mov bl, 111
mov rax, [rbp-410]
mov [rax], bl
mov al, bl
mov [rbp-412], al
mov rax, rbp
sub rax, 264
mov [rbp-420], rax
mov rax, 6
mov rbx, 1
mul rbx
mov rbx, [rbp-264]
add rbx, rax
mov [rbp-428], rbx
mov al, [rbx]
mov [rbp-429], al
mov al, [rbp-429]
mov bl, 10
mov rax, [rbp-428]
mov [rax], bl
mov al, bl
mov [rbp-430], al
mov rax, rbp
sub rax, 264
mov [rbp-438], rax
mov rax, 7
mov rbx, 1
mul rbx
mov rbx, [rbp-264]
add rbx, rax
mov [rbp-446], rbx
mov al, [rbx]
mov [rbp-447], al
mov al, [rbp-447]
mov bl, 0
mov rax, [rbp-446]
mov [rax], bl
mov al, bl
mov [rbp-448], al
mov rax, __temp_str_4
mov [rbp-456], rax
; unary op apply
mov rax, rbp
sub rax, 264
mov [rbp-464], rax
; operand code: [rbp-264]
mov rax, [rbp-264]
add rax, 1
mov rbx, [rbp-464]
mov [rbx], rax
mov [rbp-472], rax
; unary op finish
mov rax, [rbp-472]
mov [rbp-480], rax
mov al, [rax]
mov [rbp-481], al
mov al, [rbp-481]
mov [rbp-482], al
mov rdi, [rbp-456]
mov sil, [rbp-482]
mov rax, rbp
sub rax, 8
mov [rbp-490], rax
call printf
mov rax, __temp_str_5
mov [rbp-498], rax
mov rax, rbp
sub rax, 264
mov [rbp-506], rax
mov rax, [rbp-264]
mov [rbp-514], rax
mov rdi, [rbp-498]
mov rsi, [rbp-514]
mov rax, rbp
sub rax, 8
mov [rbp-522], rax
call printf
mov rax, 10
mov rbx, 8
mul rbx
mov [rbp-538], rax
mov rax, [rbp-538]
mov [rbp-546], rax
mov rdi, [rbp-546]
mov rax, rbp
sub rax, 8
mov [rbp-554], rax
call malloc
mov [rbp-562], rax
xor rax, rax
mov [rbp-570], rax
mov rax, [rbp-562]
mov [rbp-570], rax
;define variable arr
mov rax, [rbp-570]
mov [rbp-530], rax
;end define variable arr
mov rax, rbp
sub rax, 530
mov [rbp-578], rax
mov rax, [rbp-530]
mov [rbp-586], rax
mov rax, [rax]
mov [rbp-594], rax
mov rax, 10
mov rbx, 8
mul rbx
mov [rbp-602], rax
mov rax, [rbp-602]
mov [rbp-610], rax
mov rdi, [rbp-610]
mov rax, rbp
sub rax, 8
mov [rbp-618], rax
call malloc
mov [rbp-626], rax
xor rax, rax
mov [rbp-634], rax
mov rax, [rbp-626]
mov [rbp-634], rax
mov rax, [rbp-594]
mov rbx, [rbp-634]
mov rax, [rbp-586]
mov [rax], rbx
mov rax, rbx
mov [rbp-642], rax
mov rax, rbp
sub rax, 530
mov [rbp-650], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rbp-530]
add rax, rbx
mov [rbp-658], rax
mov rax, [rbp-658]
mov [rbp-666], rax
mov rax, [rax]
mov [rbp-674], rax
mov rax, 10
mov rbx, 8
mul rbx
mov [rbp-682], rax
mov rax, [rbp-682]
mov [rbp-690], rax
mov rdi, [rbp-690]
mov rax, rbp
sub rax, 8
mov [rbp-698], rax
call malloc
mov [rbp-706], rax
xor rax, rax
mov [rbp-714], rax
mov rax, [rbp-706]
mov [rbp-714], rax
mov rax, [rbp-674]
mov rbx, [rbp-714]
mov rax, [rbp-666]
mov [rax], rbx
mov rax, rbx
mov [rbp-722], rax
mov rax, rbp
sub rax, 530
mov [rbp-730], rax
mov rax, 2
mov rbx, 8
mul rbx
mov rbx, [rbp-530]
add rbx, rax
mov [rbp-738], rbx
mov rax, [rbx]
mov [rbp-746], rax
mov rax, 10
mov rbx, 8
mul rbx
mov [rbp-754], rax
mov rax, [rbp-754]
mov [rbp-762], rax
mov rdi, [rbp-762]
mov rax, rbp
sub rax, 8
mov [rbp-770], rax
call malloc
mov [rbp-778], rax
xor rax, rax
mov [rbp-786], rax
mov rax, [rbp-778]
mov [rbp-786], rax
mov rax, [rbp-746]
mov rbx, [rbp-786]
mov rax, [rbp-738]
mov [rax], rbx
mov rax, rbx
mov [rbp-794], rax
mov rax, rbp
sub rax, 530
mov [rbp-802], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rbp-530]
add rbx, rax
mov [rbp-810], rbx
mov rax, [rbx]
mov [rbp-818], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rbp-818]
add rbx, rax
mov [rbp-826], rbx
mov rax, [rbx]
mov [rbp-834], rax
mov rax, [rbp-834]
mov rbx, 69
mov rax, [rbp-826]
mov [rax], rbx
mov rax, rbx
mov [rbp-842], rax
mov rax, rbp
sub rax, 530
mov [rbp-850], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rbp-530]
add rax, rbx
mov [rbp-858], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rbp-858]
add rbx, rax
mov [rbp-866], rbx
mov rax, [rbx]
mov [rbp-874], rax
mov rax, [rbp-874]
mov [rbp-882], rax
mov rax, [rax]
mov [rbp-890], rax
mov rax, [rbp-890]
mov rbx, 99
mov rax, [rbp-882]
mov [rax], rbx
mov rax, rbx
mov [rbp-898], rax
mov rax, rbp
sub rax, 530
mov [rbp-906], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rbp-530]
add rax, rbx
mov [rbp-914], rax
mov rax, [rbp-914]
mov [rbp-922], rax
mov rax, [rax]
mov [rbp-930], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rbp-930]
add rax, rbx
mov [rbp-938], rax
mov rax, [rbp-938]
mov [rbp-946], rax
mov rax, [rax]
mov [rbp-954], rax
mov rax, [rbp-954]
mov rbx, 109
mov rax, [rbp-946]
mov [rax], rbx
mov rax, rbx
mov [rbp-962], rax
mov rax, __temp_str_6
mov [rbp-970], rax
mov rax, rbp
sub rax, 530
mov [rbp-978], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rbp-530]
add rbx, rax
mov [rbp-986], rbx
mov rax, [rbx]
mov [rbp-994], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rbp-994]
add rbx, rax
mov [rbp-1002], rbx
mov rax, [rbx]
mov [rbp-1010], rax
mov rax, [rbp-1010]
mov [rbp-1018], rax
mov rdi, [rbp-970]
mov rsi, [rbp-1018]
mov rax, rbp
sub rax, 8
mov [rbp-1026], rax
call printf
mov rax, __temp_str_7
mov [rbp-1034], rax
mov rax, rbp
sub rax, 530
mov [rbp-1042], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, rax
mov rax, [rbp-530]
add rax, rbx
mov [rbp-1050], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rbp-1050]
add rbx, rax
mov [rbp-1058], rbx
mov rax, [rbx]
mov [rbp-1066], rax
mov rax, [rbp-1066]
mov [rbp-1074], rax
mov rax, [rax]
mov [rbp-1082], rax
mov rax, [rbp-1082]
mov [rbp-1090], rax
mov rdi, [rbp-1034]
mov rsi, [rbp-1090]
mov rax, rbp
sub rax, 8
mov [rbp-1098], rax
call printf
mov rax, __temp_str_8
mov [rbp-1106], rax
mov rax, rbp
sub rax, 530
mov [rbp-1114], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, [rbp-530]
add rbx, rax
mov [rbp-1122], rbx
mov rax, [rbx]
mov [rbp-1130], rax
mov rax, 1
mov rbx, 8
mul rbx
mov rbx, [rbp-1130]
add rbx, rax
mov [rbp-1138], rbx
mov rax, [rbx]
mov [rbp-1146], rax
mov rax, [rbp-1146]
mov [rbp-1154], rax
mov rdi, [rbp-1106]
mov rsi, [rbp-1154]
mov rax, rbp
sub rax, 8
mov [rbp-1162], rax
call printf
;define variable b
mov rax, 0
mov [rbp-1170], rax
;end define variable b
mov rax, rbp
sub rax, 1170
mov [rbp-1178], rax
mov rax, [rbp-1170]
mov rbx, 0
cmp rax, rbx
je __tmp_label_8
mov rax, 0
jmp __tmp_label_9
__tmp_label_8:
mov rax, 1
__tmp_label_9:
mov [rbp-1194], rax
mov rax, 0
cmp rax, [rbp-1194]
je __tmp_label_10
mov rax, __temp_str_9
mov [rbp-1202], rax
mov rdi, [rbp-1202]
mov rax, rbp
sub rax, 8
mov [rbp-1210], rax
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
