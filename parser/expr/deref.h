#ifndef DEREF_H
#define DEREF_H

#include "../../lexer.h"
#include "../parser.h"

parser_node *parse_deref(typed_token **tkns_ptr);

typedef struct
{
    parser_node *var;
} node_deref;

#endif
