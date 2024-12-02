#include "../libc.h"
#include "macro_include.h"
#include "preprocess.h"

char *get_path(char *curr_path, char *header_path)
{
    char *new_path = (char *)malloc(128);
    strcpy(new_path, curr_path);

    char *last_slash = new_path;
    char *ptr = new_path;
    while (*ptr)
    {
        if (*ptr == '/')
        {
            last_slash = ptr + 1;
        }
        ptr++;
    }
    strcpy(last_slash, header_path);
    return new_path;
}

linked_list *seg_include_gen(seg *self, prep_ctx *ctx)
{
    seg_include *inc = (seg_include *)self->data;
    linked_list *ret = new_linked_list();

    typed_token *t = preprocess(ctx, get_path(ctx->curr_path, inc->path));
    while (t->type_id != TKN_EOF)
    {
        add_to_list(ret, t);
        t = t->next;
    }
    return ret;
}

seg *parse_include(prep_ctx *ctx, typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    if (tkn->type_id == TKN_DIRECTIVE)
    {
        typed_token *inner_tkn = (typed_token *)tkn->data;
        tkn = tkn->next;
        if (inner_tkn->type_id == TKN_ID)
        {
            if (strcmp((char *)inner_tkn->data, "include") == 0)
            {
                inner_tkn = inner_tkn->next;
                if (inner_tkn->type_id == TKN_LIT_STR)
                {
                    char *path = (char *)inner_tkn->data;
                    inner_tkn = inner_tkn->next;

                    if (inner_tkn->type_id == TKN_EOF)
                    {
                        *tkns_ptr = tkn;
                        seg *ret = (seg *)malloc(sizeof(seg));
                        ret->data = malloc(sizeof(seg_include));
                        ret->to_code = seg_include_gen;
                        ret->stringified = NULL;
                        ((seg_include *)ret->data)->path = path;
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