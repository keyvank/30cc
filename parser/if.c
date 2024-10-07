
#include <stdlib.h>

#include "../lexer.h"
#include "parser.h"
#include "if.h"
#include "statement.h"
#include "expr.h"
#include "../codegen/codegen.h"
#include "../linked_list.h"

char *if_apply(parser_node *node, context *ctx)
{
    node_if *ifn = (node_if *)node->data;
    char *ife = ifn->cond->apply(ifn->cond, ctx);

    add_to_list(&ctx->text, "mov rax, 0");

    char *ifcmp = malloc(128);
    sprintf(ifcmp, "cmp rax, %s", ife);
    add_to_list(&ctx->text, ifcmp);

    add_to_list(&ctx->text, "je mylabel");

    ifn->body->apply(ifn->body, ctx);

    add_to_list(&ctx->text, "mylabel:");

    return NULL;
}

void if_debug(int depth, parser_node *node)
{
    node_if *func = (node_if *)node->data;
    printtabs(depth);
    printf("If(\n");
    printtabs(depth + 1);
    printf("Cond:\n");
    func->cond->debug(depth + 2, func->cond);
    printtabs(depth + 1);
    printf("Body:\n");
    func->body->debug(depth + 2, func->body);
}

parser_node *parse_if(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    if (tkn->type_id == TKN_IF)
    {
        tkn = tkn->next;
        if (tkn->type_id == TKN_L_PAREN)
        {
            tkn = tkn->next;
            parser_node *cond = parse_expr(&tkn);
            if (cond)
            {
                if (tkn->type_id == TKN_R_PAREN)
                {
                    tkn = tkn->next;
                    parser_node *body = parse_statement(&tkn);
                    if (body)
                    {
                        *tkns_ptr = tkn;

                        parser_node *node = (parser_node *)malloc(sizeof(parser_node));
                        node->data = (void *)malloc(sizeof(node_if));
                        node->debug = if_debug;
                        node->apply = if_apply;
                        node_if *f = (node_if *)node->data;
                        f->body = body;
                        f->cond = cond;

                        return node;
                    }
                }
            }
        }
    }
    return NULL;
}