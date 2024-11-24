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
mov rax, [rsp+48]
mov [rax], rbx
mov rax, rbx
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
mov rax, [rsp+80]
mov [rax], rbx
mov rax, rbx
mov [rsp+96], rax
mov rax, rsp
add rax, 0
mov [rsp+104], rax
;;;
mov rax, [rsp+104]
add rax, 16
mov [rsp+112], rax
mov (null), [rax]
mov [rsp+120], (null)
;;;
;;;
mov rax, [rsp+112]
add rax, 0
mov [rsp+136], rax
mov rax, [rax]
mov [rsp+144], rax
;;;
mov rax, [rsp+144]
mov rbx, 19
mov rax, [rsp+136]
mov [rax], rbx
mov rax, rbx
mov [rsp+152], rax
mov rax, rsp
add rax, 0
mov [rsp+160], rax
;;;
mov rax, [rsp+160]
add rax, 16
mov [rsp+168], rax
mov (null), [rax]
mov [rsp+176], (null)
;;;
;;;
mov rax, [rsp+168]
add rax, 8
mov [rsp+192], rax
mov rax, [rax]
mov [rsp+200], rax
;;;
mov rax, [rsp+200]
mov rbx, 123
mov rax, [rsp+192]
mov [rax], rbx
mov rax, rbx
mov [rsp+208], rax
mov rax, rsp
add rax, 0
mov [rsp+216], rax
;;;
mov rax, [rsp+216]
add rax, 32
mov [rsp+224], rax
mov rax, [rax]
mov [rsp+232], rax
;;;
mov rax, rsp
add rax, 0
mov [rsp+240], rax
;;;
mov rax, [rsp+240]
add rax, 16
mov [rsp+248], rax
mov (null), [rax]
mov [rsp+256], (null)
;;;
;;;
mov rax, [rsp+248]
add rax, 8
mov [rsp+272], rax
mov rax, [rax]
mov [rsp+280], rax
;;;
mov rax, [rsp+280]
mov rbx, 2
mul rbx
mov [rsp+288], rax
mov rax, rsp
add rax, 0
mov [rsp+296], rax
;;;
mov rax, [rsp+296]
add rax, 0
mov [rsp+304], rax
mov rax, [rax]
mov [rsp+312], rax
;;;
mov rax, [rsp+288]
mov rbx, [rsp+312]
add rax, rbx
mov [rsp+320], rax
mov rax, [rsp+232]
mov rbx, [rsp+320]
mov rax, [rsp+224]
mov [rax], rbx
mov rax, rbx
mov [rsp+328], rax
mov rax, __temp_str_0
mov [rsp+336], rax
mov rax, rsp
add rax, 0
mov [rsp+344], rax
;;;
mov rax, [rsp+344]
add rax, 0
mov [rsp+352], rax
mov rax, [rax]
mov [rsp+360], rax
;;;
mov rax, [rsp+360]
mov [rsp+368], rax
mov rax, rsp
add rax, 0
mov [rsp+376], rax
;;;
mov rax, [rsp+376]
add rax, 8
mov [rsp+384], rax
mov rax, [rax]
mov [rsp+392], rax
;;;
mov rax, [rsp+392]
mov [rsp+400], rax
mov rax, rsp
add rax, 0
mov [rsp+408], rax
;;;
mov rax, [rsp+408]
add rax, 16
mov [rsp+416], rax
mov (null), [rax]
mov [rsp+424], (null)
;;;
;;;
mov rax, [rsp+416]
add rax, 0
mov [rsp+440], rax
mov rax, [rax]
mov [rsp+448], rax
;;;
mov rax, [rsp+448]
mov [rsp+456], rax
mov rax, rsp
add rax, 0
mov [rsp+464], rax
;;;
mov rax, [rsp+464]
add rax, 16
mov [rsp+472], rax
mov (null), [rax]
mov [rsp+480], (null)
;;;
;;;
mov rax, [rsp+472]
add rax, 8
mov [rsp+496], rax
mov rax, [rax]
mov [rsp+504], rax
;;;
mov rax, [rsp+504]
mov [rsp+512], rax
mov rax, rsp
add rax, 0
mov [rsp+520], rax
;;;
mov rax, [rsp+520]
add rax, 32
mov [rsp+528], rax
mov rax, [rax]
mov [rsp+536], rax
;;;
mov rax, [rsp+536]
mov [rsp+544], rax
mov rdi, [rsp+336]
mov rsi, [rsp+368]
mov rdx, [rsp+400]
mov rcx, [rsp+456]
mov r8, [rsp+512]
mov r9, [rsp+544]
mov rax, rsp
add rax, 0
mov [rsp+552], rax
call printf
mov rax, 10
mov rbx, 8
mul rbx
mov [rsp+568], rax
mov rax, [rsp+568]
mov [rsp+576], rax
mov rdi, [rsp+576]
mov rax, rsp
add rax, 0
mov [rsp+584], rax
call malloc
mov [rsp+592], rax
;define variable salam
mov rax, [rsp+592]
mov [rsp+560], rax
;end define variable salam
mov rax, rsp
add rax, 560
mov [rsp+600], rax
mov rax, 5
mov rbx, 8
mul rbx
mov rbx, [rsp+560]
add rbx, rax
mov [rsp+608], rbx
mov rax, [rbx]
mov [rsp+616], rax
mov rax, [rsp+616]
mov rbx, 987
mov rax, [rsp+608]
mov [rax], rbx
mov rax, rbx
mov [rsp+624], rax
mov rax, rsp
add rax, 560
mov [rsp+640], rax
mov rax, 5
mov rbx, 8
mul rbx
mov rbx, [rsp+560]
add rbx, rax
mov [rsp+648], rbx
mov rax, [rbx]
mov [rsp+656], rax
mov rax, [rsp+648]
mov [rsp+664], rax
;define variable s5
mov rax, [rsp+664]
mov [rsp+632], rax
;end define variable s5
mov rax, __temp_str_1
mov [rsp+672], rax
mov rax, rsp
add rax, 632
mov [rsp+680], rax
mov rax, [rsp+632]
mov [rsp+688], rax
mov rax, [rax]
mov [rsp+696], rax
mov rax, [rsp+696]
mov [rsp+704], rax
mov rdi, [rsp+672]
mov rsi, [rsp+704]
mov rax, rsp
add rax, 0
mov [rsp+712], rax
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
