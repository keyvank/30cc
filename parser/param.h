#ifndef PARAM_H
#define PARAM_H

#include "../lexer.h"
#include "parser.h"

parser_node *parse_param(typed_token **tkns_ptr);

typedef struct
{
    parser_node *type;
    char *identity;
} node_param;

#endif