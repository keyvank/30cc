
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
    case TKN_ANDAND:
    case TKN_OROR:
        char *ll1 = new_label(ctx);
        char *ll2 = new_label(ctx);
        add_text(ctx, "cmp rax, 0");
        if (binop->op == TKN_ANDAND)
            add_text(ctx, "je %s", ll1);
        else
            add_text(ctx, "jne %s", ll1);
        add_text(ctx, "mov rax, rbx");
        add_text(ctx, "jmp %s", ll2);
        add_text(ctx, "%s:", ll1);
        if (binop->op == TKN_ANDAND)
            add_text(ctx, "mov rax, 0");
        else
            add_text(ctx, "mov rax, 1");
        add_text(ctx, "%s:", ll2);
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

void cond_debug(int depth, parser_node *node)
{
    node_cond *cond = (node_cond *)node->data;
    printtabs(depth);
    printf("CondExpr:\n");
    printtabs(depth + 1);
    printf("Cond:\n");
    cond->cond->debug(depth + 2, cond->cond);
    printtabs(depth + 1);
    printf("Yes:\n");
    cond->true_val->debug(depth + 2, cond->true_val);
    printtabs(depth + 1);
    printf("No:\n");
    cond->false_val->debug(depth + 2, cond->false_val);
}

char *cond_apply(parser_node *node, context *ctx)
{
    node_cond *cond = (node_cond *)node->data;
    char *cond_res = cond->cond->apply(cond->cond, ctx);
    char *yes_val = cond->true_val->apply(cond->true_val, ctx);
    char *no_val = cond->false_val->apply(cond->false_val, ctx);
    char *l1 = new_label(ctx);
    char *l2 = new_label(ctx);
    add_text(ctx, "mov rax, %s", cond_res);
    add_text(ctx, "cmp rax, 0");
    add_text(ctx, "je %s", l1);
    add_text(ctx, "mov rax, %s", yes_val);
    add_text(ctx, "jmp %s", l2);
    add_text(ctx, "%s:", l1);
    add_text(ctx, "mov rax, %s", no_val);
    add_text(ctx, "%s:", l2);
    symbol *sym = new_temp_symbol(ctx, 8);
    add_text(ctx, "mov [rsp+%u], rax", sym->offset);
    return asprintf("[rsp+%u]", sym->offset);
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

int op_prec(int op)
{
    switch (op)
    {
    case TKN_STAR:
        return 50;
    case TKN_PLUS:
    case TKN_MIN:
        return 40;
    case TKN_LT:
    case TKN_GT:
    case TKN_LTE:
    case TKN_GTE:
    case TKN_EQ:
    case TKN_NEQ:
        return 30;
    case TKN_OROR:
        return 20;
    case TKN_ANDAND:
        return 10;
    default:
        return 0;
    }
}

parser_node *parse_expr_prec(typed_token **tkns_ptr, parser_node *lhs, int min_prec);

parser_node *parse_expr(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    parser_node *lhs = parse_terminal(&tkn);
    if (lhs)
    {
        parser_node *res = parse_expr_prec(&tkn, lhs, 1);
        if (res)
        {
            *tkns_ptr = tkn;
            return res;
        }
    }
    else
    {
        return NULL;
    }
}

parser_node *parse_expr_prec(typed_token **tkns_ptr, parser_node *lhs, int min_prec)
{
    typed_token *tkn = *tkns_ptr;

    while (1)
    {
        int prec = op_prec(tkn->type_id);
        if (prec >= min_prec)
        {
            int op_type_id = tkn->type_id;
            tkn = tkn->next;
            parser_node *rhs = parse_terminal(&tkn);
            if (rhs)
            {
                while(1) {
                    int look_prec = op_prec(tkn->type_id);
                    if(look_prec < prec) {
                        break;
                    }
                    rhs = parse_expr_prec(&tkn, rhs, look_prec);
                }
                parser_node *node = (parser_node *)malloc(sizeof(parser_node));
                node->data = (void *)malloc(sizeof(node_binary_op));
                node->debug = binary_op_debug;
                node->apply = binary_op_apply;
                node_binary_op *binop = (node_binary_op *)node->data;
                binop->left = lhs;
                binop->right = rhs;
                binop->op = op_type_id;

                lhs = node;
            }
            else
            {
                return NULL;
            }
        }
        else if (tkn->type_id == TKN_QUEST)
        {
            tkn = tkn->next;
            parser_node *yes = parse_expr(&tkn);
            if (yes && tkn->type_id == TKN_COLON)
            {
                tkn = tkn->next;
                parser_node *no = parse_expr(&tkn);
                if (no)
                {

                    parser_node *node = (parser_node *)malloc(sizeof(parser_node));
                    node->data = (void *)malloc(sizeof(node_cond));
                    node->debug = cond_debug;
                    node->apply = cond_apply;
                    node_cond *binop = (node_cond *)node->data;
                    binop->cond = lhs;
                    binop->true_val = yes;
                    binop->false_val = no;

                    *tkns_ptr = tkn;
                    return node;
                }
            }
        }
        else
        {
            *tkns_ptr = tkn;
            return lhs;
        }
    }

    return NULL;
}