
#include <stdlib.h>

#include "../lexer.h"
#include "parser.h"
#include "var_decl.h"
#include "type.h"

void var_decl_debug(int depth, parser_node *node)
{
    node_var_decl *decl = (node_var_decl *)node->data;
    printtabs(depth);
    printf("VarDecl(%s):\n", decl->identity);
    decl->type->debug(depth + 1, decl->type);
    if (decl->value)
    {
        printtabs(depth + 1);
        printf("Init value: %s\n", decl->value);
    }
}

parser_node *parse_var_decl(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    parser_node *tp = parse_type(&tkn);
    if (tp)
    {
        tkn = tkn->next;
        if (tkn->type_id == TKN_ID)
        {
            typed_token *name_tkn = tkn;
            tkn = tkn->next;
            *tkns_ptr = tkn;

            typed_token *val_tkn = NULL;

            if (tkn->type_id == TKN_SEMICOLON)
            {
                val_tkn = NULL;
                tkn = tkn->next;
            }
            else if (tkn->type_id == TKN_ASSIGN)
            {
                tkn = tkn->next;
                // parse_expr() instead
                if (tkn->type_id == TKN_STR)
                {
                    val_tkn = tkn;
                    tkn = tkn->next;
                    if (tkn->type_id == TKN_SEMICOLON)
                    {
                        tkn = tkn->next;
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

            *tkns_ptr = tkn;
            parser_node *node = (parser_node *)malloc(sizeof(parser_node));
            node->type = NODE_VAR_DECL;
            node->data = (void *)malloc(sizeof(node_var_decl));
            node->debug = var_decl_debug;
            node_var_decl *decl = (node_var_decl *)node->data;
            decl->type = tp;
            decl->identity = malloc(128);
            strcpy(decl->identity, name_tkn->data);
            if (val_tkn)
            {
                decl->value = malloc(128);
                strcpy(decl->value, val_tkn->data);
            }
            return node;
        }
    }

    return NULL;
}