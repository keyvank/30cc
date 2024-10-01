CC ?= cc
CFLAGS := -std=gnu99 -Wall -Wextra -pedantic -Og -ggdb

BIN := a.out

$(BIN): *.c parser/*.c
	$(CC) $(CFLAGS) *.c parser/*.c

gen:
	gcc codegen.c -o codegen
	./codegen > out.asm
	nasm -f elf64 out.asm -o out.o
	ld -o out out.o
	./out