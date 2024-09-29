#ifndef LITERAL_H
#define LITERAL_H

#include "../lexer.h"
#include "parser.h"

parser_node *parse_literal(typed_token **tkns_ptr);

typedef struct
{
    int type;
    char *value;
} node_literal;

#endif