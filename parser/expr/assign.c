

#include <stdlib.h>
#include <string.h>

#include "../../lexer.h"
#include "../parser.h"
#include "assign.h"
#include "../param.h"
#include "../type.h"
#include "expr.h"

void assign_debug(int depth, parser_node *node)
{
    node_assign *assign = (node_assign *)node->data;
    printtabs(depth);
    printf("Assign(%s):\n", assign->identity);
    if (assign->value)
    {
        printtabs(depth + 1);
        printf("Value:\n");
        assign->value->debug(depth + 2, assign->value);
    }
}

apply_result *assign_apply(parser_node *node, context *ctx)
{
    node_assign *assign = (node_assign *)node->data;

    apply_result *val = assign->value->apply(assign->value, ctx);
    symbol *sym = find_symbol(ctx, assign->identity);

    add_text(ctx, "mov rax, %s", val->code);
    char *res = cc_asprintf("[rsp+%u]", sym->offset);
    add_text(ctx, "mov %s, rax", res);

    return new_result(res, NULL);
}

parser_node *parse_assign(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    if (tkn->type_id == TKN_ID)
    {
        typed_token *name_tkn = tkn;
        tkn = tkn->next;

        if (tkn->type_id == TKN_ASSIGN)
        {
            tkn = tkn->next;
            parser_node *val = parse_expr(&tkn);

            if (val)
            {
                *tkns_ptr = tkn;
                parser_node *node = (parser_node *)malloc(sizeof(parser_node));
                node->data = (void *)malloc(sizeof(node_assign));
                node->debug = assign_debug;
                node->apply = assign_apply;
                node_assign *assign = (node_assign *)node->data;
                assign->identity = malloc(128);
                strcpy(assign->identity, name_tkn->data);
                assign->value = val;

                return node;
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

    return NULL;
}
