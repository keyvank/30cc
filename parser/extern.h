#ifndef EXTERN_H
#define EXTERN_H

#include "../lexer.h"
#include "parser.h"

parser_node *parse_extern(typed_token **tkns_ptr);

typedef struct
{
    parser_node *var_decl;
} node_extern;

#endif
