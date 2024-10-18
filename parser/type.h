#ifndef TYPE_H
#define TYPE_H

#include "../lexer.h"
#include "parser.h"
#include "../codegen/codegen.h"

parser_node *parse_type(typed_token **tkns_ptr);

typedef struct
{
    context_type *type;
} node_type;

#endif
