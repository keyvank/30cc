
#include <stdlib.h>

#include "../lexer.h"
#include "parser.h"
#include "var_decl.h"
#include "type.h"
#include "expr.h"
#include "../codegen/codegen.h"
#include "../linked_list.h"

char *var_decl_apply(parser_node *node, context *ctx)
{
    node_var_decl *decl = (node_var_decl *)node->data;
    if (decl->value)
    {
        char *val = decl->value->apply(decl->value, ctx);

        char *code = malloc(128);
        sprintf(code, "mov eax, %s", val);
        add_to_list(&ctx->text, code);

        code = malloc(128);
        int off = new_symbol(ctx, decl->identity);
        sprintf(code, "mov dword [rsp+%u], eax", off);
        add_to_list(&ctx->text, code);
    }
    return NULL;
}

void var_decl_debug(int depth, parser_node *node)
{
    node_var_decl *decl = (node_var_decl *)node->data;
    printtabs(depth);
    printf("VarDecl(%s):\n", decl->identity);
    decl->type->debug(depth + 1, decl->type);
    if (decl->value)
    {
        printtabs(depth + 1);
        printf("Value:\n", decl->identity);
        decl->value->debug(depth + 2, decl->value);
    }
}

parser_node *parse_var_decl(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    parser_node *tp = parse_type(&tkn);
    if (tp)
    {
        if (tkn->type_id == TKN_ID)
        {
            typed_token *name_tkn = tkn;
            tkn = tkn->next;

            parser_node *val_expr = NULL;

            if (tkn->type_id == TKN_SEMICOLON)
            {
                val_expr = NULL;
                tkn = tkn->next;
            }
            else if (tkn->type_id == TKN_ASSIGN)
            {
                tkn = tkn->next;
                val_expr = parse_expr(&tkn);
                if (!val_expr)
                {
                    return NULL;
                }
                if (tkn->type_id != TKN_SEMICOLON)
                {
                    return NULL;
                }
                tkn = tkn->next;
            }
            else
            {
                return NULL;
            }

            *tkns_ptr = tkn;
            parser_node *node = (parser_node *)malloc(sizeof(parser_node));
            node->data = (void *)malloc(sizeof(node_var_decl));
            node->debug = var_decl_debug;
            node->apply = var_decl_apply;
            node_var_decl *decl = (node_var_decl *)node->data;
            decl->type = tp;
            decl->identity = malloc(128);
            strcpy(decl->identity, name_tkn->data);
            decl->value = val_expr;

            return node;
        }
    }

    return NULL;
}