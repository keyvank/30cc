#ifndef TYPE_H
#define TYPE_H

#include "../lexer.h"
#include "parser.h"

parser_node *parse_type(typed_token **tkns_ptr);

typedef struct
{
    char *name;
    int num_pointing;
    int is_struct;
    int dim;
    int *dims;
} node_type;

typedef struct
{
    parser_node *ret_type;
    int num_args;
    parser_node **arg_types;
} node_func_type;

#endif
