#ifndef TYPE_H
#define TYPE_H

#include "../lexer.h"
#include "parser.h"

parser_node *parse_type(typed_token **tkns_ptr);

typedef struct
{
    char *name;
} node_type;

#endif