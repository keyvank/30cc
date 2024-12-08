#include "../../libc.h"
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

void advance_ptr(context *ctx, apply_result *ptr,
                 apply_result *primitive)
{
    general_type *type = ((node_type *)ptr->type->data)->type;
    int sz = type->size(type, ctx);

    add_text(ctx, "mov rax, %s", primitive->code);
    add_text(ctx, "mov rbx, %u", sz);
    add_text(ctx, "mul rbx");
    add_text(ctx, "mov rbx, rax");
    add_text(ctx, "mov rax, %s", ptr->code);
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

apply_result *postfix_op_apply(parser_node *node, context *ctx)
{
    add_text(ctx, "; postfix op apply");
    node_postfix *postfix_op = (node_postfix *)node->data;
    apply_result *operand = postfix_op->exp->apply(postfix_op->exp, ctx);
    char *rega = reg_a(operand->type, ctx);
    add_text(ctx, "mov %s, %s", rega, operand->code);
    symbol *tmp = new_temp_symbol(ctx, operand->type);
    add_text(ctx, "mov %s, %s", tmp->repl, rega);

    int op = postfix_op->op;

    int unit = 1;
    if (operand->type->kind == TYPE_POINTER)
    {
        general_type *type = ((node_type *)operand->type->data)->type;
        unit = type->size(type, ctx);
    }

    if (op == TKN_PLUSPLUS)
    {
        add_text(ctx, "add %s, %d", rega, unit);
        move_reg_to_var(ctx, operand, rega);
    }
    else if (op == TKN_MINMIN)
    {
        add_text(ctx, "sub %s, %d", rega, unit);
        move_reg_to_var(ctx, operand, rega);
    }
    else
    {
        exit(1);
    }

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

apply_result *unary_op_apply(parser_node *node, context *ctx)
{
    add_text(ctx, "; unary op apply");
    node_unary_op *unary_op = (node_unary_op *)node->data;
    apply_result *operand = unary_op->exp->apply(unary_op->exp, ctx);
    add_text(ctx, "; operand code: %s", operand->code);
    char *rega = reg_a(operand->type, ctx);
    add_text(ctx, "mov %s, %s", rega, operand->code);
    symbol *tmp = new_temp_symbol(ctx, operand->type);

    int op = unary_op->op;

    int unit = 1;
    if (operand->type->kind == TYPE_POINTER)
    {
        general_type *type = ((node_type *)operand->type->data)->type;
        unit = type->size(type, ctx);
    }

    if (op == TKN_MIN)
    {
        add_text(ctx, "neg %s", rega);
    }
    else if (op == TKN_NOT)
    {
        add_text(ctx, "cmp %s, 0", rega);
        add_text(ctx, "sete al");
        add_text(ctx, "movzx rax, al");
    }
    else if (op == TKN_MINMIN)
    {
        add_text(ctx, "sub %s, %d", rega, unit);
        move_reg_to_var(ctx, operand, rega);
    }
    else if (op == TKN_PLUSPLUS)
    {
        add_text(ctx, "add %s, %d", rega, unit);
        move_reg_to_var(ctx, operand, rega);
    }

    add_text(ctx, "mov %s, %s", tmp->repl, rega);
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
    char *rega = reg_a(left->type, ctx);
    char *regb = reg_b(right->type, ctx);

    if (binop->op == TKN_ASSIGN)
    {
        if (!types_equal(left->type, right->type, ctx))
        {
            fprintf(stderr, "Cannot assign with an invalid type!\n");
            left->type->debug(left->type, 0);
            right->type->debug(right->type, 0);
            exit(1);
        }
    }
    else
    {
        if ((left->type->kind != TYPE_PRIMITIVE && left->type->kind != TYPE_POINTER) || (right->type->kind != TYPE_PRIMITIVE && right->type->kind != TYPE_POINTER))
        {
            fprintf(stderr, "Binary-operators only valid for primitive and pointer types!\n");
            left->type->debug(left->type, 0);
            right->type->debug(right->type, 0);
            exit(1);
        }

        if (left->type->kind == TYPE_POINTER && right->type->kind == TYPE_POINTER)
        {
            if (binop->op != TKN_EQ && binop->op != TKN_NEQ)
            {
                fprintf(stderr,
                        "Left-hand-size and Right-hand-side can't be pointers at the same time!\n");
                exit(1);
            }
        }
    }

    // TODO: clag gives warning when comparing int* and int
    if (binop->op != TKN_ASSIGN && binop->op != TKN_EQ && binop->op != TKN_NEQ && binop->op != TKN_ANDAND &&
        (left->type->kind == TYPE_POINTER || right->type->kind == TYPE_POINTER))
    {
        switch (binop->op)
        {
        case TKN_PLUS:
        case TKN_PLUSEQ:
        case TKN_MIN:
        case TKN_MINEQ:
        {
            if (left->type->kind == TYPE_POINTER)
                advance_ptr(ctx, left, right);
            else
                advance_ptr(ctx, right, left);
            break;
        }
        default:
            fprintf(stderr, "Invalid op on pointer '%d'\n", binop->op);
            exit(1);
        }
    }
    else
    {
        add_text(ctx, "mov %s, %s", rega, left->code);
        add_text(ctx, "mov %s, %s", regb, right->code);
    }

    char *l1 = NULL;
    char *l2 = NULL;
    char *l3 = NULL;
    char *l4 = NULL;

    int lsize = left->type->size(left->type, ctx);
    int rsize = right->type->size(right->type, ctx);
    symbol *tmp = right->type->kind == TYPE_POINTER ? new_temp_symbol(ctx, right->type) : new_temp_symbol(ctx, left->type);

    switch (binop->op)
    {
    case TKN_ASSIGN:
        if (left->addr_code)
        {
            add_text(ctx, "mov rax, %s", left->addr_code);
            add_text(ctx, "mov [rax], %s", regb);
            add_text(ctx, "mov %s, %s", rega, regb);
        }
        else
        {
            fprintf(stderr, "Left-hand-side is not assignable!\n");
            exit(1);
        }
        break;
    case TKN_PLUS:
        add_text(ctx, "add %s, %s", rega, regb);
        break;
    case TKN_PLUSEQ:
        add_text(ctx, "add %s, %s", rega, regb);
        move_reg_to_var(ctx, left, rega);
        break;
    case TKN_MIN:
        add_text(ctx, "sub %s, %s", rega, regb);
        break;
    case TKN_MINEQ:
        add_text(ctx, "sub %s, %s", rega, regb);
        move_reg_to_var(ctx, left, rega);
        break;
    case TKN_MOD:
        add_text(ctx, "mov rdx, 0");
        add_text(ctx, "div %s", regb);
        add_text(ctx, "mov %s, %s", rega, reg_typed("rdx", left->type, ctx));
        break;
    case TKN_STAR:
        // TODO: check sign for mul/imul
        add_text(ctx, "mul %s", regb);
        break;
    case TKN_STAREQ:
        add_text(ctx, "mul %s", regb);
        move_reg_to_var(ctx, left, rega);
        break;
    case TKN_ANDAND:
    case TKN_OROR:
        l1 = new_label(ctx);
        l2 = new_label(ctx);
        l3 = new_label(ctx);
        l4 = new_label(ctx);
        add_text(ctx, "cmp %s, 0", rega);
        if (binop->op == TKN_ANDAND)
            add_text(ctx, "je %s", l1);
        else
            add_text(ctx, "jne %s", l1);
        add_text(ctx, "mov %s, %s", rega, regb);
        add_text(ctx, "jmp %s", l2);
        add_text(ctx, "%s:", l1);
        if (binop->op == TKN_ANDAND)
            add_text(ctx, "mov rax, 0");
        else
            add_text(ctx, "mov rax, 1");
        add_text(ctx, "%s:", l2);

        add_text(ctx, "cmp %s, 0", rega);
        add_text(ctx, "jne %s", l3);
        add_text(ctx, "jmp %s", l4);
        add_text(ctx, "%s:", l3);
        add_text(ctx, "mov rax, 1");
        add_text(ctx, "%s:", l4);

        tmp = new_temp_symbol(ctx, new_primitive_type("TKN_INT"));
        break;
    case TKN_LT:
    case TKN_LTE:
    case TKN_GT:
    case TKN_GTE:
    case TKN_EQ:
    case TKN_NEQ:
        add_text(ctx, "cmp %s, %s", rega, regb);
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

        tmp = new_temp_symbol(ctx, new_primitive_type("TKN_INT"));
        break;
    default:
        fprintf(stderr, "Invalid op '%d'\n", binop->op);
        exit(1);
    }

    char *rega_res = reg_a(tmp->type, ctx);
    add_text(ctx, "mov %s, %s", tmp->repl, rega_res);
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
    char *rega_cond = reg_a(cond_res->type, ctx);

    char *l1 = new_label(ctx);
    char *l2 = new_label(ctx);
    add_text(ctx, "mov %s, %s", rega_cond, cond_res->code);
    add_text(ctx, "cmp %s, 0", rega_cond);
    add_text(ctx, "je %s", l1);
    apply_result *yes_val = cond->true_val->apply(cond->true_val, ctx);
    char *rega_val = reg_a(yes_val->type, ctx);
    add_text(ctx, "mov %s, %s", rega_val, yes_val->code);
    add_text(ctx, "jmp %s", l2);
    add_text(ctx, "%s:", l1);
    apply_result *no_val = cond->false_val->apply(cond->false_val, ctx);
    add_text(ctx, "mov %s, %s", rega_val, no_val->code);
    add_text(ctx, "%s:", l2);
    symbol *sym = new_temp_symbol(ctx, yes_val->type);
    add_text(ctx, "mov %s, %s", sym->repl, rega_val);
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
    apply_result *val = cast->val->apply(cast->val, ctx);
    symbol *casted = new_temp_symbol(ctx, cast_type);
    char *rega_casted = reg_a(cast_type, ctx);
    char *rega_val = reg_a(val->type, ctx);
    add_text(ctx, "xor rax, rax");
    add_text(ctx, "mov %s, %s", casted->repl, rega_casted);
    add_text(ctx, "mov %s, %s", rega_val, val->code);
    add_text(ctx, "mov %s, %s", casted->repl, rega_val);
    return new_result(casted->repl, cast_type);
}

void sizeof_debug(int depth, parser_node *node)
{
    node_sizeof *sz = (node_sizeof *)node->data;
    printtabs(depth);
    printf("SizeOf:\n");
    sz->type->debug(depth + 1, sz->type);
}

apply_result *sizeof_apply(parser_node *node, context *ctx)
{
    node_sizeof *size_of = (node_sizeof *)node->data;
    general_type *type = ((node_type *)size_of->type->data)->type;
    int sz = type->size(type, ctx);
    return new_result(cc_asprintf("%u", sz), new_primitive_type("TKN_INT"));
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

parser_node *parse_sizeof(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    if (tkn->type_id == TKN_SIZEOF)
    {
        tkn = tkn->next;
        if (tkn->type_id == TKN_L_PAREN)
        {
            tkn = tkn->next;
            parser_node *type = parse_type(&tkn, 0);
            if (type)
            {
                if (tkn->type_id == TKN_R_PAREN)
                {
                    tkn = tkn->next;
                    *tkns_ptr = tkn;
                    parser_node *node = new_node(sizeof_debug, sizeof_apply, sizeof(node_sizeof));
                    node_sizeof *cast = (node_sizeof *)node->data;
                    cast->type = type;
                    return node;
                }
            }
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
        parser_node *tp = parse_type(&tkn, 0);
        if (tp)
        {
            if (tkn->type_id == TKN_R_PAREN)
            {
                tkn = tkn->next;
                parser_node *val = parse_terminal(&tkn);
                if (val)
                {
                    *tkns_ptr = tkn;
                    parser_node *node = new_node(cast_debug, cast_apply, sizeof(node_cast));
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
        curr = parse_sizeof(&tkn);
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
            {
                curr = postfix;
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
                parser_node *node = new_node(binary_op_debug, binary_op_apply, sizeof(node_binary_op));
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

                    parser_node *node = new_node(cond_debug, cond_apply, sizeof(node_cond));
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

parser_node *parse_unary(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    int unary_op = 0;
    int tkn_type = tkn->type_id;
    if (tkn_type == TKN_MIN || tkn_type == TKN_MINMIN || tkn_type == TKN_NOT ||
        tkn_type == TKN_PLUS || tkn_type == TKN_PLUSPLUS)
    {
        unary_op = tkn->type_id;
        tkn = tkn->next;
    }

    if (!unary_op)
    {
        return NULL;
    }
    parser_node *unary_expr = parse_terminal(&tkn);
    if (!unary_expr)
    {
        fprintf(stderr, "Unary expression with no operand");
        return NULL;
    }

    parser_node *node = new_node(unary_op_debug, unary_op_apply, sizeof(node_unary_op));
    node_unary_op *unary = (node_unary_op *)node->data;
    unary->op = unary_op;
    unary->exp = unary_expr;

    *tkns_ptr = tkn;

    return node;
}

parser_node *parse_postfix(typed_token **tkns_ptr, parser_node *curr)
{
    typed_token *tkn = *tkns_ptr;

    int postfix_unary_op = 0;
    int tkn_type = tkn->type_id;
    if (tkn_type == TKN_MINMIN || tkn_type == TKN_PLUSPLUS)
    {
        postfix_unary_op = tkn->type_id;
        tkn = tkn->next;
    }
    if (!postfix_unary_op)
    {
        return NULL;
    }

    parser_node *node = new_node(postfix_op_debug, postfix_op_apply, sizeof(node_postfix));
    node_postfix *postfix_op = (node_postfix *)node->data;
    postfix_op->op = postfix_unary_op;
    postfix_op->exp = curr;

    *tkns_ptr = tkn;

    return node;
}
