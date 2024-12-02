
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../vec.h"
#include "../lexer.h"
#include "parser.h"
#include "func.h"
#include "type.h"
#include "statement.h"
#include "../codegen/codegen.h"

apply_result *func_def_apply(parser_node *node, context *ctx)
{
    node_func_def *func = (node_func_def *)node->data;

    if (!func->statements)
    {
        add_text(ctx, "extern %s", func->identity);
        return NULL;
    }
    else
    {
        char *extern_txt = cc_asprintf("extern %s", func->identity);
        char *cmt_extern_txt = cc_asprintf(";extern %s", func->identity);
        replace_text(ctx, extern_txt, cmt_extern_txt);
    }

    add_text(ctx, "global %s", func->identity);
    add_text(ctx, "%s:", func->identity);
    add_text(ctx, "push rbp");
    add_text(ctx, "mov rbp, rsp");
    add_text(ctx, "sub rsp, __%s_size", func->identity);

    for (int i = 0; i < func->num_params; i++)
    {
        node_type *par = (node_type *)func->params[i]->data;

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
            fprintf(stderr, "Cannot define a function with more than 6 args!");
            exit(1);
        }
        regname = reg_typed(regname, par->type, ctx);

        symbol *sym = new_symbol(ctx, par->name, par->type);
        add_text(ctx, "mov %s, %s", sym->repl, regname);
    }

    for (int i = 0; i < func->statements->total; i++)
    {
        parser_node *node = (parser_node *)get_vec(func->statements, i);
        node->apply(node, ctx);
    }

    add_text(ctx, "mov rsp, rbp");
    add_text(ctx, "pop rbp");
    add_text(ctx, "ret");
    return NULL;
}

void func_def_debug(int depth, parser_node *node)
{
    node_func_def *func = (node_func_def *)node->data;
    printtabs(depth);
    if (func->statements)
    {
        printf("Function(\n");
    }
    else
    {
        printf("FunctionDecl(\n");
    }
    printtabs(depth + 1);
    printf("Name:\n");
    printtabs(depth + 2);
    printf("%s\n", func->identity);
    printtabs(depth + 1);
    printf("Returns:\n");
    func->return_type->debug(depth + 2, func->return_type);

    printtabs(depth + 1);
    printf("Params:\n");
    for (int i = 0; i < func->num_params; i++)
    {
        parser_node *node = func->params[i];
        node->debug(depth + 2, node);
    }

    if (func->statements)
    {
        printtabs(depth + 1);
        printf("Statements:\n");
        for (int i = 0; i < func->statements->total; i++)
        {
            parser_node *node = (parser_node *)get_vec(func->statements, i);
            node->debug(depth + 2, node);
        }
    }
    printtabs(depth);
    printf(")\n");
}

parser_node *parse_function(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    parser_node *return_type = parse_type(&tkn, 0);
    if (return_type)
    {
        if (tkn->type_id == TKN_ID)
        {
            typed_token *name_tkn = tkn;
            tkn = tkn->next;
            if (tkn->type_id == TKN_L_PAREN)
            {
                int params_count = 0;
                parser_node **params = (parser_node **)malloc(sizeof(parser_node *) * 32); // MAX 32 PARAMS
                for (int i = 0; i < 32; i++)
                    params[i] = NULL;

                tkn = tkn->next;
                while (tkn)
                {
                    if (tkn->type_id == TKN_DOTS)
                    {
                        tkn = tkn->next;
                        if (tkn->type_id == TKN_R_PAREN)
                        {
                            tkn = tkn->next;
                            break;
                        }
                        else
                        {
                            return NULL;
                        }
                    }
                    if (tkn->type_id == TKN_R_PAREN)
                    {
                        tkn = tkn->next;
                        break;
                    }
                    parser_node *p = parse_type(&tkn, 1);
                    if (p)
                    {
                        params[params_count++] = p;
                    }
                    else
                    {
                        return NULL;
                    }
                    if (tkn->type_id == TKN_COMMA)
                    {
                        tkn = tkn->next;
                        continue;
                    }
                    else if (tkn->type_id == TKN_R_PAREN)
                    {
                        tkn = tkn->next;
                        break;
                    }
                    else
                    {
                        return NULL;
                    }
                }
                if (tkn->type_id == TKN_SEMICOLON)
                {
                    tkn = tkn->next;
                    *tkns_ptr = tkn;

                    parser_node *node = (parser_node *)malloc(sizeof(parser_node));
                    node->data = (void *)malloc(sizeof(node_func_def));
                    node->debug = func_def_debug;
                    node->apply = func_def_apply;
                    node_func_def *decl = (node_func_def *)node->data;

                    decl->identity = (char *)name_tkn->data;
                    decl->return_type = return_type;
                    decl->num_params = params_count;
                    decl->params = params;
                    decl->num_statements = 0;
                    decl->statements = NULL;

                    return node;
                }
                if (tkn->type_id != TKN_L_BRACE)
                {
                    return NULL;
                }
                for (int i = 0; i < params_count; i++)
                {
                    if (((node_type *)params[i]->data)->name == NULL)
                    {
                        return NULL;
                    }
                }
                tkn = tkn->next;

                int stmt_count = 0;
                vector *stmts = initialize_vec(sizeof(parser_node *));
                while (tkn)
                {
                    if (tkn->type_id == TKN_R_BRACE)
                    {
                        tkn = tkn->next;
                        *tkns_ptr = tkn;

                        parser_node *node = (parser_node *)malloc(sizeof(parser_node));
                        node->data = (void *)malloc(sizeof(node_func_def));
                        node->debug = func_def_debug;
                        node->apply = func_def_apply;
                        node_func_def *func = (node_func_def *)node->data;

                        func->identity = (char *)name_tkn->data;
                        func->return_type = return_type;
                        func->num_params = params_count;
                        func->params = params;
                        func->statements = stmts;

                        return node;
                    }
                    else
                    {
                        parser_node *stmt = parse_statement(&tkn);
                        if (stmt)
                        {
                            push_vec(stmts, stmt);
                        }
                        else
                        {
                            return NULL;
                        }
                    }
                }
            }
            else
            {
                return NULL;
            }
        }
        else
        {
            return NULL;
        }
    }
    else
    {
        return NULL;
    }

    return NULL;
}
