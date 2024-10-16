.PHONY=run

CC ?= cc
CFLAGS := -std=gnu99 -Wall -Wextra -pedantic -Og -ggdb

BIN := a.out

$(BIN): *.c parser/*.c parser/expr/*.c codegen/*.c
	$(CC) $(CFLAGS) *.c parser/*.c codegen/*.c parser/expr/*.c

run:
	./a.out examples/inp5.c --asm > out.asm
	nasm -f elf64 out.asm -o out.o
	ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 -lc -o out out.o
	./out