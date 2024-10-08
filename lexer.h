#ifndef LEXER_H
#define LEXER_H

typedef struct typed_token_
{
    unsigned char type_id;
    void *data;
    void (*debug)(struct typed_token_ *);
    struct typed_token_ *next;
} typed_token;

typed_token *tokenize(char *inp);

#define TKN_EOF 0
#define TKN_VOID 1
#define TKN_INT 2
#define TKN_CHAR 3
#define TKN_RETURN 4
#define TKN_FOR 5
#define TKN_IF 6
#define TKN_DO 7
#define TKN_WHILE 8
#define TKN_STRUCT 9
#define TKN_ELSE 10

// Single letter symbols
#define TKN_L_PAREN 16
#define TKN_R_PAREN 17
#define TKN_L_BRACE 18
#define TKN_R_BRACE 19
#define TKN_SEMICOLON 20
#define TKN_COMMA 21

#define TKN_ID 32
#define TKN_STR 33
#define TKN_LIT_INT 34

#define TKN_ASSIGN 64
#define TKN_EQ 65
#define TKN_LT 66
#define TKN_GT 67
#define TKN_LTE 68
#define TKN_GTE 69
#define TKN_NEG 70
#define TKN_NEQ 71
#define TKN_PLUS 72
#define TKN_PLUSPLUS 73
#define TKN_PLUSEQ 74
#define TKN_MIN 75
#define TKN_MINMIN 76
#define TKN_MINEQ 77
#define TKN_STAR 78
#define TKN_STAREQ 79
#define TKN_AMP 80

#define TKN_COMMENT 128

#endif