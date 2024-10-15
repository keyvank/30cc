
#ifndef INDEX_H
#define INDEX_H

#include "../../lexer.h"
#include "../parser.h"

parser_node *parse_index(typed_token **tkns_ptr, parser_node *arr);

typedef struct
{
    parser_node *arr;
    parser_node *ind;
} node_index;

#endif