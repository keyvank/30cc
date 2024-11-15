#ifndef WHILE_H
#define WHILE_H

#include "../lexer.h"
#include "parser.h"

parser_node *parse_while(typed_token **tkns_ptr);
parser_node *parse_do_while(typed_token **tkns_ptr);

typedef struct
{
    parser_node *cond;
    parser_node *body;
} node_while;

#endif
