#ifndef GOTO_H
#define GOTO_H

#include "../lexer.h"
#include "parser.h"

parser_node *parse_label(typed_token **tkns_ptr);
parser_node *parse_goto(typed_token **tkns_ptr);

typedef struct
{
    char *name;
} node_label;

typedef struct
{
    char *label;
} node_goto;

#endif
