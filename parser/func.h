#ifndef FUNCTION_H
#define FUNCTION_H

#include "../lexer.h"
#include "parser.h"

parser_node *parse_function(typed_token **tkns_ptr);

typedef struct
{
    char *identity;
    parser_node *return_type;
    int num_params;
    parser_node **params;
    int num_statements;
    parser_node **statements;
} node_func_def;

typedef struct
{
    char *identity;
    parser_node *return_type;
    int num_params;
    parser_node **param_types;
} node_func_decl;

#endif