#ifndef STATEMENT_H
#define STATEMENT_H

#include "../lexer.h"
#include "parser.h"

parser_node *parse_statement(typed_token **tkns_ptr);

#endif
