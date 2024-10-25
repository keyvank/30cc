#ifndef STRUCT_DEF_H
#define STRUCT_DEF_H

#include "../lexer.h"
#include "parser.h"

parser_node *parse_struct_def(typed_token **tkns_ptr);

typedef struct
{
    char *struct_name;
    char *typedef_name;
    int num_fields;
    parser_node **fields;
} node_struct_def;

#endif
