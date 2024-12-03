#include "../libc.h"
#include "macro_call.h"
#include "token.h"

typed_token *clone(typed_token *tkn)
{
    typed_token *ret = (typed_token *)malloc(sizeof(typed_token));
    memcpy((void *)ret, (void *)tkn, sizeof(typed_token));
    ret->next = NULL;
    return ret;
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
                add_to_list(ret, (void *)clone(tkn));
                repl_tkn = repl_tkn->next;
                continue;
            }
        }
        else if (tkn->type_id == TKN_SHARP)
        {
            repl_tkn = repl_tkn->next;
            tkn = (typed_token *)repl_tkn->value;
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
            add_to_list(ret, (void *)clone(tkn));
        }
        repl_tkn = repl_tkn->next;
    }

    return ret;
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
                            s = parse_token(ctx, &tkn);
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