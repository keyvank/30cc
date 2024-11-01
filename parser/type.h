#ifndef TYPE_H
#define TYPE_H

#include "../lexer.h"
#include "parser.h"
#include "../codegen/codegen.h"

parser_node *parse_type(typed_token **tkns_ptr, int allow_naming);

typedef struct
{
    general_type *type;
    char *name;
} node_type;

#endif
