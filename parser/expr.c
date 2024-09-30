
#include <stdlib.h>

#include "../lexer.h"
#include "parser.h"
#include "expr.h"
#include "literal.h"

parser_node *parse_expr(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    parser_node *ret = NULL;

    /*ret = parse_binary_op(&tkn);
    if (ret)
    {
        *tkns_ptr = tkn;
        return ret;
    }*/
    if (tkn->type_id == TKN_L_PAREN)
    {
        tkn = tkn->next;
        parser_node *inner = parse_expr(&tkn);
        if (inner)
        {
            if (tkn->type_id == TKN_R_PAREN)
            {
                tkn = tkn->next;
                *tkns_ptr = tkn;
                return inner;
            }
        }
        else
        {
            return NULL;
        }
    }

    ret = parse_literal(&tkn);
    if (ret)
    {
        *tkns_ptr = tkn;
        return ret;
    }

    return NULL;
}