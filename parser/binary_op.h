#ifndef BINARY_OP_H
#define BINARY_OP_H

#include "../lexer.h"
#include "parser.h"

parser_node *parse_binary_op(typed_token **tkns_ptr);

typedef struct
{
    int op;
    parser_node *left;
    parser_node *right;
} node_binary_op;

#endif