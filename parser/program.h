#ifndef PROGRAM_H
#define PROGRAM_H

#include "../lexer.h"
#include "parser.h"

parser_node *parse_program(typed_token **tkns_ptr);

typedef struct
{
    int num_functions;
    parser_node **functions;
} node_program;

#endif
