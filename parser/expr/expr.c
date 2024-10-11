
#include <stdlib.h>

#include "../../lexer.h"
#include "../parser.h"
#include "expr.h"
#include "literal.h"
#include "assign.h"
#include "../../codegen/codegen.h"
#include "var.h"
#include "func_call.h"
#include "ref.h"
#include "deref.h"

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

char *binary_op_apply(parser_node *node, context *ctx)
{
    node_binary_op *binop = (node_binary_op *)node->data;
    char *left = binop->left->apply(binop->left, ctx);
    char *right = binop->right->apply(binop->right, ctx);
    if (left != -1 && right != -1)
    {
        add_text(ctx, "mov rax, %s", left);
        add_text(ctx, "mov rbx, %s", right);

        switch (binop->op)
        {
        case TKN_PLUS:
            add_text(ctx, "add rax, rbx");
            break;
        case TKN_MIN:
            add_text(ctx, "sub rax, rbx");
            break;
        case TKN_STAR:
            add_text(ctx, "mul rbx");
            break;
        case TKN_LT:
        case TKN_LTE:
        case TKN_GT:
        case TKN_GTE:
        case TKN_EQ:
        case TKN_NEQ:
            add_to_list(&ctx->text, "cmp rax, rbx");
            char *l1 = new_label(ctx);
            char *l2 = new_label(ctx);

            char *op = NULL;
            if (binop->op == TKN_LT)
                op = "jl";
            else if (binop->op == TKN_LTE)
                op = "jle";
            else if (binop->op == TKN_GT)
                op = "jg";
            else if (binop->op == TKN_GTE)
                op = "jge";
            else if (binop->op == TKN_EQ)
                op = "je";
            else if (binop->op == TKN_NEQ)
                op = "jne";

            add_text(ctx, "%s %s", op, l1);
            add_text(ctx, "mov rax, 0");
            add_text(ctx, "jmp %s", l2);
            add_text(ctx, "%s:", l1);
            add_text(ctx, "mov rax, 1");
            add_text(ctx, "%s:", l2);
            break;
        default:
            printf("Invalid op!\n");
            exit(1);
        }

        symbol *tmp = new_temp_symbol(ctx, 8);

        add_text(ctx, "mov [rsp + %u], rax", tmp->offset);
        return asprintf("[rsp + %u]", tmp->offset);
    }
    else
    {
        printf("ERROR!");
        exit(1);
    }
}

parser_node *parse_paren(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;

    if (tkn->type_id == TKN_L_PAREN)
    {
        tkn = tkn->next;
        parser_node *inner = parse_expr(&tkn);
        if (inner)
        {
            if (tkn->type_id == TKN_R_PAREN)
            {
                tkn = tkn->next;
                *tkns_ptr = tkn;
                return inner;
            }
        }
        else
        {
            return NULL;
        }
    }

    return NULL;
}

parser_node *parse_terminal(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;

    parser_node *curr = NULL;

    if (!curr)
        curr = parse_paren(&tkn);
    if (!curr)
        curr = parse_literal(&tkn);
    if (!curr)
        curr = parse_assign(&tkn);
    if (!curr)
        curr = parse_func_call(&tkn);
    if (!curr)
        curr = parse_var(&tkn);
    if (!curr)
        curr = parse_ref(&tkn);
    if (!curr)
        curr = parse_deref(&tkn);
    if (curr)
        *tkns_ptr = tkn;

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
            if (tkn->type_id == TKN_PLUS || tkn->type_id == TKN_STAR || tkn->type_id == TKN_MIN || tkn->type_id == TKN_LT || tkn->type_id == TKN_GT || tkn->type_id == TKN_LTE || tkn->type_id == TKN_GTE || tkn->type_id == TKN_EQ || tkn->type_id == TKN_NEQ)
            {
                int op_type_id = tkn->type_id;
                tkn = tkn->next;
                parser_node *right = parse_terminal(&tkn);
                if (right)
                {
                    parser_node *node = (parser_node *)malloc(sizeof(parser_node));
                    node->data = (void *)malloc(sizeof(node_binary_op));
                    node->debug = binary_op_debug;
                    node->apply = binary_op_apply;
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