

#include "../linked_list.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "../lexer.h"
#include "preprocess.h"
#include "macro_define.h"
#include "macro_call.h"
#include "token.h"

typed_token *chain_tokens(linked_list *tkns)
{
    list_node *curr = tkns->first;
    typed_token *res_first = (typed_token *)curr->value;
    typed_token *curr_tkn = res_first;
    while (curr)
    {
        curr = curr->next;
        if (curr)
        {
            curr_tkn->next = (typed_token *)curr->value;
            curr_tkn = curr_tkn->next;
        }
    }
    return res_first;
}

typed_token *preprocess(typed_token *tkn)
{
    linked_list *ret = new_linked_list();
    prep_ctx *ctx = (prep_ctx *)malloc(sizeof(prep_ctx));
    ctx->defs = new_linked_list();
    while (tkn->type_id != TKN_EOF)
    {
        seg *s = NULL;
        if (!s)
            s = parse_token(ctx, &tkn);
        if (!s)
            s = parse_define(ctx, &tkn);
        if (!s)
            s = parse_macro_call(ctx, &tkn);

        if (s)
        {
            linked_list *res = s->to_code(s, ctx);
            list_node *t = res->first;
            while (t)
            {
                typed_token *tk = (typed_token *)t->value;
                add_to_list(ret, tk);
                t = t->next;
            }
        }
    }

    return chain_tokens(ret);
}