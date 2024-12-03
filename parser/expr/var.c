#include "../../libc.h"
#include "../../lexer.h"
#include "../parser.h"
#include "var.h"

void var_debug(int depth, parser_node *node)
{
    node_var *var = (node_var *)node->data;
    printtabs(depth);
    printf("Variable(%s)\n", var->var_name);
}

apply_result *var_apply(parser_node *node, context *ctx)
{
    node_var *var = (node_var *)node->data;
    symbol *sym = find_symbol(ctx, var->var_name);
    symbol *addr_sym = new_temp_symbol(ctx, new_pointer_type(sym->type));
    add_text(ctx, "mov rax, rbp");
    add_text(ctx, "sub rax, %u", sym->offset + sym->type->size(sym->type, ctx));
    add_text(ctx, "mov %s, rax", addr_sym->repl);
    apply_result *res = new_result(sym->repl, sym->type);
    res->addr_code = addr_sym->repl;
    return res;
}

parser_node *parse_var(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;

    if (tkn->type_id == TKN_ID)
    {
        char *varname = (char *)tkn->data;
        tkn = tkn->next;
        *tkns_ptr = tkn;

        parser_node *node = (parser_node *)malloc(sizeof(parser_node));
        node->data = (void *)malloc(sizeof(node_var));
        node->debug = var_debug;
        node->apply = var_apply;
        node_var *var = (node_var *)node->data;
        var->var_name = varname;

        return node;
    }
    return NULL;
}
