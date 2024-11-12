#include "lexer.h"
#include "linked_list.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

typedef struct
{
    char *id;
    linked_list *arg_names;
    linked_list *replace;
} seg_define;

typedef struct
{
    linked_list *defs;
} prep_ctx;

seg_define *find_define(prep_ctx *defs, char *id)
{
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

typedef struct seg_
{
    void *data;
    linked_list *(*to_code)(struct seg_ *self, prep_ctx *ctx);
} seg;

typedef struct
{
    typed_token *tkn;
} seg_tkn;

typedef struct
{
    seg_define *def;
    linked_list *args;
} seg_macro_call;

linked_list *seg_code_gen(seg *self, prep_ctx *ctx)
{
    linked_list *ret = new_linked_list();
    add_to_list(ret, ((seg_tkn *)self->data)->tkn);
    return ret;
}

linked_list *seg_define_gen(seg *self, prep_ctx *ctx)
{
    return new_linked_list();
}

linked_list *seg_macro_call_gen(seg *self, prep_ctx *ctx)
{
    seg_macro_call *call = (seg_macro_call *)self->data;
    linked_list *args = new_linked_list();
    if (call->args)
    {
        list_node *arg = call->args->first;
        while (arg)
        {
            seg *arg_seg = (seg *)arg->value;
            add_to_list(args, arg_seg->to_code(arg_seg, ctx));
            arg = arg->next;
        }
    }
    printf("HA\n");

    linked_list *ret = new_linked_list();

    list_node *repl_tkn = call->def->replace->first;
    while (repl_tkn)
    {
        add_to_list(ret, repl_tkn);
        repl_tkn = repl_tkn->next;
    }

    return ret;
}

seg *parse_code(prep_ctx *ctx, typed_token **tkns_ptr)
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
    ((seg_tkn *)ret->data)->tkn = tkn;
    tkn = tkn->next;
    *tkns_ptr = tkn;
    return ret;
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
                    ((seg_define *)ret->data)->id = def_name;
                    ((seg_define *)ret->data)->arg_names = NULL;
                    ((seg_define *)ret->data)->replace = repl;
                    add_to_list(ctx->defs, ret->data);
                    return ret;
                }
            }
        }
    }
    return NULL;
}

seg *parse_macro_call(prep_ctx *ctx, typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    if (tkn->type_id == TKN_ID)
    {
        seg_define *def = find_define(ctx, (char *)tkn->data);
        if (def)
        {
            char *macro_name = (char *)tkn->data;
            tkn = tkn->next;

            linked_list *args = new_linked_list();

            if (tkn->type_id == TKN_L_PAREN)
            {
                tkn = tkn->next;
                while (tkn)
                {
                    if (tkn->type_id == TKN_R_PAREN)
                    {
                        tkn = tkn->next;
                        break;
                    }

                    linked_list *arg = new_linked_list();
                    while (tkn->type_id != TKN_R_PAREN && tkn->type_id != TKN_COMMA && tkn->type_id != TKN_EOF)
                    {
                        add_to_list(arg, tkn);
                        tkn = tkn->next;
                    }
                    if (arg->count == 0)
                    {
                        fprintf(stderr, "Unexpected input!");
                        exit(1);
                    }
                    else
                    {
                        add_to_list(args, arg);
                    }

                    if (tkn->type_id == TKN_COMMA)
                    {
                        tkn = tkn->next;
                    }
                    else
                    {
                        if (tkn->type_id != TKN_R_PAREN)
                        {
                            fprintf(stderr, "Unexpected input!");
                            exit(1);
                        }
                    }
                }
            }

            *tkns_ptr = tkn;
            seg *ret = (seg *)malloc(sizeof(seg));
            ret->data = malloc(sizeof(seg_macro_call));
            ret->to_code = seg_macro_call_gen;
            ((seg_macro_call *)ret->data)->def = def;
            ((seg_macro_call *)ret->data)->args = args;
            return ret;
        }
    }
    return NULL;
}

linked_list *prep(typed_token *tkn)
{
    linked_list *ret = new_linked_list();
    prep_ctx *ctx = (prep_ctx *)malloc(sizeof(prep_ctx));
    ctx->defs = new_linked_list();
    while (tkn->type_id != TKN_EOF)
    {
        seg *s = NULL;
        if (!s)
            s = parse_code(ctx, &tkn);
        if (!s)
            s = parse_define(ctx, &tkn);
        if (!s)
            s = parse_macro_call(ctx, &tkn);
        if (s)
        {
            linked_list *res = s->to_code(s, ctx);
            printf("HERE\n");
            list_node *t = res->first;
            while (t)
            {
                typed_token *tk = (typed_token *)t->value;
                add_to_list(ret, tk);
                t = t->next;
            }
        }
    }
    return ret;
}