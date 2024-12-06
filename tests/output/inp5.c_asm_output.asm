section .data
__temp_str_0 db `Arg %u: %s\n`, 0
__temp_str_1 db `%u\n`, 0
__temp_str_2 db `%u\n`, 0
__temp_str_3 db `%s`, 0
__main_size: equ 944
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
__tmp_label_0:
mov rax, rbp
sub rax, 24
mov [rbp-32], rax
mov rax, rbp
sub rax, 8
mov [rbp-40], rax
mov rax, [rbp-24]
mov rbx, [rbp-8]
cmp rax, rbx
jl __tmp_label_2
mov rax, 0
jmp __tmp_label_3
__tmp_label_2:
mov rax, 1
__tmp_label_3:
mov [rbp-64], rax
mov rax, [rbp-64]
cmp rax, 0
je __tmp_label_1
mov rax, __temp_str_0
mov [rbp-72], rax
mov rax, rbp
sub rax, 24
mov [rbp-80], rax
mov rax, [rbp-24]
mov [rbp-88], rax
mov rax, rbp
sub rax, 16
mov [rbp-96], rax
mov rax, rbp
sub rax, 24
mov [rbp-104], rax
mov rax, [rbp-24]
mov rbx, 8
mul rbx
mov rbx, [rbp-16]
add rbx, rax
mov [rbp-112], rbx
mov rax, [rbx]
mov [rbp-120], rax
mov rax, [rbp-120]
mov [rbp-128], rax
mov rdi, [rbp-72]
mov rsi, [rbp-88]
mov rdx, [rbp-128]
mov rax, rbp
sub rax, 8
mov [rbp-136], rax
call printf
mov rax, rbp
sub rax, 24
mov [rbp-72], rax
mov rax, [rbp-24]
mov rbx, 1
add rax, rbx
mov rbx, [rbp-72]
mov [rbx], rax
mov [rbp-88], rax
jmp __tmp_label_0
__tmp_label_1:
; exit loop
mov rax, 10
mov rbx, 8
mul rbx
mov [rbp-40], rax
mov rax, [rbp-40]
mov [rbp-48], rax
mov rdi, [rbp-48]
mov rax, rbp
sub rax, 8
mov [rbp-56], rax
call malloc
mov [rbp-64], rax
xor rax, rax
mov [rbp-72], rax
mov rax, [rbp-64]
mov [rbp-72], rax
;define variable a
mov rax, [rbp-72]
mov [rbp-24], rax
;end define variable a
;define variable i
mov rax, 0
mov [rbp-80], rax
;end define variable i
; enter loop
__tmp_label_4:
mov rax, rbp
sub rax, 80
mov [rbp-88], rax
mov rax, [rbp-80]
mov rbx, 10
cmp rax, rbx
jl __tmp_label_6
mov rax, 0
jmp __tmp_label_7
__tmp_label_6:
mov rax, 1
__tmp_label_7:
mov [rbp-112], rax
mov rax, [rbp-112]
cmp rax, 0
je __tmp_label_5
mov rax, rbp
sub rax, 24
mov [rbp-120], rax
mov rax, rbp
sub rax, 80
mov [rbp-128], rax
mov rax, [rbp-80]
mov rbx, 8
mul rbx
mov rbx, [rbp-24]
add rbx, rax
mov [rbp-136], rbx
mov rax, [rbx]
mov [rbp-144], rax
mov rax, rbp
sub rax, 80
mov [rbp-152], rax
mov rax, 2
mov rbx, [rbp-80]
mul rbx
mov [rbp-168], rax
mov rax, [rbp-144]
mov rbx, [rbp-168]
mov rax, [rbp-136]
mov [rax], rbx
mov rax, rbx
mov [rbp-184], rax
mov rax, rbp
sub rax, 80
mov [rbp-192], rax
mov rax, rbp
sub rax, 80
mov [rbp-200], rax
mov rax, [rbp-80]
mov rbx, 1
add rax, rbx
mov [rbp-216], rax
mov rax, [rbp-80]
mov rbx, [rbp-216]
mov rax, [rbp-192]
mov [rax], rbx
mov rax, rbx
mov [rbp-232], rax
jmp __tmp_label_4
__tmp_label_5:
; exit loop
;define variable i
mov rax, 0
mov [rbp-80], rax
;end define variable i
; enter loop
__tmp_label_8:
mov rax, rbp
sub rax, 80
mov [rbp-88], rax
mov rax, [rbp-80]
mov rbx, 10
cmp rax, rbx
jl __tmp_label_10
mov rax, 0
jmp __tmp_label_11
__tmp_label_10:
mov rax, 1
__tmp_label_11:
mov [rbp-112], rax
mov rax, [rbp-112]
cmp rax, 0
je __tmp_label_9
mov rax, __temp_str_1
mov [rbp-120], rax
mov rax, rbp
sub rax, 24
mov [rbp-128], rax
mov rax, rbp
sub rax, 80
mov [rbp-136], rax
mov rax, [rbp-80]
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
mov rax, rbp
sub rax, 80
mov [rbp-176], rax
mov rax, [rbp-80]
mov rbx, 1
add rax, rbx
mov rbx, [rbp-176]
mov [rbx], rax
mov [rbp-192], rax
jmp __tmp_label_8
__tmp_label_9:
; exit loop
mov rax, 1024
mov rbx, 8
mul rbx
mov [rbp-96], rax
mov rax, [rbp-96]
mov [rbp-104], rax
mov rdi, [rbp-104]
mov rax, rbp
sub rax, 8
mov [rbp-112], rax
call malloc
mov [rbp-120], rax
xor rax, rax
mov [rbp-128], rax
mov rax, [rbp-120]
mov [rbp-128], rax
;define variable b
mov rax, [rbp-128]
mov [rbp-80], rax
;end define variable b
;define variable c
mov rax, 123
mov [rbp-136], rax
;end define variable c
mov rax, rbp
sub rax, 80
mov [rbp-144], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rbp-80]
add rbx, rax
mov [rbp-152], rbx
mov rax, [rbx]
mov [rbp-160], rax
mov rax, rbp
sub rax, 136
mov [rbp-168], rax
mov rax, [rbp-168]
mov [rbp-176], rax
mov rax, [rbp-160]
mov rbx, [rbp-176]
mov rax, [rbp-152]
mov [rax], rbx
mov rax, rbx
mov [rbp-184], rax
mov rax, rbp
sub rax, 80
mov [rbp-200], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rbp-80]
add rbx, rax
mov [rbp-208], rbx
mov rax, [rbx]
mov [rbp-216], rax
mov rax, [rbp-216]
mov [rbp-224], rax
mov rax, [rax]
mov [rbp-232], rax
mov rax, rbp
sub rax, 80
mov [rbp-240], rax
mov rax, 0
mov rbx, 8
mul rbx
mov rbx, [rbp-80]
add rbx, rax
mov [rbp-248], rbx
mov rax, [rbx]
mov [rbp-256], rax
mov rax, [rbp-256]
mov [rbp-264], rax
mov rax, [rax]
mov [rbp-272], rax
mov rax, [rbp-272]
mov rbx, 2
mul rbx
mov [rbp-288], rax
mov rax, [rbp-232]
mov rbx, [rbp-288]
mov rax, [rbp-224]
mov [rax], rbx
mov rax, rbx
mov [rbp-304], rax
mov rax, __temp_str_2
mov [rbp-312], rax
mov rax, rbp
sub rax, 136
mov [rbp-320], rax
mov rax, [rbp-136]
mov [rbp-328], rax
mov rdi, [rbp-312]
mov rsi, [rbp-328]
mov rax, rbp
sub rax, 8
mov [rbp-336], rax
call printf
mov rax, 20
mov rbx, 1
mul rbx
mov [rbp-360], rax
mov rax, [rbp-360]
mov [rbp-368], rax
mov rdi, [rbp-368]
mov rax, rbp
sub rax, 8
mov [rbp-376], rax
call malloc
mov [rbp-384], rax
xor rax, rax
mov [rbp-392], rax
mov rax, [rbp-384]
mov [rbp-392], rax
;define variable str
mov rax, [rbp-392]
mov [rbp-344], rax
;end define variable str
mov rax, rbp
sub rax, 344
mov [rbp-400], rax
mov rax, 0
mov rbx, 1
mul rbx
mov rbx, [rbp-344]
add rbx, rax
mov [rbp-408], rbx
mov al, [rbx]
mov [rbp-409], al
mov al, [rbp-409]
mov bl, 104
mov rax, [rbp-408]
mov [rax], bl
mov al, bl
mov [rbp-411], al
mov rax, rbp
sub rax, 344
mov [rbp-419], rax
mov rax, 1
mov rbx, 1
mul rbx
mov rbx, [rbp-344]
add rbx, rax
mov [rbp-427], rbx
mov al, [rbx]
mov [rbp-428], al
mov al, [rbp-428]
mov bl, 105
mov rax, [rbp-427]
mov [rax], bl
mov al, bl
mov [rbp-430], al
mov rax, rbp
sub rax, 344
mov [rbp-438], rax
mov rax, 2
mov rbx, 1
mul rbx
mov rbx, [rbp-344]
add rbx, rax
mov [rbp-446], rbx
mov al, [rbx]
mov [rbp-447], al
mov al, [rbp-447]
mov bl, 33
mov rax, [rbp-446]
mov [rax], bl
mov al, bl
mov [rbp-449], al
mov rax, rbp
sub rax, 344
mov [rbp-457], rax
mov rax, 3
mov rbx, 1
mul rbx
mov rbx, [rbp-344]
add rbx, rax
mov [rbp-465], rbx
mov al, [rbx]
mov [rbp-466], al
mov al, [rbp-466]
mov bl, 10
mov rax, [rbp-465]
mov [rax], bl
mov al, bl
mov [rbp-468], al
mov rax, rbp
sub rax, 344
mov [rbp-476], rax
mov rax, 4
mov rbx, 1
mul rbx
mov rbx, [rbp-344]
add rbx, rax
mov [rbp-484], rbx
mov al, [rbx]
mov [rbp-485], al
mov al, [rbp-485]
mov bl, 0
mov rax, [rbp-484]
mov [rax], bl
mov al, bl
mov [rbp-487], al
mov rax, __temp_str_3
mov [rbp-495], rax
mov rax, rbp
sub rax, 344
mov [rbp-503], rax
mov rax, [rbp-344]
mov [rbp-511], rax
mov rdi, [rbp-495]
mov rsi, [rbp-511]
mov rax, rbp
sub rax, 8
mov [rbp-519], rax
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
