CC ?= cc
CFLAGS := -std=gnu99 -Wall -Wextra -pedantic -Og -ggdb

BIN := a.out

$(BIN): main.c
	$(CC) $(CFLAGS) main.c
