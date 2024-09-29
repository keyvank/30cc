
#include <stdlib.h>

#include "../lexer.h"
#include "parser.h"
#include "statement.h"
#include "var_decl.h"
#include "assign.h"

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

    ret = parse_assign(&tkn);
    if (ret)
    {
        *tkns_ptr = tkn;
        return ret;
    }

    return NULL;
}