#include "../libc.h"
#include "macro_ifndef.h"
#include "preprocess.h"

seg_ifndef *parse_ifndef(prep_ctx *ctx, typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    if (tkn->type_id == TKN_DIRECTIVE)
    {
        typed_token *inner_tkn = (typed_token *)tkn->data;
        tkn = tkn->next;
        if (inner_tkn->type_id == TKN_ID)
        {
            if (strcmp((char *)inner_tkn->data, "ifndef") == 0)
            {
                inner_tkn = inner_tkn->next;
                if (inner_tkn->type_id == TKN_ID)
                {
                    char *def = (char *)inner_tkn->data;
                    inner_tkn = inner_tkn->next;

                    if (inner_tkn->type_id == TKN_EOF)
                    {
                        *tkns_ptr = tkn;
                        seg_ifndef *ret = malloc(sizeof(seg_ifndef));
                        ret->def = def;
                        return ret;
                    }
                    else
                    {
                        return NULL;
                    }
                }
            }
        }
    }
    return NULL;
}

int is_endif(typed_token *tkn)
{
    if (tkn->type_id == TKN_DIRECTIVE)
    {
        typed_token *inner_tkn = (typed_token *)tkn->data;
        if (inner_tkn->type_id == TKN_ID)
        {
            if (strcmp((char *)inner_tkn->data, "endif") == 0)
            {
                inner_tkn = inner_tkn->next;
                if (inner_tkn->type_id == TKN_EOF)
                {
                    return 1;
                }
            }
        }
    }
    return 0;
}