#ifndef BREAK_H
#define BREAK_H

#include "../lexer.h"
#include "parser.h"

parser_node *parse_break(typed_token **tkns_ptr);
parser_node *parse_continue(typed_token **tkns_ptr);

#endif
