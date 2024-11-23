section .data
__printf_size: equ 16
__malloc_size: equ 16
__temp_str_2 db `%u %u %u %u %u\n`, 0
__temp_str_3 db `%u\n`, 0
__main_size: equ 768
section .text
extern printf
extern malloc
global main
main:
push rbp
mov rbp, rsp
sub rsp, __main_size
mov rax, rsp
add rax, 0
mov [rsp+40], rax
;;;
mov rax, [rsp+40]
add rax, 0
mov [rsp+48], rax
mov rax, [rax]
mov [rsp+56], rax
;;;
mov rax, [rsp+56]
mov rbx, 5
mov rax, 5
mov rbx, [rsp+48]
mov [rbx], rax
mov [rsp+64], rax
mov rax, rsp
add rax, 0
mov [rsp+72], rax
;;;
mov rax, [rsp+72]
add rax, 8
mov [rsp+80], rax
mov rax, [rax]
mov [rsp+88], rax
;;;
mov rax, [rsp+88]
mov rbx, 10
mov rax, 10
mov rbx, [rsp+80]
mov [rbx], rax
mov [rsp+96], rax
mov rax, rsp
add rax, 0
mov [rsp+104], rax
;;;
mov rax, [rsp+104]
add rax, 16
mov [rsp+112], rax
mov rax, [rax]
mov [rsp+128], rax
;;;
;;;
mov rax, [rsp+112]
add rax, 0
mov [rsp+144], rax
mov rax, [rax]
mov [rsp+152], rax
;;;
mov rax, [rsp+152]
mov rbx, 19
mov rax, 19
mov rbx, [rsp+144]
mov [rbx], rax
mov [rsp+160], rax
mov rax, rsp
add rax, 0
mov [rsp+168], rax
;;;
mov rax, [rsp+168]
add rax, 16
mov [rsp+176], rax
mov rax, [rax]
mov [rsp+192], rax
;;;
;;;
mov rax, [rsp+176]
add rax, 8
mov [rsp+208], rax
mov rax, [rax]
mov [rsp+216], rax
;;;
mov rax, [rsp+216]
mov rbx, 123
mov rax, 123
mov rbx, [rsp+208]
mov [rbx], rax
mov [rsp+224], rax
mov rax, rsp
add rax, 0
mov [rsp+232], rax
;;;
mov rax, [rsp+232]
add rax, 32
mov [rsp+240], rax
mov rax, [rax]
mov [rsp+248], rax
;;;
mov rax, rsp
add rax, 0
mov [rsp+256], rax
;;;
mov rax, [rsp+256]
add rax, 16
mov [rsp+264], rax
mov rax, [rax]
mov [rsp+280], rax
;;;
;;;
mov rax, [rsp+264]
add rax, 8
mov [rsp+296], rax
mov rax, [rax]
mov [rsp+304], rax
;;;
mov rax, [rsp+304]
mov rbx, 2
mul rbx
mov [rsp+312], rax
mov rax, rsp
add rax, 0
mov [rsp+320], rax
;;;
mov rax, [rsp+320]
add rax, 0
mov [rsp+328], rax
mov rax, [rax]
mov [rsp+336], rax
;;;
mov rax, [rsp+312]
mov rbx, [rsp+336]
add rax, rbx
mov [rsp+344], rax
mov rax, [rsp+248]
mov rbx, [rsp+344]
mov rax, [rsp+344]
mov rbx, [rsp+240]
mov [rbx], rax
mov [rsp+352], rax
mov rax, __temp_str_2
mov [rsp+360], rax
mov rax, rsp
add rax, 0
mov [rsp+368], rax
;;;
mov rax, [rsp+368]
add rax, 0
mov [rsp+376], rax
mov rax, [rax]
mov [rsp+384], rax
;;;
mov rax, [rsp+384]
mov [rsp+392], rax
mov rax, rsp
add rax, 0
mov [rsp+400], rax
;;;
mov rax, [rsp+400]
add rax, 8
mov [rsp+408], rax
mov rax, [rax]
mov [rsp+416], rax
;;;
mov rax, [rsp+416]
mov [rsp+424], rax
mov rax, rsp
add rax, 0
mov [rsp+432], rax
;;;
mov rax, [rsp+432]
add rax, 16
mov [rsp+440], rax
mov rax, [rax]
mov [rsp+456], rax
;;;
;;;
mov rax, [rsp+440]
add rax, 0
mov [rsp+472], rax
mov rax, [rax]
mov [rsp+480], rax
;;;
mov rax, [rsp+480]
mov [rsp+488], rax
mov rax, rsp
add rax, 0
mov [rsp+496], rax
;;;
mov rax, [rsp+496]
add rax, 16
mov [rsp+504], rax
mov rax, [rax]
mov [rsp+520], rax
;;;
;;;
mov rax, [rsp+504]
add rax, 8
mov [rsp+536], rax
mov rax, [rax]
mov [rsp+544], rax
;;;
mov rax, [rsp+544]
mov [rsp+552], rax
mov rax, rsp
add rax, 0
mov [rsp+560], rax
;;;
mov rax, [rsp+560]
add rax, 32
mov [rsp+568], rax
mov rax, [rax]
mov [rsp+576], rax
;;;
mov rax, [rsp+576]
mov [rsp+584], rax
mov rdi, [rsp+360]
mov rsi, [rsp+392]
mov rdx, [rsp+424]
mov rcx, [rsp+488]
mov r8, [rsp+552]
mov r9, [rsp+584]
mov rax, rsp
add rax, 0
mov [rsp+592], rax
call printf
mov [rsp+600], rax
mov rax, 10
mov rbx, 8
mul rbx
mov [rsp+608], rax
mov rax, [rsp+608]
mov [rsp+616], rax
mov rdi, [rsp+616]
mov rax, rsp
add rax, 0
mov [rsp+624], rax
call malloc
mov [rsp+632], rax
;define variable salam
mov rax, [rsp+632]
mov [rsp+600], rax
;end define variable salam
mov rax, rsp
add rax, 600
mov [rsp+640], rax
mov rax, 5
mov rbx, 8
mul rbx
mov rbx, [rsp+600]
add rbx, rax
mov [rsp+648], rbx
mov rax, [rbx]
mov [rsp+656], rax
mov rax, [rsp+656]
mov rbx, 987
mov rax, 987
mov rbx, [rsp+648]
mov [rbx], rax
mov [rsp+664], rax
mov rax, rsp
add rax, 600
mov [rsp+680], rax
mov rax, 5
mov rbx, 8
mul rbx
mov rbx, [rsp+600]
add rbx, rax
mov [rsp+688], rbx
mov rax, [rbx]
mov [rsp+696], rax
mov rax, [rsp+688]
mov [rsp+704], rax
;define variable s5
mov rax, [rsp+704]
mov [rsp+672], rax
;end define variable s5
mov rax, __temp_str_3
mov [rsp+712], rax
mov rax, rsp
add rax, 672
mov [rsp+720], rax
mov rax, [rsp+672]
mov [rsp+728], rax
mov rax, [rax]
mov [rsp+736], rax
mov rax, [rsp+736]
mov [rsp+744], rax
mov rdi, [rsp+712]
mov rsi, [rsp+744]
mov rax, rsp
add rax, 0
mov [rsp+752], rax
call printf
mov [rsp+760], rax
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
