

#include <stdlib.h>
#include <string.h>

#include "../../lexer.h"
#include "../parser.h"
#include "index.h"
#include "expr.h"

void index_debug(int depth, parser_node *node)
{
    node_index *idx = (node_index *)node->data;
    printtabs(depth);
    printf("Access:\n");
    printtabs(depth + 1);
    printf("In:\n");
    idx->arr->debug(depth + 2, idx->arr);
    printtabs(depth + 1);
    printf("Index:\n");
    idx->ind->debug(depth + 2, idx->ind);
}

apply_result *index_apply(parser_node *node, context *ctx)
{
    node_index *idx = (node_index *)node->data;
    int elem_size = 8;

    apply_result *arr = idx->arr->apply(idx->arr, ctx);
    apply_result *ind = idx->ind->apply(idx->ind, ctx);
    add_text(ctx, "mov rax, %s", ind->code);
    add_text(ctx, "mov rbx, %u", elem_size);
    add_text(ctx, "mul rbx");
    add_text(ctx, "mov rbx, %s", arr->code);
    add_text(ctx, "add rbx, rax");
    add_text(ctx, "mov rax, [rbx]");

    symbol *sym = new_temp_symbol(ctx, elem_size);
    add_text(ctx, "mov %s, rax", sym->repl);

    return new_result(sym->repl, NULL);
}

parser_node *parse_index(typed_token **tkns_ptr, parser_node *arr)
{
    typed_token *tkn = *tkns_ptr;

    if (tkn->type_id == TKN_L_BRACK)
    {
        tkn = tkn->next;
        parser_node *ind = parse_expr(&tkn);
        if (ind)
        {
            if (tkn->type_id == TKN_R_BRACK)
            {
                tkn = tkn->next;
                *tkns_ptr = tkn;
                parser_node *node = (parser_node *)malloc(sizeof(parser_node));
                node->data = (void *)malloc(sizeof(node_index));
                node->debug = index_debug;
                node->apply = index_apply;
                node_index *idx = (node_index *)node->data;
                idx->arr = arr;
                idx->ind = ind;

                return node;
            }
        }
    }

    return NULL;
}
