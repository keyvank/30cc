#ifndef STATEMENT_H
#define STATEMENT_H

#include "../lexer.h"
#include "parser.h"

parser_node *parse_statement(typed_token **tkns_ptr);

typedef struct
{
    int num_statements;
    parser_node **statements;
} node_compound_statement;

typedef struct
{
    parser_node *exp;
} node_return;

#endif
