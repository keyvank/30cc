
#include <stdlib.h>
#include <string.h>

#include "../lexer.h"
#include "parser.h"
#include "var_decl.h"
#include "type.h"
#include "expr/expr.h"
#include "../codegen/codegen.h"
#include "../linked_list.h"

apply_result *var_decl_apply(parser_node *node, context *ctx)
{
    node_var_decl *decl = (node_var_decl *)node->data;
    node_type *tp = (node_type *)decl->type->data;
    int cnt = 1;
    for (int i = 0; i < tp->dim; i++)
    {
        cnt *= tp->dims[i];
    }
    int elem_size = 8;
    int ptr_size = 8;

    int alloc_size = cnt * elem_size;
    if (tp->dims)
        alloc_size += ptr_size;

    symbol *sym = new_symbol(ctx, decl->identity, alloc_size);

    // Store the address of the var in the var
    if (tp->dims)
    {
        add_text(ctx, "mov qword %s, %u", sym->repl, sym->offset + ptr_size);
        add_text(ctx, "add %s, rsp", sym->repl);
    }

    if (decl->value)
    {
        apply_result *val = decl->value->apply(decl->value, ctx);
        add_text(ctx, "mov rax, %s", val->code);
        add_text(ctx, "mov %s, rax", sym->repl);
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
        printf("Value:\n");
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

            int dim = 0;
            int *dims = malloc(sizeof(int) * 32);
            while (tkn->type_id == TKN_L_BRACK)
            {
                tkn = tkn->next;
                if (tkn->type_id == TKN_LIT_INT)
                {
                    int sz = *((int *)tkn->data);
                    tkn = tkn->next;
                    if (tkn->type_id == TKN_R_BRACK)
                    {
                        tkn = tkn->next;
                        dims[dim++] = sz;
                        continue;
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

            ((node_type *)tp->data)->dims = dims;
            ((node_type *)tp->data)->dim = dim;

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
