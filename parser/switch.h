#ifndef SWITCH_H
#define SWITCH_H

#include "../lexer.h"
#include "parser.h"
#include "statement.h"

parser_node *parse_switch(typed_token **tkns_ptr);

// typedef struct
// {
//     parser_node *value;
//     node_compound_statement **body;
// } node_case;

typedef struct
{
    parser_node *condition;
    linked_list *statements;
    linked_list *cases;
    linked_list *case_locations;
    int default_location;
} node_switch;


#endif
