#ifndef ACCESS_H
#define ACCESS_H

#include "../../lexer.h"
#include "../parser.h"

parser_node *parse_access(typed_token **tkns_ptr, parser_node *obj);

typedef struct
{
    parser_node *object;
    char *field_name;
    int is_ptr;
} node_access;

#endif
