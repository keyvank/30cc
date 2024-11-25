#ifndef PROGRAM_H
#define PROGRAM_H

#include "../lexer.h"
#include "parser.h"
#include "../vec.h"

parser_node *parse_program(typed_token **tkns_ptr);

typedef struct
{
    int num_functions;
    parser_node **functions;
    int num_struct_defs;
    parser_node **struct_defs;
    vector *externs;
} node_program;

#endif
