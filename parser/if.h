#ifndef IF_H
#define IF_H

#include "../lexer.h"
#include "parser.h"

parser_node *parse_if(typed_token **tkns_ptr);

typedef struct
{
    parser_node *cond;
    parser_node *body;
} node_if;

#endif
