
#include <stdlib.h>

#include "../lexer.h"
#include "parser.h"
#include "statement.h"
#include "var_decl.h"
#include "expr.h"

parser_node *parse_statement(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    parser_node *ret = NULL;
    ret = parse_var_decl(&tkn);
    if (ret)
    {
        *tkns_ptr = tkn;
        return ret;
    }

    ret = parse_expr(&tkn);
    if (ret)
    {
        if (tkn->type_id == TKN_SEMICOLON)
        {
            tkn = tkn->next;
            *tkns_ptr = tkn;
            return ret;
        }
        else
        {
            return NULL;
        }
    }

    return NULL;
}