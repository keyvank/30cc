#include "../libc.h"
#include "../lexer.h"
#include "parser.h"
#include "var_decl.h"
#include "type.h"
#include "expr/expr.h"
#include "../codegen/codegen.h"

apply_result *var_decl_apply(parser_node *node, context *ctx)
{
    node_var_decl *decl = (node_var_decl *)node->data;
    node_type *tp = (node_type *)decl->type->data;
    symbol *sym = new_symbol(ctx, decl->identity, tp->type);

    if (decl->value)
    {
        apply_result *val = decl->value->apply(decl->value, ctx);
        if (!types_equal(tp->type, val->type, ctx))
        {
            fprintf(stderr, "Initializing '%s' with an incompatible type!\n", decl->identity);
            tp->type->debug(tp->type, 0);
            val->type->debug(val->type, 0);
            exit(1);
        }
        add_text(ctx, ";define variable %s", decl->identity);
        char *rega = reg_a(val->type, ctx);
        add_text(ctx, "mov %s, %s", rega, val->code);
        add_text(ctx, "mov %s, %s", sym->repl, rega);
        add_text(ctx, ";end define variable %s", decl->identity);
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
    parser_node *tp = parse_type(&tkn, 1);
    if (tp)
    {
        if (((node_type *)tp->data)->name)
        {
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
            decl->identity = ((node_type *)tp->data)->name;
            decl->value = val_expr;

            return node;
        }
    }

    return NULL;
}
