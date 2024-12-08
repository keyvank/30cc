#include "extern.h"
#include "../libc.h"
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
    node_var_decl *vd = (node_var_decl *)ex->var_decl->data;
    node_type *tp = (node_type *)vd->type->data;

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

            parser_node *node = new_node(extern_debug, extern_apply, sizeof(node_extern));
            node_extern *ex = (node_extern *)node->data;
            ex->var_decl = decl;

            return node;
        }
    }

    return NULL;
}