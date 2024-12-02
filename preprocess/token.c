
#include <stdlib.h>
#include "token.h"
#include "macro_define.h"

linked_list *seg_code_gen(seg *self, prep_ctx *ctx)
{
    linked_list *ret = new_linked_list();
    add_to_list(ret, ((seg_tkn *)self->data)->tkn);
    return ret;
}

seg *parse_token(prep_ctx *ctx, typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    if (tkn->type_id == TKN_EOF)
        return NULL;
    if (tkn->type_id == TKN_DIRECTIVE)
        return NULL;
    if (tkn->type_id == TKN_ID)
    {
        if (find_define(ctx, (char *)tkn->data))
        {
            return NULL;
        }
    }
    seg *ret = (seg *)malloc(sizeof(seg));
    ret->data = malloc(sizeof(seg_tkn));
    ret->to_code = seg_code_gen;
    if (tkn->type_id == TKN_ID)
        ret->stringified = (char *)tkn->data;
    else
        ret->stringified = NULL;
    ((seg_tkn *)ret->data)->tkn = tkn;
    tkn = tkn->next;
    *tkns_ptr = tkn;
    return ret;
}