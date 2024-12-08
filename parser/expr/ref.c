#include "../../libc.h"
#include "../../lexer.h"
#include "../parser.h"
#include "ref.h"
#include "expr.h"
#include "var.h"

void ref_debug(int depth, parser_node *node)
{
    node_ref *ref = (node_ref *)node->data;
    printtabs(depth);
    printf("Ref:\n");
    ref->var->debug(depth + 1, ref->var);
}

apply_result *ref_apply(parser_node *node, context *ctx)
{
    node_ref *ref = (node_ref *)node->data;
    apply_result *v = ref->var->apply(ref->var, ctx);
    add_text(ctx, "mov rax, %s", v->addr_code);
    symbol *res = new_temp_symbol(ctx, new_pointer_type(v->type));
    add_text(ctx, "mov %s, rax", res->repl);
    return new_result(res->repl, res->type);
}

parser_node *parse_ref(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;

    if (tkn->type_id == TKN_AND)
    {
        tkn = tkn->next;
        parser_node *n = parse_terminal(&tkn);
        if (n)
        {
            *tkns_ptr = tkn;
            parser_node *node = new_node(ref_debug, ref_apply, sizeof(node_ref));
            node_ref *ref = (node_ref *)node->data;
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