#ifndef ASM_H
#define ASM_H

#include "../lexer.h"
#include "parser.h"
#include "../linked_list.h"

parser_node *parse_asm(typed_token **tkns_ptr);

typedef struct
{
    linked_list *lines;
} node_asm;

#endif
