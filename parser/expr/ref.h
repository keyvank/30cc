#ifndef REF_H
#define REF_H

#include "../../lexer.h"
#include "../parser.h"

parser_node *parse_ref(typed_token **tkns_ptr);

typedef struct
{
    parser_node *var;
} node_ref;

#endif
