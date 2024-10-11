

#include <stdlib.h>

#include "../../lexer.h"
#include "../parser.h"
#include "deref.h"
#include "expr.h"
#include "var.h"

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

    add_text(ctx, "mov rax, %s", loc);
    add_text(ctx, "mov rax, [rax]");

    return "rax";
}

parser_node *parse_deref(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;

    if (tkn->type_id == TKN_STAR)
    {
        tkn = tkn->next;
        parser_node *n = parse_terminal(&tkn);
        if (n)
        {
            *tkns_ptr = tkn;
            parser_node *node = (parser_node *)malloc(sizeof(parser_node));
            node->data = (void *)malloc(sizeof(node_deref));
            node->debug = deref_debug;
            node->apply = deref_apply;
            node_deref *ref = (node_deref *)node->data;
            ref->var = n;

            return node;
        }
        else
        {
            return NULL;
        }
    }

    return NULL;
}