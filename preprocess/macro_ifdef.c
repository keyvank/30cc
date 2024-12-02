#include <stdlib.h>
#include <stdio.h>
#include "macro_ifdef.h"
#include "preprocess.h"
#include <string.h>

char *is_ifdef(typed_token *tkn, int * not )
{
    if (tkn->type_id == TKN_DIRECTIVE)
    {
        typed_token *inner_tkn = (typed_token *)tkn->data;
        tkn = tkn->next;
        if (inner_tkn->type_id == TKN_ID)
        {
            if (strcmp((char *)inner_tkn->data, "ifndef") == 0 || strcmp((char *)inner_tkn->data, "ifdef") == 0)
            {
                *not = strcmp((char *)inner_tkn->data, "ifndef") == 0;
                inner_tkn = inner_tkn->next;
                if (inner_tkn->type_id == TKN_ID)
                {
                    char *def = (char *)inner_tkn->data;
                    inner_tkn = inner_tkn->next;
                    if (inner_tkn->type_id == TKN_EOF)
                    {
                        return def;
                    }
                }
            }
        }
    }
    return NULL;
}

seg_ifdef *parse_ifdef(prep_ctx *ctx, typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    int ndef = 0;
    char *def = is_ifdef(tkn, &ndef);
    if (def)
    {
        tkn = tkn->next;

        typed_token *endif = tkn;
        int cnt = 1;
        while (endif)
        {
            int tmp = 0;
            if (is_endif(endif))
                cnt -= 1;
            else if (is_ifdef(endif, &tmp))
                cnt += 1;
            if (cnt == 0)
            {
                break;
            }
            endif = endif->next;
        }
        if (cnt != 0)
        {
            fprintf(stderr, "Cannot find corresponding #endif!\n");
            exit(1);
        }

        *tkns_ptr = tkn;
        seg_ifdef *ret = (seg_ifdef *)malloc(sizeof(seg_ifdef));
        ret->ndef = ndef;
        ret->def = def;
        ret->endif = endif;
        return ret;
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