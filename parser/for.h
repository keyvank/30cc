#ifndef FOR_H
#define FOR_H

#include "../lexer.h"
#include "parser.h"

parser_node *parse_for(typed_token **tkns_ptr);

typedef struct
{
    parser_node *init;
    parser_node *cond;
    parser_node *act;
    parser_node *body;
} node_for;

#endif
