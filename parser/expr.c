
#include <stdlib.h>

#include "../lexer.h"
#include "parser.h"
#include "expr.h"
#include "literal.h"
#include "assign.h"
#include "../codegen/codegen.h"

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

void var_debug(int depth, parser_node *node)
{
    node_var *var = (node_var *)node->data;
    printtabs(depth);
    printf("Variable(%s)\n", var->var_name);
}

char *var_apply(parser_node *node, context *ctx)
{
    node_var *var = (node_var *)node->data;
    symbol *sym = find_symbol(ctx, var->var_name);
    if (!sym)
    {
        printf("ERROR!");
    }
    else
    {
        return asprintf("[rsp + %u]", sym->offset);
    }
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

    char **argvals = (char **)malloc(sizeof(char *) * 6);
    for (int i = 0; i < call->num_args; i++)
    {
        char *regval = call->args[i]->apply(call->args[i], ctx);

        symbol *tmp = new_temp_symbol(ctx, 8);

        char *regname = asprintf("[rsp + %u]", tmp->offset);

        add_text(ctx, "mov rax, %s", regval);
        add_text(ctx, "mov %s, rax", regname);

        argvals[i] = regname;
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
            printf("More than 6 args!");
            exit(0);
        }
        add_text(ctx, "mov %s, %s", regname, argvals[i]);
    }

    add_text(ctx, "call %s", call->func_name);
    symbol *tmp = new_temp_symbol(ctx, 8);
    add_text(ctx, "mov [rsp + %u], rax", tmp->offset);

    return asprintf("[rsp + %u]", tmp->offset);
}

void ref_debug(int depth, parser_node *node)
{
    node_ref *ref = (node_ref *)node->data;
    printtabs(depth);
    printf("Ref:\n");
    ref->var->debug(depth + 1, ref->var);
}

char *ref_apply(parser_node *node, context *ctx)
{
    node_ref *ref = (node_ref *)node->data;
    if (ref->var->apply == var_apply)
    {
        node_var *v = (node_var *)ref->var->data;
        symbol *sym = find_symbol(ctx, v->var_name);
        if (sym)
        {
            add_text(ctx, "mov rax, rsp");
            add_text(ctx, "add rax, %u", sym->offset);

            return "rax";
        }
        else
        {
            printf("Invalid & (Var not found)\n");
            exit(1);
        }
    }
    else
    {
        printf("Invalid &\n");
        exit(1);
    }
}

void deref_debug(int depth, parser_node *node)
{
    node_deref *ref = (node_deref *)node->data;
    printtabs(depth);
    printf("Deref:\n");
    ref->var->debug(depth + 1, ref->var);
}

char *deref_apply(parser_node *node, context *ctx)
{
    node_deref *deref = (node_deref *)node->data;

    char *loc = deref->var->apply(deref->var, ctx);

    add_text(ctx, "mov rax, %s", loc);
    add_text(ctx, "mov rax, [rax]");

    return "rax";
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

    if (!curr)
    {

        if (tkn->type_id == TKN_ID)
        {
            char *varname = malloc(128);
            strcpy(varname, tkn->data);
            tkn = tkn->next;

            parser_node *node = (parser_node *)malloc(sizeof(parser_node));
            node->data = (void *)malloc(sizeof(node_var));
            node->debug = var_debug;
            node->apply = var_apply;
            node_var *var = (node_var *)node->data;
            var->var_name = varname;

            curr = node;
        }
    }

    if (!curr)
    {
        if (tkn->type_id == TKN_AMP)
        {
            tkn = tkn->next;
            parser_node *n = parse_terminal(&tkn);
            if (n)
            {
                parser_node *node = (parser_node *)malloc(sizeof(parser_node));
                node->data = (void *)malloc(sizeof(node_ref));
                node->debug = ref_debug;
                node->apply = ref_apply;
                node_ref *ref = (node_ref *)node->data;
                ref->var = n;

                curr = node;
            }
            else
            {
                return NULL;
            }
        }
    }

    if (!curr)
    {
        if (tkn->type_id == TKN_STAR)
        {
            tkn = tkn->next;
            parser_node *n = parse_terminal(&tkn);
            if (n)
            {
                parser_node *node = (parser_node *)malloc(sizeof(parser_node));
                node->data = (void *)malloc(sizeof(node_deref));
                node->debug = deref_debug;
                node->apply = deref_apply;
                node_deref *ref = (node_deref *)node->data;
                ref->var = n;

                curr = node;
            }
            else
            {
                return NULL;
            }
        }
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