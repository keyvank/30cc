#ifndef FUNCTION_H
#define FUNCTION_H

#include "../lexer.h"
#include "../vec.h"
#include "parser.h"

parser_node *parse_function(typed_token **tkns_ptr);

typedef struct
{
    char *identity;
    parser_node *return_type;
    int num_params;
    parser_node **params;
    int num_statements;
    vector *statements;
} node_func_def;

#endif
