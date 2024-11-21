#include <stdlib.h>
#include "macro_define.h"
#include "preprocess.h"
#include <string.h>


linked_list *parse_arg_names(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    linked_list *ret = new_linked_list();
    if (tkn->type_id == TKN_L_PAREN)
    {
        tkn = tkn->next;
        while (tkn->type_id != TKN_R_PAREN)
        {
            if (tkn->type_id == TKN_ID)
            {
                add_to_list(ret, tkn->data);
                tkn = tkn->next;
            }
            else if (tkn->type_id == TKN_COMMA)
            {
                tkn = tkn->next;
            }
            else
            {
                return NULL;
            }
        }
        tkn = tkn->next;
        *tkns_ptr = tkn;
        return ret;
    }
    return NULL;
}

linked_list *seg_define_gen(seg *self, prep_ctx *ctx)
{
    return new_linked_list();
}

seg_define *find_define(prep_ctx *defs, char *id) {
    list_node *curr = defs->defs->first;
    while (curr)
    {
        seg_define *def = (seg_define *)curr->value;
        if (strcmp(def->id, id) == 0)
        {
            return def;
        }
        curr = curr->next;
    }
    return NULL;
}

seg *parse_define(prep_ctx *ctx, typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    if (tkn->type_id == TKN_DIRECTIVE)
    {
        typed_token *inner_tkn = (typed_token *)tkn->data;
        tkn = tkn->next;
        if (inner_tkn->type_id == TKN_ID)
        {
            if (strcmp((char *)inner_tkn->data, "define") == 0)
            {
                inner_tkn = inner_tkn->next;
                if (inner_tkn->type_id == TKN_ID)
                {
                    char *def_name = (char *)inner_tkn->data;
                    inner_tkn = inner_tkn->next;

                    linked_list *arg_names = parse_arg_names(&inner_tkn);

                    linked_list *repl = new_linked_list();
                    while (inner_tkn->type_id != TKN_EOF)
                    {
                        add_to_list(repl, inner_tkn);
                        inner_tkn = inner_tkn->next;
                    }

                    *tkns_ptr = tkn;
                    seg *ret = (seg *)malloc(sizeof(seg));
                    ret->data = malloc(sizeof(seg_define));
                    ret->to_code = seg_define_gen;
                    ret->stringified = NULL;
                    ((seg_define *)ret->data)->id = def_name;
                    ((seg_define *)ret->data)->arg_names = arg_names;
                    ((seg_define *)ret->data)->replace = repl;
                    add_to_list(ctx->defs, ret->data);
                    return ret;
                }
            }
        }
    }
    return NULL;
}