#include "extern.h"
#include <stdlib.h>
#include <string.h>
#include "../codegen/codegen.h"

#include "parser.h"
#include "var_decl.h"
#include "type.h"

void extern_debug(int depth, parser_node *node)
{
    node_extern *ex = (node_extern *)node->data;
    printtabs(depth);
    printf("Extern:\n");
    ex->var_decl->debug(depth + 1, ex->var_decl);
}

apply_result *extern_apply(parser_node *node, context *ctx)
{
    node_extern *ex = (node_extern *)node->data;
    node_var_decl *vd = ex->var_decl->data;
    node_type *tp = vd->type->data;

    add_text(ctx, "extern %s", vd->identity);
    new_global_symbol(ctx, vd->identity, cc_asprintf("[%s]", vd->identity), tp->type);

    return NULL;
}

parser_node *parse_extern(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    if (tkn->type_id == TKN_EXTERN)
    {
        tkn = tkn->next;
        parser_node *decl = parse_var_decl(&tkn);
        if (decl)
        {
            *tkns_ptr = tkn;

            parser_node *node = (parser_node *)malloc(sizeof(parser_node));
            node->data = (void *)malloc(sizeof(node_extern));
            node->debug = extern_debug;
            node->apply = extern_apply;
            node_extern *ex = (node_extern *)node->data;
            ex->var_decl = decl;

            return node;
        }
    }

    return NULL;
}