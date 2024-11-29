section .data
__temp_str_0 db `%u %u %u %u %u\n`, 0
__temp_str_1 db `%u\n`, 0
__main_size: equ 736
section .text
extern printf
extern malloc
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
mov rax, rbp
sub rax, 40
mov [rbp-48], rax
mov rax, [rbp-48]
add rax, 0
mov [rbp-56], rax
mov rax, [rax]
mov [rbp-64], rax
mov rax, [rbp-64]
mov rbx, 5
mov rax, [rbp-56]
mov [rax], rbx
mov rax, rbx
mov [rbp-72], rax
mov rax, rbp
sub rax, 40
mov [rbp-80], rax
mov rax, [rbp-80]
add rax, 8
mov [rbp-88], rax
mov rax, [rax]
mov [rbp-96], rax
mov rax, [rbp-96]
mov rbx, 10
mov rax, [rbp-88]
mov [rax], rbx
mov rax, rbx
mov [rbp-104], rax
mov rax, rbp
sub rax, 40
mov [rbp-112], rax
mov rax, [rbp-112]
add rax, 16
mov [rbp-120], rax
mov rax, [rbp-120]
add rax, 0
mov [rbp-144], rax
mov rax, [rax]
mov [rbp-152], rax
mov rax, [rbp-152]
mov rbx, 19
mov rax, [rbp-144]
mov [rax], rbx
mov rax, rbx
mov [rbp-160], rax
mov rax, rbp
sub rax, 40
mov [rbp-168], rax
mov rax, [rbp-168]
add rax, 16
mov [rbp-176], rax
mov rax, [rbp-176]
add rax, 8
mov [rbp-200], rax
mov rax, [rax]
mov [rbp-208], rax
mov rax, [rbp-208]
mov rbx, 123
mov rax, [rbp-200]
mov [rax], rbx
mov rax, rbx
mov [rbp-216], rax
mov rax, rbp
sub rax, 40
mov [rbp-224], rax
mov rax, [rbp-224]
add rax, 32
mov [rbp-232], rax
mov rax, [rax]
mov [rbp-240], rax
mov rax, rbp
sub rax, 40
mov [rbp-248], rax
mov rax, [rbp-248]
add rax, 16
mov [rbp-256], rax
mov rax, [rbp-256]
add rax, 8
mov [rbp-280], rax
mov rax, [rax]
mov [rbp-288], rax
mov rax, [rbp-288]
mov rbx, 2
mul rbx
mov [rbp-296], rax
mov rax, rbp
sub rax, 40
mov [rbp-304], rax
mov rax, [rbp-304]
add rax, 0
mov [rbp-312], rax
mov rax, [rax]
mov [rbp-320], rax
mov rax, [rbp-296]
mov rbx, [rbp-320]
add rax, rbx
mov [rbp-328], rax
mov rax, [rbp-240]
mov rbx, [rbp-328]
mov rax, [rbp-232]
mov [rax], rbx
mov rax, rbx
mov [rbp-336], rax
mov rax, __temp_str_0
mov [rbp-344], rax
mov rax, rbp
sub rax, 40
mov [rbp-352], rax
mov rax, [rbp-352]
add rax, 0
mov [rbp-360], rax
mov rax, [rax]
mov [rbp-368], rax
mov rax, [rbp-368]
mov [rbp-376], rax
mov rax, rbp
sub rax, 40
mov [rbp-384], rax
mov rax, [rbp-384]
add rax, 8
mov [rbp-392], rax
mov rax, [rax]
mov [rbp-400], rax
mov rax, [rbp-400]
mov [rbp-408], rax
mov rax, rbp
sub rax, 40
mov [rbp-416], rax
mov rax, [rbp-416]
add rax, 16
mov [rbp-424], rax
mov rax, [rbp-424]
add rax, 0
mov [rbp-448], rax
mov rax, [rax]
mov [rbp-456], rax
mov rax, [rbp-456]
mov [rbp-464], rax
mov rax, rbp
sub rax, 40
mov [rbp-472], rax
mov rax, [rbp-472]
add rax, 16
mov [rbp-480], rax
mov rax, [rbp-480]
add rax, 8
mov [rbp-504], rax
mov rax, [rax]
mov [rbp-512], rax
mov rax, [rbp-512]
mov [rbp-520], rax
mov rax, rbp
sub rax, 40
mov [rbp-528], rax
mov rax, [rbp-528]
add rax, 32
mov [rbp-536], rax
mov rax, [rax]
mov [rbp-544], rax
mov rax, [rbp-544]
mov [rbp-552], rax
mov rdi, [rbp-344]
mov rsi, [rbp-376]
mov rdx, [rbp-408]
mov rcx, [rbp-464]
mov r8, [rbp-520]
mov r9, [rbp-552]
mov rax, rbp
sub rax, 8
mov [rbp-560], rax
call printf
mov rax, 10
mov rbx, 8
mul rbx
mov [rbp-576], rax
mov rax, [rbp-576]
mov [rbp-584], rax
mov rdi, [rbp-584]
mov rax, rbp
sub rax, 8
mov [rbp-592], rax
call malloc
mov [rbp-600], rax
xor rax, rax
mov [rbp-608], rax
mov rax, [rbp-600]
mov [rbp-608], rax
;define variable salam
mov rax, [rbp-608]
mov [rbp-568], rax
;end define variable salam
mov rax, rbp
sub rax, 568
mov [rbp-616], rax
mov rax, 5
mov rbx, 8
mul rbx
mov rbx, [rbp-568]
add rbx, rax
mov [rbp-624], rbx
mov rax, [rbx]
mov [rbp-632], rax
mov rax, [rbp-632]
mov rbx, 987
mov rax, [rbp-624]
mov [rax], rbx
mov rax, rbx
mov [rbp-640], rax
mov rax, rbp
sub rax, 568
mov [rbp-656], rax
mov rax, 5
mov rbx, 8
mul rbx
mov rbx, [rbp-568]
add rbx, rax
mov [rbp-664], rbx
mov rax, [rbx]
mov [rbp-672], rax
mov rax, [rbp-664]
mov [rbp-680], rax
;define variable s5
mov rax, [rbp-680]
mov [rbp-648], rax
;end define variable s5
mov rax, __temp_str_1
mov [rbp-688], rax
mov rax, rbp
sub rax, 648
mov [rbp-696], rax
mov rax, [rbp-648]
mov [rbp-704], rax
mov rax, [rax]
mov [rbp-712], rax
mov rax, [rbp-712]
mov [rbp-720], rax
mov rdi, [rbp-688]
mov rsi, [rbp-720]
mov rax, rbp
sub rax, 8
mov [rbp-728], rax
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
