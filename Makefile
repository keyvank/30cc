CC ?= cc
CFLAGS := -std=gnu99 -Wall -Wextra -pedantic -Og -ggdb

BIN := a.out

$(BIN): *.c parser/*.c
	$(CC) $(CFLAGS) *.c parser/*.c
