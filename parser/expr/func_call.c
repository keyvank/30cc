

#include <stdlib.h>
#include <string.h>

#include "../../lexer.h"
#include "../parser.h"
#include "func_call.h"
#include "expr.h"

void func_call_debug(int depth, parser_node *node)
{
    node_func_call *call = (node_func_call *)node->data;
    printtabs(depth);
    printf("FunctionCall:\n");
    printtabs(depth + 1);
    printf("Function:\n");
    call->func->debug(depth + 2, call->func);
    printtabs(depth + 1);
    printf("Args:\n");
    for (int i = 0; i < call->num_args; i++)
    {
        call->args[i]->debug(depth + 2, call->args[i]);
    }
}

apply_result *func_call_apply(parser_node *node, context *ctx)
{
    node_func_call *call = (node_func_call *)node->data;

    char **argvals = (char **)malloc(sizeof(char *) * 6);
    for (int i = 0; i < call->num_args; i++)
    {
        apply_result *regval = call->args[i]->apply(call->args[i], ctx);
        if (regval->type->kind == TYPE_STRUCT)
        {
            fprintf(stderr, "Passing structs to functions is unsupported!\n");
            exit(1);
        }

        symbol *tmp = new_temp_symbol(ctx, regval->type);
        add_text(ctx, "mov rax, %s", regval->code);
        add_text(ctx, "mov %s, rax", tmp->repl);

        argvals[i] = tmp->repl;
    }
    for (int i = 0; i < call->num_args; i++)
    {
        char *regname = NULL;
        if (i == 0)
            regname = "rdi";
        else if (i == 1)
            regname = "rsi";
        else if (i == 2)
            regname = "rdx";
        else if (i == 3)
            regname = "rcx";
        else if (i == 4)
            regname = "r8";
        else if (i == 5)
            regname = "r9";
        else
        {
            fprintf(stderr, "Cannot provide more than 6 args!\n");
            exit(1);
        }
        add_text(ctx, "mov %s, %s", regname, argvals[i]);
    }

    apply_result *fun = call->func->apply(call->func, ctx);
    general_type *ret_type = ((func_pointer_type *)fun->type->data)->return_type;

    add_text(ctx, "call %s", fun->code);
    symbol *tmp = new_temp_symbol(ctx, ret_type);
    add_text(ctx, "mov %s, rax", tmp->repl);

    return new_result(tmp->repl, tmp->type);
}

parser_node *parse_func_call(typed_token **tkns_ptr, parser_node *func)
{
    typed_token *tkn = *tkns_ptr;

    if (tkn->type_id == TKN_L_PAREN)
    {
        tkn = tkn->next;
        int num_args = 0;
        parser_node **args = (parser_node **)malloc(sizeof(parser_node *) * 32);
        while (tkn)
        {
            if (tkn->type_id == TKN_R_PAREN)
            {
                tkn = tkn->next;
                *tkns_ptr = tkn;

                parser_node *node = (parser_node *)malloc(sizeof(parser_node));
                node->data = (void *)malloc(sizeof(node_func_call));
                node->debug = func_call_debug;
                node->apply = func_call_apply;
                node_func_call *call = (node_func_call *)node->data;

                call->func = func;
                call->num_args = num_args;
                call->args = args;

                return node;
            }
            parser_node *arg = parse_expr(&tkn);
            if (arg)
            {
                args[num_args++] = arg;
            }
            else
            {
                return NULL;
            }

            if (tkn->type_id == TKN_COMMA)
            {
                tkn = tkn->next;
            }
            else
            {
                if (tkn->type_id != TKN_R_PAREN)
                {
                    return NULL;
                }
            }
        }
    }

    return NULL;
}
