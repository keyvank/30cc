#ifndef TYPE_H
#define TYPE_H

#include "../lexer.h"
#include "parser.h"

parser_node *parse_type(typed_token **tkns_ptr);

typedef struct
{
    char *name;
    int num_pointing;
    int dim;
    int *dims;
} node_type;

#endif