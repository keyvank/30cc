#ifndef EXPR_H
#define EXPR_H

#include "../../lexer.h"
#include "../parser.h"

parser_node *parse_expr(typed_token **tkns_ptr);
parser_node *parse_terminal(typed_token **tkns_ptr);

typedef struct
{
    int op;
    parser_node *left;
    parser_node *right;
} node_binary_op;

typedef struct
{
    int op;
    parser_node *exp;
} node_unary_op;

parser_node *parse_unary(typed_token **tkns_ptr);

typedef struct
{
    int op;
    parser_node *exp;
} node_postfix;

parser_node *parse_postfix(typed_token **tkns_ptr, parser_node *curr);

typedef struct
{
    parser_node *type;
    parser_node *val;
} node_cast;

typedef struct
{
    parser_node *cond;
    parser_node *true_val;
    parser_node *false_val;
} node_cond;

#endif
