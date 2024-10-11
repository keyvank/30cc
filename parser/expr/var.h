#ifndef VAR_H
#define VAR_H

#include "../../lexer.h"
#include "../parser.h"

parser_node *parse_var(typed_token **tkns_ptr);

typedef struct
{
    char *var_name;
} node_var;

#endif