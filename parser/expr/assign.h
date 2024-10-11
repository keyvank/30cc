#ifndef ASSIGN_H
#define ASSIGN_H

#include "../../lexer.h"
#include "../parser.h"

parser_node *parse_assign(typed_token **tkns_ptr);

typedef struct
{
    char *identity;
    parser_node *value;
} node_assign;

#endif
