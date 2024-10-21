
#include <stdio.h>
#include <stdlib.h>

#include "../../lexer.h"
#include "../parser.h"
#include "expr.h"
#include "literal.h"
#include "../../codegen/codegen.h"
#include "var.h"
#include "func_call.h"
#include "ref.h"
#include "deref.h"
#include "index.h"
#include "../type.h"
#include "access.h"

void move_reg_to_var(context *ctx, apply_result *var, char *reg)
{
    if (var->addr_code)
    {
        add_text(ctx, "mov rbx, %s", var->addr_code);
        add_text(ctx, "mov [rbx], %s", reg);
    }
    else
    {
        fprintf(stderr, "Left-hand-side is not assignable!\n");
        exit(1);
    }
}

void postfix_op_debug(int depth, parser_node *node)
{
    node_postfix *postfix = (node_postfix *)node->data;
    printtabs(depth);
    printf("Postfix(Op: %d)\n", postfix->op);
    printtabs(depth);
    printf("expression:\n");
    postfix->exp->debug(depth + 2, postfix->exp);
}

apply_result *postfix_op_apply(parser_node *node, context *ctx) {
    add_text(ctx, "; postfix op apply");
    node_postfix *postfix_op = (node_postfix *)node->data;
    apply_result *operand = postfix_op->exp->apply(postfix_op->exp, ctx);
    add_text(ctx, "mov rax, %s", operand->code);
    symbol *tmp = new_temp_symbol(ctx, operand->type);

    int op = postfix_op->op;

    if (op == TKN_PLUSPLUS) {
        add_text(ctx, "add rax, 1");
    } else if (op == TKN_MINMIN) {
        add_text(ctx, "sub rax, 1");
    } else {
        exit(1);
    }

    add_text(ctx, "mov %s, rax", tmp->repl);
    add_text(ctx, "; postfix op finish");
    return new_result(tmp->repl, tmp->type);
}

void unary_op_debug(int depth, parser_node *node)
{
    node_unary_op *unary_op = (node_unary_op *)node->data;
    printtabs(depth);
    printf("unaryOp(Op: %d)\n", unary_op->op);
    printtabs(depth);
    printf("expression:\n");
    unary_op->exp->debug(depth + 2, unary_op->exp);
}

apply_result *unary_op_apply(parser_node *node, context *ctx) {
    add_text(ctx, "; unary op apply");
    node_unary_op *unary_op = (node_unary_op *)node->data;
    apply_result *operand = unary_op->exp->apply(unary_op->exp, ctx);
    add_text(ctx, "; operand code: %s", operand->code);
    add_text(ctx, "mov rax, %s", operand->code);
    symbol *tmp = new_temp_symbol(ctx, operand->type);

    int op = unary_op->op;

    if (op == TKN_MIN) {
        add_text(ctx, "neg rax");
    } else if (op == TKN_NOT) {   
        add_text(ctx, "cmp rax, 0");
        add_text(ctx, "sete al");
        add_text(ctx, "movzx rax, al");
    } else if (op == TKN_MINMIN) {
        add_text(ctx,"sub rax, 1");
        move_reg_to_var(ctx, operand, "rax");
    } else if (op == TKN_PLUSPLUS) {
        add_text(ctx,"add rax, 1");
        move_reg_to_var(ctx, operand, "rax");
    }


    add_text(ctx, "mov %s, rax", tmp->repl);
    add_text(ctx, "; unary op finish");
    return new_result(tmp->repl, tmp->type);
}

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


apply_result *binary_op_apply(parser_node *node, context *ctx)
{
    node_binary_op *binop = (node_binary_op *)node->data;
    apply_result *left = binop->left->apply(binop->left, ctx);
    apply_result *right = binop->right->apply(binop->right, ctx);

    if (binop->op == TKN_ASSIGN)
    {
        if (!types_equal(left->type, right->type))
        {
            fprintf(stderr, "Cannot assign with an invalid type!\n");
            left->type->debug(left->type, ctx, 0);
            right->type->debug(right->type, ctx, 0);
            exit(1);
        }
    }
    else
    {
        general_type *inttype = new_primitive_type("TKN_INT");
        if (!types_equal(left->type, inttype) || !types_equal(right->type, inttype))
        {
            fprintf(stderr, "Binary-operators only valid for integer types!\n");
            left->type->debug(left->type, ctx, 0);
            right->type->debug(right->type, ctx, 0);
            exit(1);
        }
    }

    add_text(ctx, "mov rax, %s", left->code);
    add_text(ctx, "mov rbx, %s", right->code);

    char *l1 = NULL;
    char *l2 = NULL;

    switch (binop->op)
    {
    case TKN_ASSIGN:
        add_text(ctx, "mov rax, %s", right->code);
        if (left->addr_code)
        {
            add_text(ctx, "mov rbx, %s", left->addr_code);
            add_text(ctx, "mov [rbx], rax");
        }
        else
        {
            fprintf(stderr, "Left-hand-side is not assignable!\n");
            exit(1);
        }
        break;
    case TKN_PLUS:
        add_text(ctx, "add rax, rbx");
        break;
    case TKN_PLUSEQ:
        add_text(ctx, "add rax, rbx");
        move_reg_to_var(ctx, left, "rax");
        break;
    case TKN_MIN:
        add_text(ctx, "sub rax, rbx");
        break;
    case TKN_MINEQ:
        add_text(ctx, "sub rax, rbx");
        move_reg_to_var(ctx, left, "rax");
        break;
    case TKN_STAR:
        // TODO: check sign for mul/imul
        add_text(ctx, "mul rbx");
        break;
    case TKN_STAREQ:
        add_text(ctx, "mul rbx");
        move_reg_to_var(ctx, left, "rax");
        break;
    case TKN_DIV:
        add_text(ctx, "div rbx");
        break;
    case TKN_DIVEQ:
        add_text(ctx, "div rbx");
        move_reg_to_var(ctx, left, "rax");
        break;
    case TKN_MOD:
        add_text(ctx, "move rdx, 0");
        add_text(ctx, "div rbx");
        add_text(ctx, "move rax, rdx");
        break;
    case TKN_AND:
        add_text(ctx, "and rax, rbx");
        break;
    case TKN_OR:
        add_text(ctx, "or rax, rbx");
        break;
    case TKN_ANDAND:
    case TKN_OROR:
        l1 = new_label(ctx);
        l2 = new_label(ctx);
        add_text(ctx, "cmp rax, 0");
        if (binop->op == TKN_ANDAND)
            add_text(ctx, "je %s", l1);
        else
            add_text(ctx, "jne %s", l1);
        add_text(ctx, "mov rax, rbx");
        add_text(ctx, "jmp %s", l2);
        add_text(ctx, "%s:", l1);
        if (binop->op == TKN_ANDAND)
            add_text(ctx, "mov rax, 0");
        else
            add_text(ctx, "mov rax, 1");
        add_text(ctx, "%s:", l2);
        break;
    case TKN_LT:
    case TKN_LTE:
    case TKN_GT:
    case TKN_GTE:
    case TKN_EQ:
    case TKN_NEQ:
        add_to_list(&ctx->text, "cmp rax, rbx");
        l1 = new_label(ctx);
        l2 = new_label(ctx);

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
        fprintf(stderr, "Invalid op '%d'\n", binop->op);
        exit(1);
    }

    symbol *tmp = new_temp_symbol(ctx, left->type);
    add_text(ctx, "mov %s, rax", tmp->repl);
    return new_result(tmp->repl, tmp->type);
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

apply_result *cond_apply(parser_node *node, context *ctx)
{
    node_cond *cond = (node_cond *)node->data;
    apply_result *cond_res = cond->cond->apply(cond->cond, ctx);
    apply_result *yes_val = cond->true_val->apply(cond->true_val, ctx);
    apply_result *no_val = cond->false_val->apply(cond->false_val, ctx);
    char *l1 = new_label(ctx);
    char *l2 = new_label(ctx);
    add_text(ctx, "mov rax, %s", cond_res->code);
    add_text(ctx, "cmp rax, 0");
    add_text(ctx, "je %s", l1);
    add_text(ctx, "mov rax, %s", yes_val->code);
    add_text(ctx, "jmp %s", l2);
    add_text(ctx, "%s:", l1);
    add_text(ctx, "mov rax, %s", no_val->code);
    add_text(ctx, "%s:", l2);
    symbol *sym = new_temp_symbol(ctx, yes_val->type);
    add_text(ctx, "mov %s, rax", sym->repl);
    return new_result(sym->repl, sym->type);
}

void cast_debug(int depth, parser_node *node)
{
    node_cast *cast = (node_cast *)node->data;
    printtabs(depth);
    printf("Cast:\n");
    printtabs(depth + 1);
    printf("Val:\n");
    cast->val->debug(depth + 2, cast->val);
    printtabs(depth + 1);
    printf("Type:\n");
    cast->type->debug(depth + 2, cast->type);
}

apply_result *cast_apply(parser_node *node, context *ctx)
{
    node_cast *cast = (node_cast *)node->data;
    general_type *cast_type = ((node_type *)cast->type->data)->type;
    return new_result(cast->val->apply(cast->val, ctx)->code, cast_type);
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

parser_node *parse_cast(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    if (tkn->type_id == TKN_L_PAREN)
    {
        tkn = tkn->next;
        parser_node *tp = parse_type(&tkn);
        if (tp)
        {
            if (tkn->type_id == TKN_R_PAREN)
            {
                tkn = tkn->next;
                parser_node *val = parse_terminal(&tkn);
                if (val)
                {
                    *tkns_ptr = tkn;
                    parser_node *node = (parser_node *)malloc(sizeof(parser_node));
                    node->data = (void *)malloc(sizeof(node_cast));
                    node->debug = cast_debug;
                    node->apply = cast_apply;
                    node_cast *cast = (node_cast *)node->data;
                    cast->type = tp;
                    cast->val = val;
                    return node;
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

    if (!curr)
        curr = parse_cast(&tkn);
    if (!curr)
        curr = parse_paren(&tkn);
    if (!curr)
        curr = parse_literal(&tkn);
    if (!curr)
        curr = parse_var(&tkn);
    if (!curr)
        curr = parse_ref(&tkn);
    if (!curr)
        curr = parse_deref(&tkn);
    if (!curr)
        curr = parse_unary(&tkn);
    if (curr)
    {
        while (1)
        {
            parser_node *acc = parse_access(&tkn, curr);
            if (acc)
            {
                curr = acc;
                continue;
            }

            parser_node *func_call = parse_func_call(&tkn, curr);
            if (func_call)
            {
                curr = func_call;
                continue;
            }

            parser_node *idx = parse_index(&tkn, curr);
            if (idx)
            {
                curr = idx;
                continue;
            }

            parser_node *postfix = parse_postfix(&tkn, curr);
            if (postfix)
            {   curr = postfix;
                continue;
            }

            break;
        }
    }

    if (curr)
        *tkns_ptr = tkn;

    return curr;
}

int op_prec(int op)
{
    switch (op)
    {
    case TKN_L_BRACK:
    case TKN_L_PAREN:
        return 100;
    case TKN_STAR:
    case TKN_DIV:
    case TKN_MOD:
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
    case TKN_OR:
        return 11;
    case TKN_OROR:
        return 10;
    case TKN_AND:
        return 21;
    case TKN_ANDAND:
        return 20;
    case TKN_PLUSEQ:
    case TKN_MINEQ:
    case TKN_STAREQ:
    case TKN_DIVEQ:
    case TKN_MODEQ:
    case TKN_OREQ:
    case TKN_ANDEQ:
    case TKN_ASSIGN:
        return 5;
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
    return NULL;
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
                while (1)
                {
                    int look_prec = op_prec(tkn->type_id);
                    if (look_prec <= prec) // <= for left assoc and < for right assoc
                    {
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

parser_node *parse_unary(typed_token **tkns_ptr) {
    typed_token *tkn = *tkns_ptr;
    int unary_op = 0;
    int tkn_type = tkn->type_id;
    if (tkn_type == TKN_MIN || tkn_type == TKN_MINMIN || tkn_type == TKN_NOT ||
        tkn_type == TKN_PLUS || tkn_type == TKN_PLUSPLUS) {
      unary_op = tkn->type_id;
      tkn = tkn->next;
    }

    if (!unary_op) {
        return NULL;
    }
    parser_node *unary_expr = parse_terminal(&tkn);
    if (!unary_expr) {
        fprintf(stderr, "Unary expression with no operand");
        return NULL;
    }

    parser_node *node = (parser_node *)malloc(sizeof(parser_node));
    node->data = (void *)malloc(sizeof(node_unary_op));
    node->debug = unary_op_debug;
    node->apply = unary_op_apply;
    node_unary_op *unary = (node_unary_op *)node->data;
    unary->op = unary_op;
    unary->exp = unary_expr;

    *tkns_ptr = tkn;

    return node;
}

parser_node *parse_postfix(typed_token **tkns_ptr, parser_node *curr) {
    typed_token *tkn = *tkns_ptr;
    
    int postfix_unary_op = 0;
    int tkn_type = tkn->type_id;
    if (tkn_type == TKN_MINMIN || tkn_type == TKN_PLUSPLUS) {
      postfix_unary_op = tkn->type_id;
      tkn = tkn->next;
    }
    if (!postfix_unary_op) {
        return NULL;
    }

    parser_node *node = (parser_node *)malloc(sizeof(parser_node));
    node->data = (void *)malloc(sizeof(node_postfix));
    node->debug = postfix_op_debug;
    node->apply = postfix_op_apply;
    node_postfix *postfix_op = (node_postfix *)node->data;
    postfix_op->op = postfix_unary_op;
    postfix_op->exp = curr;

    *tkns_ptr = tkn;

    return node;
}
