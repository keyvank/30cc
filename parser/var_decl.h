#ifndef VAR_DECL_H
#define VAR_DECL_H

#include "../lexer.h"
#include "parser.h"

parser_node *parse_var_decl(typed_token **tkns_ptr);

typedef struct
{
    parser_node *type;
    char *identity;
    parser_node *value;
} node_var_decl;

#endif
