CC ?= cc
CFLAGS := -std=gnu99 -Wall -Wextra -pedantic -Og -ggdb

BIN := a.out

$(BIN): main.c lexer.c parser/parser.c parser/func.c parser/type.c parser/param.c parser/var_decl.c parser/assign.c parser/statement.c parser/program.c
	$(CC) $(CFLAGS) main.c lexer.c parser/func.c parser/parser.c parser/type.c parser/param.c parser/var_decl.c parser/assign.c parser/statement.c parser/program.c
