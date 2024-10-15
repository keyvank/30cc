
#ifndef FUNC_CALL_H
#define FUNC_CALL_H

#include "../../lexer.h"
#include "../parser.h"

parser_node *parse_func_call(typed_token **tkns_ptr, parser_node *func);

typedef struct
{
    parser_node *func;
    int num_args;
    parser_node **args;
} node_func_call;

#endif