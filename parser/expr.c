
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
        char *code = malloc(128);
        sprintf(code, "mov rax, %s", left);
        add_to_list(&ctx->text, code);

        code = malloc(128);
        sprintf(code, "mov rbx, %s", right);
        add_to_list(&ctx->text, code);

        switch (binop->op)
        {
        case TKN_PLUS:
            add_to_list(&ctx->text, "add rax, rbx");
            break;
        case TKN_STAR:
            add_to_list(&ctx->text, "mul rbx");
            break;
        default:
            printf("Invalid op!\n");
            exit(1);
        }

        int tmp = new_temp_symbol(ctx);

        code = malloc(128);
        sprintf(code, "mov [rsp + %u], rax", tmp);
        add_to_list(&ctx->text, code);

        code = malloc(128);
        sprintf(code, "[rsp + %u]", tmp);

        return code;
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
    int off = find_symbol(ctx, var->var_name);
    if (off == -1)
    {
        printf("ERROR!");
    }
    else
    {
        char *code = malloc(128);
        sprintf(code, "[rsp + %u]", off);
        return code;
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

        int tmp = new_temp_symbol(ctx);

        char *regname = malloc(128);
        sprintf(regname, "[rsp + %u]", tmp);

        char *code = malloc(128);
        sprintf(code, "mov rax, %s", regval);
        add_to_list(&ctx->text, code);

        code = malloc(128);
        sprintf(code, "mov %s, rax", regname);
        add_to_list(&ctx->text, code);

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
        char *set_arg = malloc(128);
        sprintf(set_arg, "mov %s, %s", regname, argvals[i]);
        add_to_list(&ctx->text, set_arg);
    }

    char *code = malloc(128);
    sprintf(code, "call %s", call->func_name);
    add_to_list(&ctx->text, code);

    return "rax";
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
        int off = find_symbol(ctx, v->var_name);
        if (off != -1)
        {
            add_to_list(&ctx->text, "mov rax, rsp");

            char *code = malloc(128);
            sprintf(code, "add rax, %u", off);
            add_to_list(&ctx->text, code);

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

    char *code = malloc(128);
    sprintf(code, "mov rax, %s", loc);
    add_to_list(&ctx->text, code);

    add_to_list(&ctx->text, "mov rax, [rax]");

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