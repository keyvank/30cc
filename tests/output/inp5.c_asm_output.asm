section .data
__temp_str_0 db `Arg %u: %s\n`, 0
__temp_str_1 db `%u\n`, 0
__temp_str_2 db `%u\n`, 0
__temp_str_3 db `%s`, 0
__main_size: equ 832
section .text
extern printf
extern malloc
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
mov [rbp-8], rdi
mov [rbp-16], rsi
;define variable i
mov rax, 0
mov [rbp-24], rax
;end define variable i
; enter loop
jmp __tmp_label_2
__tmp_label_0:
mov rax, rbp
sub rax, 24
mov [rbp-32], rax
mov rax, [rbp-24]
mov rbx, 1
add rax, rbx
mov rbx, [rbp-32]
mov [rbx], rax
mov [rbp-40], rax
__tmp_label_2:
mov rax, rbp
sub rax, 24
mov [rbp-48], rax
mov rax, rbp
sub rax, 8
mov [rbp-56], rax
mov rax, [rbp-24]
mov rbx, [rbp-8]
cmp rax, rbx
jl __tmp_label_3
mov rax, 0
jmp __tmp_label_4
__tmp_label_3:
mov rax, 1
__tmp_label_4:
mov [rbp-72], rax
mov rax, [rbp-72]
cmp rax, 0
je __tmp_label_1
mov rax, __temp_str_0
mov [rbp-80], rax
mov rax, rbp
sub rax, 24
mov [rbp-88], rax
mov rax, [rbp-24]
mov [rbp-96], rax
mov rax, rbp
sub rax, 16
mov [rbp-104], rax
mov rax, rbp
sub rax, 24
mov [rbp-112], rax
mov rax, [rbp-24]
mov rbx, 8
mul rbx
mov rbx, [rbp-16]
add rbx, rax
mov [rbp-120], rbx
mov rax, [rbx]
mov [rbp-128], rax
mov rax, [rbp-128]
mov [rbp-136], rax
mov rdi, [rbp-80]
mov rsi, [rbp-96]
mov rdx, [rbp-136]
mov rax, rbp
sub rax, 8
mov [rbp-144], rax
call printf
jmp __tmp_label_0
__tmp_label_1:
; exit loop
mov rax, 10
mov rbx, 8
mul rbx
mov [rbp-32], rax
mov rax, [rbp-32]
mov [rbp-40], rax
mov rdi, [rbp-40]
mov rax, rbp
sub rax, 8
mov [rbp-48], rax
call malloc
mov [rbp-56], rax
xor rax, rax
mov [rbp-64], rax
mov rax, [rbp-56]
mov [rbp-64], rax
;define variable a
mov rax, [rbp-64]
mov [rbp-24], rax
;end define variable a
;define variable i
mov rax, 0
mov [rbp-72], rax
;end define variable i
; enter loop
jmp __tmp_label_7
__tmp_label_5:
mov rax, rbp
sub rax, 72
mov [rbp-80], rax
mov rax, rbp
sub rax, 72
mov [rbp-88], rax
mov rax, [rbp-72]
mov rbx, 1
add rax, rbx
mov [rbp-96], rax
mov rax, [rbp-72]
mov rbx, [rbp-96]
mov rax, [rbp-80]
mov [rax], rbx
mov rax, rbx
mov [rbp-104], rax
__tmp_label_7:
mov rax, rbp
sub rax, 72
mov [rbp-112], rax
mov rax, [rbp-72]
mov rbx, 10
cmp rax, rbx
jl __tmp_label_8
mov rax, 0
jmp __tmp_label_9
__tmp_label_8:
mov rax, 1
__tmp_label_9:
mov [rbp-128], rax
mov rax, [rbp-128]
cmp rax, 0
je __tmp_label_6
mov rax, rbp
sub rax, 24
mov [rbp-136], rax
mov rax, rbp
sub rax, 72
mov [rbp-144], rax
mov rax, [rbp-72]
mov rbx, 8
mul rbx
mov rbx, [rbp-24]
add rbx, rax
mov [rbp-152], rbx
mov rax, [rbx]
mov [rbp-160], rax
mov rax, rbp
sub rax, 72
mov [rbp-168], rax
mov rax, 2
mov rbx, [rbp-72]
mul rbx
mov [rbp-176], rax
mov rax, [rbp-160]
mov rbx, [rbp-176]
mov rax, [rbp-152]
mov [rax], rbx
mov rax, rbx
mov [rbp-184], rax
jmp __tmp_label_5
__tmp_label_6:
; exit loop
;define variable i
mov rax, 0
mov [rbp-72], rax
;end define variable i
; enter loop
jmp __tmp_label_12
__tmp_label_10:
mov rax, rbp
sub rax, 72
mov [rbp-80], rax
mov rax, [rbp-72]
mov rbx, 1
add rax, rbx
mov rbx, [rbp-80]
mov [rbx], rax
mov [rbp-88], rax
__tmp_label_12:
mov rax, rbp
sub rax, 72
mov [rbp-96], rax
mov rax, [rbp-72]
mov rbx, 10
cmp rax, rbx
jl __tmp_label_13
mov rax, 0
jmp __tmp_label_14
__tmp_label_13:
mov rax, 1
__tmp_label_14:
mov [rbp-112], rax
mov rax, [rbp-112]
cmp rax, 0
je __tmp_label_11
mov rax, __temp_str_1
mov [rbp-120], rax
mov rax, rbp
sub rax, 24
mov [rbp-128], rax
mov rax, rbp
sub rax, 72
mov [rbp-136], rax
mov rax, [rbp-72]
mov rbx, 8
mul rbx
mov rbx, [rbp-24]
add rbx, rax
mov [rbp-144], rbx
mov rax, [rbx]
mov [rbp-152], rax
mov rax, [rbp-152]
mov [rbp-160], rax
mov rdi, [rbp-120]
mov rsi, [rbp-160]
mov rax, rbp
sub rax, 8
mov [rbp-168], rax
call printf
jmp __tmp_label_10
__tmp_label_11:
; exit loop
mov rax, 1024
mov rbx, 8
mul rbx
mov [rbp-80], rax
mov rax, [rbp-80]
mov [rbp-88], rax
mov rdi, [rbp-88]
mov rax, rbp
sub rax, 8
mov [rbp-96], rax
call malloc
mov [rbp-104], rax
xor rax, rax
mov [rbp-112], rax
mov rax, [rbp-104]
mov [rbp-112], rax
;define variable b
mov rax, [rbp-112]
mov [rbp-72], rax
;end define variable b
;define variable c
mov rax, 123
mov [rbp-120], rax
;end define variable c
mov rax, rbp
sub rax, 72
mov [rbp-128], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rbp-72]
add rbx, rax
mov [rbp-136], rbx
mov rax, [rbx]
mov [rbp-144], rax
mov rax, rbp
sub rax, 120
mov [rbp-152], rax
mov rax, [rbp-152]
mov [rbp-160], rax
mov rax, [rbp-144]
mov rbx, [rbp-160]
mov rax, [rbp-136]
mov [rax], rbx
mov rax, rbx
mov [rbp-168], rax
mov rax, rbp
sub rax, 72
mov [rbp-176], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rbp-72]
add rbx, rax
mov [rbp-184], rbx
mov rax, [rbx]
mov [rbp-192], rax
mov rax, [rbp-192]
mov [rbp-200], rax
mov rax, [rax]
mov [rbp-208], rax
mov rax, rbp
sub rax, 72
mov [rbp-216], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rbp-72]
add rbx, rax
mov [rbp-224], rbx
mov rax, [rbx]
mov [rbp-232], rax
mov rax, [rbp-232]
mov [rbp-240], rax
mov rax, [rax]
mov [rbp-248], rax
mov rax, [rbp-248]
mov rbx, 2
mul rbx
mov [rbp-256], rax
mov rax, [rbp-208]
mov rbx, [rbp-256]
mov rax, [rbp-200]
mov [rax], rbx
mov rax, rbx
mov [rbp-264], rax
mov rax, __temp_str_2
mov [rbp-272], rax
mov rax, rbp
sub rax, 120
mov [rbp-280], rax
mov rax, [rbp-120]
mov [rbp-288], rax
mov rdi, [rbp-272]
mov rsi, [rbp-288]
mov rax, rbp
sub rax, 8
mov [rbp-296], rax
call printf
mov rax, 20
mov rbx, 1
mul rbx
mov [rbp-312], rax
mov rax, [rbp-312]
mov [rbp-320], rax
mov rdi, [rbp-320]
mov rax, rbp
sub rax, 8
mov [rbp-328], rax
call malloc
mov [rbp-336], rax
xor rax, rax
mov [rbp-344], rax
mov rax, [rbp-336]
mov [rbp-344], rax
;define variable str
mov rax, [rbp-344]
mov [rbp-304], rax
;end define variable str
mov rax, rbp
sub rax, 304
mov [rbp-352], rax
mov rax, 0
mov rbx, 1
mul rbx
mov rbx, [rbp-304]
add rbx, rax
mov [rbp-360], rbx
mov al, [rbx]
mov [rbp-361], al
mov al, [rbp-361]
mov bl, 104
mov rax, [rbp-360]
mov [rax], bl
mov al, bl
mov [rbp-362], al
mov rax, rbp
sub rax, 304
mov [rbp-370], rax
mov rax, 1
mov rbx, 1
mul rbx
mov rbx, [rbp-304]
add rbx, rax
mov [rbp-378], rbx
mov al, [rbx]
mov [rbp-379], al
mov al, [rbp-379]
mov bl, 105
mov rax, [rbp-378]
mov [rax], bl
mov al, bl
mov [rbp-380], al
mov rax, rbp
sub rax, 304
mov [rbp-388], rax
mov rax, 2
mov rbx, 1
mul rbx
mov rbx, [rbp-304]
add rbx, rax
mov [rbp-396], rbx
mov al, [rbx]
mov [rbp-397], al
mov al, [rbp-397]
mov bl, 33
mov rax, [rbp-396]
mov [rax], bl
mov al, bl
mov [rbp-398], al
mov rax, rbp
sub rax, 304
mov [rbp-406], rax
mov rax, 3
mov rbx, 1
mul rbx
mov rbx, [rbp-304]
add rbx, rax
mov [rbp-414], rbx
mov al, [rbx]
mov [rbp-415], al
mov al, [rbp-415]
mov bl, 10
mov rax, [rbp-414]
mov [rax], bl
mov al, bl
mov [rbp-416], al
mov rax, rbp
sub rax, 304
mov [rbp-424], rax
mov rax, 4
mov rbx, 1
mul rbx
mov rbx, [rbp-304]
add rbx, rax
mov [rbp-432], rbx
mov al, [rbx]
mov [rbp-433], al
mov al, [rbp-433]
mov bl, 0
mov rax, [rbp-432]
mov [rax], bl
mov al, bl
mov [rbp-434], al
mov rax, __temp_str_3
mov [rbp-442], rax
mov rax, rbp
sub rax, 304
mov [rbp-450], rax
mov rax, [rbp-304]
mov [rbp-458], rax
mov rdi, [rbp-442]
mov rsi, [rbp-458]
mov rax, rbp
sub rax, 8
mov [rbp-466], rax
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
