
#include <stdlib.h>

#include "../lexer.h"
#include "parser.h"
#include "expr.h"
#include "literal.h"
#include "assign.h"

void binary_op_debug(int depth, parser_node *node)
{
    node_binary_op *binop = (node_binary_op *)node->data;
    printtabs(depth);
    printf("BinaryOp(Op: %d)\n", binop->op);
    printtabs(depth + 1);
    printf("Left:\n");
    binop->left->debug(depth + 2, binop->left);
    printtabs(depth + 1);
    printf("Right:\n");
    binop->right->debug(depth + 2, binop->right);
}

void func_call_debug(int depth, parser_node *node)
{
    node_func_call *call = (node_func_call *)node->data;
    printtabs(depth);
    printf("FunctionCall(Name: %s)\n", call->func_name);
    printtabs(depth + 1);
    printf("Args:\n");
    for (int i = 0; i < call->num_args; i++)
    {
        call->args[i]->debug(depth + 2, call->args[i]);
    }
}

char *func_call_apply(parser_node *node, context *ctx)
{
    node_func_call *call = (node_func_call *)node->data;

    for(int i = 0; i < call->num_args; i++) {
        char *regname = NULL;
        if(i == 0) regname = "rdi";
        else if(i == 1) regname = "rsi";
        else if(i == 2) regname = "rdx";
        else if(i == 3) regname = "rcx";
        else if(i == 4) regname = "r8";
        else if(i == 5) regname = "r9";
        else {
            printf("More than 6 args!");
            exit(0);
        }
        char *regval = call->args[i]->apply(call->args[i], ctx);
        char *set_arg = malloc(128);
        sprintf(set_arg, "mov %s, %s", regname, regval);
        add_to_list(&ctx->text, set_arg);
    }

    char *code = malloc(128);
    sprintf(code, "call %s", call->func_name);
    add_to_list(&ctx->text, code);

    return NULL;
}

parser_node *parse_func_call(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;

    if (tkn->type_id == TKN_ID)
    {
        typed_token *name_tkn = tkn;
        tkn = tkn->next;
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

                    call->func_name = malloc(128);
                    strcpy(call->func_name, (char *)name_tkn->data);
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
    }

    return NULL;
}

parser_node *parse_terminal(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;

    parser_node *curr = NULL;

    if (tkn->type_id == TKN_L_PAREN)
    {
        tkn = tkn->next;
        curr = parse_expr(&tkn);
        if (curr)
        {
            if (tkn->type_id == TKN_R_PAREN)
            {
                tkn = tkn->next;
                *tkns_ptr = tkn;
                return curr;
            }
        }
        else
        {
            return NULL;
        }
    }

    if (!curr)
    {
        curr = parse_literal(&tkn);
    }

    if (!curr)
    {
        curr = parse_assign(&tkn);
    }

    if (!curr)
    {
        curr = parse_func_call(&tkn);
    }

    if (curr)
    {
        *tkns_ptr = tkn;
    }

    return curr;
}

parser_node *parse_expr(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;

    parser_node *curr = parse_terminal(&tkn);

    if (curr)
    {
        while (1)
        {
            if (tkn->type_id == TKN_PLUS || tkn->type_id == TKN_STAR)
            {
                int op_type_id = tkn->type_id;
                tkn = tkn->next;
                parser_node *right = parse_terminal(&tkn);
                if (right)
                {
                    parser_node *node = (parser_node *)malloc(sizeof(parser_node));
                    node->data = (void *)malloc(sizeof(node_binary_op));
                    node->debug = binary_op_debug;
                    node_binary_op *binop = (node_binary_op *)node->data;
                    binop->left = curr;
                    binop->right = right;
                    binop->op = op_type_id;

                    curr = node;
                }
                else
                {
                    return NULL;
                }
            }
            else
            {
                *tkns_ptr = tkn;
                return curr;
            }
        }
    }

    return NULL;
}