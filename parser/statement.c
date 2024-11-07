
#include <stdlib.h>

#include "../lexer.h"
#include "break.h"
#include "parser.h"
#include "statement.h"
#include "var_decl.h"
#include "expr/expr.h"
#include "for.h"
#include "if.h"
#include "while.h"
#include "goto.h"

apply_result *compound_statement_apply(parser_node *node, context *ctx)
{
    node_compound_statement *comp = (node_compound_statement *)node->data;
    int num_syms = ctx->symbol_table->count;
    for (int i = 0; i < comp->num_statements; i++)
    {
        comp->statements[i]->apply(comp->statements[i], ctx);
    }
    while(ctx->symbol_table->count > num_syms) {
        pop_list(ctx->symbol_table);
    }
    return NULL;
}

void compound_statement_debug(int depth, parser_node *node)
{
    node_compound_statement *comp = (node_compound_statement *)node->data;
    printtabs(depth);
    printf("CompoundStatement\n");
    for (int i = 0; i < comp->num_statements; i++)
    {
        comp->statements[i]->debug(depth + 1, comp->statements[i]);
    }
}

apply_result *return_apply(parser_node *node, context *ctx)
{
    node_return *func = (node_return *)node->data;

    if (func->exp)
    {
        apply_result *val = func->exp->apply(func->exp, ctx);
        add_text(ctx, "mov rax, %s", val->code);
    }

    add_text(ctx, "mov rsp, rbp");
    add_text(ctx, "pop rbp");
    add_text(ctx, "ret");
    return NULL;
}

void return_debug(int depth, parser_node *node)
{
    node_return *ret = (node_return *)node->data;
    printtabs(depth);
    printf("Return:\n");
    if (ret->exp != NULL)
    {
        ret->exp->debug(depth + 1, ret->exp);
    }
    else
    {
        printtabs(depth + 1);
        printf("VOID\n");
    }
}

parser_node *parse_return(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;

    if (tkn->type_id == TKN_RETURN)
    {
        tkn = tkn->next;

        if (tkn->type_id == TKN_SEMICOLON)
        {
            tkn = tkn->next;
            *tkns_ptr = tkn;
            parser_node *node = (parser_node *)malloc(sizeof(parser_node));
            node->data = (void *)malloc(sizeof(node_return));
            node->debug = return_debug;
            node->apply = return_apply;
            node_return *ret = (node_return *)node->data;
            ret->exp = NULL;

            return node;
        }
        else
        {
            parser_node *exp = parse_expr(&tkn);
            if (exp)
            {
                if (tkn->type_id == TKN_SEMICOLON)
                {
                    tkn = tkn->next;
                    *tkns_ptr = tkn;

                    parser_node *node = (parser_node *)malloc(sizeof(parser_node));
                    node->data = (void *)malloc(sizeof(node_return));
                    node->debug = return_debug;
                    node->apply = return_apply;
                    node_return *ret = (node_return *)node->data;
                    ret->exp = exp;

                    return node;
                }
            }
        }
    }

    return NULL;
}

parser_node *parse_compound_statement(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;

    if (tkn->type_id == TKN_L_BRACE)
    {
        int num_stmts = 0;
        parser_node **stmts = (parser_node **)malloc(sizeof(parser_node *) * 128);
        for (int i = 0; i < 128; i++)
            stmts[i] = NULL;
        tkn = tkn->next;
        while (tkn)
        {
            if (tkn->type_id == TKN_R_BRACE)
            {
                tkn = tkn->next;
                *tkns_ptr = tkn;

                parser_node *node = (parser_node *)malloc(sizeof(parser_node));
                node->data = (void *)malloc(sizeof(node_compound_statement));
                node->debug = compound_statement_debug;
                node->apply = compound_statement_apply;
                node_compound_statement *comp = (node_compound_statement *)node->data;
                comp->num_statements = num_stmts;
                comp->statements = stmts;

                return node;
            }
            parser_node *stmt = parse_statement(&tkn);
            if (stmt)
            {
                stmts[num_stmts++] = stmt;
            }
            else
            {
                return NULL;
            }
        }
    }

    return NULL;
}

parser_node *parse_statement(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    parser_node *ret = NULL;
    ret = parse_var_decl(&tkn);
    if (ret)
    {
        *tkns_ptr = tkn;
        return ret;
    }

    ret = parse_break(&tkn);
    if (ret) {
        *tkns_ptr = tkn;
        return ret;
    }

    ret = parse_continue(&tkn);
    if (ret) {
        *tkns_ptr = tkn;
        return ret;
    }

    ret = parse_compound_statement(&tkn);
    if (ret)
    {
        *tkns_ptr = tkn;
        return ret;
    }

    ret = parse_for(&tkn);
    if (ret)
    {
        *tkns_ptr = tkn;
        return ret;
    }

    ret = parse_while(&tkn);
    if (ret)
    {
        *tkns_ptr = tkn;
        return ret;
    }

    ret = parse_if(&tkn);
    if (ret)
    {
        *tkns_ptr = tkn;
        return ret;
    }

    ret = parse_return(&tkn);
    if (ret)
    {
        *tkns_ptr = tkn;
        return ret;
    }

    ret = parse_label(&tkn);
    if (ret)
    {
        *tkns_ptr = tkn;
        return ret;
    }

    ret = parse_goto(&tkn);
    if (ret)
    {
        *tkns_ptr = tkn;
        return ret;
    }

    ret = parse_expr(&tkn);
    if (ret)
    {
        if (tkn->type_id == TKN_SEMICOLON)
        {
            tkn = tkn->next;
            *tkns_ptr = tkn;
            return ret;
        }
        else
        {
            return NULL;
        }
    }

    return NULL;
}
