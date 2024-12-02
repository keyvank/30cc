

#include "../linked_list.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "../lexer.h"
#include "preprocess.h"
#include "macro_define.h"
#include "macro_call.h"
#include "macro_include.h"
#include "macro_ifdef.h"
#include "token.h"

typed_token *clone_token(typed_token *a)
{
    typed_token *ret = (typed_token *)malloc(sizeof(typed_token));
    memcpy((void *)ret, (void *)a, sizeof(typed_token));
    ret->next = NULL;
    return ret;
}

typed_token *chain_tokens(linked_list *tkns)
{
    if (tkns->count == 0)
        return eof_token();
    list_node *curr = tkns->first;
    if (curr == NULL)
        return NULL;
    typed_token *res_first = clone_token((typed_token *)curr->value);
    typed_token *curr_tkn = res_first;
    while (curr)
    {
        curr = curr->next;
        if (curr)
        {
            curr_tkn->next = clone_token((typed_token *)curr->value);
            curr_tkn = curr_tkn->next;
        }
        else
        {
            curr_tkn->next = eof_token();
        }
    }
    return res_first;
}

typed_token *preprocess(prep_ctx *ctx, char *path)
{
    char *prev_path = ctx->curr_path;
    ctx->curr_path = path;
    typed_token *tkn = tokenize_file(path);
    linked_list *ret = new_linked_list();

    while (tkn->type_id != TKN_EOF)
    {
        if (is_endif(tkn))
        {
            tkn = tkn->next;
            continue;
        }

        seg_ifdef *ifdef = parse_ifdef(ctx, &tkn);
        if (ifdef)
        {
            int def_found = find_define(ctx, ifdef->def) != 0;
            if ((ifdef->ndef && def_found) || (!ifdef->ndef && !def_found))
            {
                int endif_found = 0;
                while (tkn->type_id != TKN_EOF)
                {
                    if (tkn == ifdef->endif)
                    {
                        endif_found = 1;
                        break;
                    }
                    tkn = tkn->next;
                }
                if (!endif_found)
                {
                    fprintf(stderr, "Couldn't find #endif!\n");
                    exit(1);
                }
                else
                {
                    continue;
                }
            }
        }

        seg *s = NULL;
        if (!s)
            s = parse_token(ctx, &tkn);
        if (!s)
            s = parse_define(ctx, &tkn);
        if (!s)
            s = parse_include(ctx, &tkn);
        if (!s)
            s = parse_macro_call(ctx, &tkn);

        if (s)
        {
            linked_list *res = s->to_code(s, ctx);
            if (res != NULL)
            {
                list_node *t = res->first;
                while (t)
                {
                    typed_token *tk = (typed_token *)t->value;
                    add_to_list(ret, tk);
                    t = t->next;
                }
            }
        }
    }

    ctx->curr_path = prev_path;

    return chain_tokens(ret);
}
