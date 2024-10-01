#ifndef EXPR_H
#define EXPR_H

#include "../lexer.h"
#include "parser.h"

parser_node *parse_expr(typed_token **tkns_ptr);

typedef struct
{
    int op;
    parser_node *left;
    parser_node *right;
} node_binary_op;

typedef struct
{
    char *func_name;
    int num_args;
    parser_node **args;
} node_func_call;

#endif
