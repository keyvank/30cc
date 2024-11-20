#include "lexer.h"
#include "linked_list.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

typed_token *chain_tokens2(linked_list *tkns)
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
    char *stringified;
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
    linked_list *arg_strs = new_linked_list();
    if (call->args)
    {
        list_node *arg = call->args->first;
        while (arg)
        {
            linked_list *expanded_arg = new_linked_list();
            linked_list *arg_parts = (linked_list *)arg->value;
            if (arg_parts->count == 1)
            {
                seg *arg_seg = (seg *)((list_node *)arg_parts->first)->value;
                add_to_list(arg_strs, arg_seg->stringified);
            }
            else
            {
                add_to_list(arg_strs, NULL);
            }
            list_node *arg_part = (list_node *)arg_parts->first;
            while (arg_part)
            {
                seg *arg_seg = (seg *)arg_part->value;
                add_to_list(expanded_arg, arg_seg->to_code(arg_seg, ctx));
                arg_part = arg_part->next;
            }
            add_to_list(args, expanded_arg);
            arg = arg->next;
        }
    }
    linked_list *ret = new_linked_list();

    list_node *repl_tkn = call->def->replace->first;
    seg_define *def = call->def;
    while (repl_tkn)
    {
        typed_token *tkn = (typed_token *)repl_tkn->value;
        if (def->arg_names && tkn->type_id == TKN_ID)
        {
            list_node *curr_arg = args->first;
            list_node *curr_arg_name = def->arg_names->first;
            int found = 0;
            while (curr_arg_name)
            {
                if (strcmp(curr_arg_name->value, tkn->data) == 0)
                {
                    list_node *arg_tkn = ((linked_list *)curr_arg->value)->first;
                    while (arg_tkn)
                    {
                        list_node *arg_part_tkn = ((linked_list *)arg_tkn->value)->first;
                        while (arg_part_tkn)
                        {
                            add_to_list(ret, arg_part_tkn->value);
                            arg_part_tkn = arg_part_tkn->next;
                        }
                        arg_tkn = arg_tkn->next;
                    }
                    found = 1;
                    break;
                }
                curr_arg_name = curr_arg_name->next;
                curr_arg = curr_arg->next;
            }
            if (!found)
            {
                add_to_list(ret, clone(tkn));
                repl_tkn = repl_tkn->next;
                continue;
            }
        }
        else if (tkn->type_id == TKN_SHARP)
        {
            repl_tkn = repl_tkn->next;
            tkn = repl_tkn->value;
            if (tkn->type_id != TKN_ID)
            {
                fprintf(stderr, "Expected identifier!\n");
                exit(1);
            }

            list_node *curr_arg = args->first;
            list_node *curr_arg_name = def->arg_names->first;
            list_node *curr_arg_str = arg_strs->first;
            int found = 0;
            while (curr_arg_name)
            {
                if (strcmp(curr_arg_name->value, tkn->data) == 0)
                {
                    if (curr_arg_str->value)
                    {
                        typed_token *str_tkn = new_tkn(TKN_LIT_STR, curr_arg_str->value, str_tkn_debug);
                        add_to_list(ret, str_tkn);
                        found = 1;
                    }
                    else
                    {
                        fprintf(stderr, "Cannot stringify non-identifiers!\n");
                        exit(1);
                    }
                    break;
                }
                curr_arg_name = curr_arg_name->next;
                curr_arg = curr_arg->next;
                curr_arg_str = curr_arg_str->next;
            }
            if (!found)
            {
                fprintf(stderr, "Stringified arg not provided!");
                exit(1);
            }
        }
        else
        {
            add_to_list(ret, clone(tkn));
        }
        repl_tkn = repl_tkn->next;
    }

    return ret;
}

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
    if (tkn->type_id == TKN_ID)
        ret->stringified = tkn->data;
    else
        ret->stringified = NULL;
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
                        seg *s = NULL;
                        if (!s)
                            s = parse_code(ctx, &tkn);
                        if (!s)
                            s = parse_define(ctx, &tkn);
                        if (!s)
                            s = parse_macro_call(ctx, &tkn);
                        if (s)
                            add_to_list(arg, s);
                        else
                        {
                            fprintf(stderr, "Cannot parse!");
                            exit(1);
                        }
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
            ret->stringified = NULL;
            if (!def->arg_names)
            {
                ret->stringified = def->id;
            }

            ((seg_macro_call *)ret->data)->def = def;
            ((seg_macro_call *)ret->data)->args = args;
            return ret;
        }
    }
    return NULL;
}

typed_token *prep(typed_token *tkn)
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
            list_node *t = res->first;
            while (t)
            {
                typed_token *tk = (typed_token *)t->value;
                add_to_list(ret, tk);
                t = t->next;
            }
        }
    }
    return chain_tokens2(ret);
}