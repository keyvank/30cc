
#include <stdlib.h>

#include "../lexer.h"
#include "parser.h"
#include "expr.h"
#include "literal.h"

parser_node *parse_expr(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    parser_node *ret = NULL;
    ret = parse_literal(&tkn);
    if (ret)
    {
        *tkns_ptr = tkn;
        return ret;
    }
    return NULL;
}