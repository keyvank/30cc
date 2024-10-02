
#include <stdlib.h>

#include "../lexer.h"
#include "parser.h"
#include "func.h"
#include "param.h"
#include "type.h"
#include "statement.h"

void func_def_debug(int depth, parser_node *node)
{
    node_func_def *func = (node_func_def *)node->data;
    printtabs(depth);
    printf("Function(\n");
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
    printtabs(depth + 1);
    printf("Statements:\n");
    for (int i = 0; i < func->num_statements; i++)
    {
        parser_node *node = func->statements[i];
        node->debug(depth + 2, node);
    }
    printtabs(depth);
    printf(")\n");
}

void func_decl_debug(int depth, parser_node *node)
{
    node_func_def *func = (node_func_def *)node->data;
    printtabs(depth);
    printf("FunctionDecl(\n");
    printtabs(depth + 1);
    printf("Name:\n");
    printtabs(depth + 2);
    printf("%s\n", func->identity);
    printtabs(depth + 1);
    printf("Returns:\n");
    func->return_type->debug(depth + 2, func->return_type);

    printtabs(depth + 1);
    printf("ParamTypes:\n");
    for (int i = 0; i < func->num_params; i++)
    {
        parser_node *node = func->params[i];
        node->debug(depth + 2, node);
    }
    printtabs(depth);
    printf(")\n");
}

parser_node *parse_function(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    parser_node *return_type = parse_type(&tkn);
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
                    if (tkn->type_id == TKN_R_PAREN)
                    {
                        tkn = tkn->next;
                        break;
                    }
                    parser_node *p = parse_param(&tkn);
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
                    node->data = (void *)malloc(sizeof(node_func_decl));
                    node->debug = func_decl_debug;
                    node_func_decl *decl = (node_func_decl *)node->data;

                    decl->identity = malloc(128);
                    strcpy(decl->identity, (char *)name_tkn->data);
                    decl->return_type = return_type;
                    decl->num_params = params_count;
                    decl->param_types = (parser_node **)malloc(sizeof(parser_node *) * 32);
                    for (int i = 0; i < params_count; i++)
                    {
                        decl->param_types[i] = ((node_param *)params[i]->data)->type;
                    }
                    return node;
                }
                if (tkn->type_id != TKN_L_BRACE)
                {
                    return NULL;
                }
                for (int i = 0; i < params_count; i++)
                {
                    if (((node_param *)params[i]->data)->identity == NULL)
                    {
                        return NULL;
                    }
                }
                tkn = tkn->next;

                int stmt_count = 0;
                parser_node **stmts = (parser_node **)malloc(sizeof(parser_node *) * 128); // MAX 128 STATEMENTS
                for (int i = 0; i < 128; i++)
                    stmts[i] = NULL;

                while (tkn)
                {
                    if (tkn->type_id == TKN_R_BRACE)
                    {
                        tkn = tkn->next;
                        *tkns_ptr = tkn;

                        parser_node *node = (parser_node *)malloc(sizeof(parser_node));
                        node->data = (void *)malloc(sizeof(node_func_def));
                        node->debug = func_def_debug;
                        node_func_def *func = (node_func_def *)node->data;

                        func->identity = malloc(128);
                        strcpy(func->identity, (char *)name_tkn->data);
                        func->return_type = return_type;
                        func->num_params = params_count;
                        func->params = params;
                        func->num_statements = stmt_count;
                        func->statements = stmts;

                        return node;
                    }
                    else
                    {
                        parser_node *stmt = parse_statement(&tkn);
                        if (stmt)
                        {
                            stmts[stmt_count++] = stmt;
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