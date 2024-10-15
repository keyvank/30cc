

#include <stdlib.h>
#include <string.h>

#include "../lexer.h"
#include "parser.h"
#include "type.h"

void type_debug(int depth, parser_node *node)
{
    node_type *tp = (node_type *)node->data;
    printtabs(depth);
    printf("Type(%s", tp->name);
    for (int i = 0; i < tp->num_pointing; i++)
    {
        printf("*");
    }
    for (int i = 0; i < tp->dim; i++)
    {
        printf("[%u]", tp->dims[i]);
    }
    printf(")");
    if (tp->is_struct == 1) {
        printf("struct");
    }
    printf("\n");
}

void func_type_debug(int depth, parser_node *node)
{
    node_func_type *ft = (node_func_type *)node->data;
    printtabs(depth);
    printf("FuncType:\n");
    printtabs(depth + 1);
    printf("Arg Types:\n");
    for (int i = 0; i < ft->num_args; i++)
    {
        ft->arg_types[i]->debug(depth + 2, ft->arg_types[i]);
    }
    printtabs(depth + 1);
    printf("Return Type:\n");
    ft->ret_type->debug(depth + 2, ft->ret_type);
}

parser_node *parse_simp_type(typed_token **tkns_ptr);

parser_node *parse_type(typed_token **tkns_ptr)
{ 
    typed_token *tkn = *tkns_ptr;
    parser_node *ret_type = parse_simp_type(&tkn);
    if (ret_type)
    {
        if (tkn->type_id == TKN_L_PAREN)
        {
            tkn = tkn->next;
            if (tkn->type_id == TKN_STAR)
            {
                int ptr_cnt = 1;
                tkn = tkn->next;
                while (tkn->type_id == TKN_STAR)
                {
                    tkn = tkn->next;
                    ptr_cnt += 1;
                }
                if (tkn->type_id == TKN_ID)
                {
                    tkn = tkn->next;
                }
                if (tkn->type_id == TKN_R_PAREN)
                {
                    tkn = tkn->next;
                    if (tkn->type_id == TKN_L_PAREN)
                    {
                        tkn = tkn->next;
                        int num_args = 0;
                        parser_node **arg_types = (parser_node **)malloc(sizeof(parser_node *) * 32);
                        while (tkn)
                        {
                            if (tkn->type_id == TKN_R_PAREN)
                            {
                                tkn = tkn->next;
                                *tkns_ptr = tkn;
                                parser_node *node = (parser_node *)malloc(sizeof(parser_node));
                                node->data = (void *)malloc(sizeof(node_func_type));
                                node->debug = func_type_debug;
                                node_func_type *ft = (node_func_type *)node->data;
                                ft->ret_type = ret_type;
                                ft->num_args = num_args;
                                ft->arg_types = arg_types;
                                return node;
                            }
                            else
                            {
                                parser_node *param = parse_type(&tkn);
                                if (param)
                                {
                                    arg_types[num_args++] = param;

                                    if(tkn->type_id == TKN_ID) {
                                        tkn =tkn->next;
                                    }

                                    if (tkn->type_id == TKN_COMMA)
                                    {
                                        tkn = tkn->next;
                                        continue;
                                    }
                                    if (tkn->type_id != TKN_R_PAREN)
                                    {
                                        return NULL;
                                    }
                                }
                                else
                                {
                                    return NULL;
                                }
                            }
                        }
                    }
                }
            }
        }
        else
        {
            *tkns_ptr = tkn;
            return ret_type;
        }
    }
    return NULL;
}

parser_node *parse_simp_type(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    parser_node *node = NULL;
    if (tkn->type_id == TKN_INT || tkn->type_id == TKN_VOID || tkn->type_id == TKN_CHAR)
    {
        typed_token *ret_type_tkn = tkn;
        tkn = tkn->next;
        node = (parser_node *)malloc(sizeof(parser_node));
        node->data = (void *)malloc(sizeof(node_type));
        node->debug = type_debug;
        node_type *par = (node_type *)node->data;
        par->name = ret_type_tkn->data;
    } else if (tkn->type_id == TKN_LIT_STRUCT) 
    {
        tkn = tkn->next;
        typed_token *struct_name_tkn = tkn;
        // TODO: maybe error?
        if (struct_name_tkn == NULL) {
            return NULL;
        }
        node = (parser_node *)malloc(sizeof(parser_node));
        node->data = (void *)malloc(sizeof(node_type));
        node->debug = type_debug;
        node_type *par = (node_type *)node->data;
        if (tkn->next == NULL) {
            // After name there must be either { or the variable name
            return NULL;
        }
        // This is a struct definition not variable
        if (tkn->next->type_id == TKN_L_BRACE) {
            return NULL;
        }
        par->name = malloc(128);
        par->is_struct = 1;
        strcpy(par->name, struct_name_tkn->data);
        tkn = struct_name_tkn->next;
    }
    
    if (node != NULL) {
        int num_pointing = 0;
        while (tkn->type_id == TKN_STAR)
        {
            tkn = tkn->next;
            num_pointing++;
        }
        node_type *par = (node_type *)node->data;
        par->num_pointing = num_pointing;
        par->dim = 0;
        par->dims = NULL;
        *tkns_ptr = tkn;
    }
    return node;
}
