#include "../libc.h"
#include "../lexer.h"
#include "parser.h"
#include "if.h"
#include "statement.h"
#include "expr/expr.h"
#include "../codegen/codegen.h"
#include "../linked_list.h"

apply_result *if_apply(parser_node *node, context *ctx)
{
    node_if *ifn = (node_if *)node->data;
    apply_result *ife = ifn->cond->apply(ifn->cond, ctx);
    char *rega = reg_a(ife->type, ctx);

    add_text(ctx, "mov %s, 0", rega);

    char *end_of_if = new_label(ctx);
    char *end_of_else = NULL;
    if (ifn->else_body)
    {
        end_of_else = new_label(ctx);
    }

    add_text(ctx, "cmp %s, %s", rega, ife->code);
    add_text(ctx, "je %s", end_of_if);
    ifn->body->apply(ifn->body, ctx);
    if (ifn->else_body)
    {
        add_text(ctx, "jmp %s", end_of_else);
    }
    add_text(ctx, "%s:", end_of_if);
    if (ifn->else_body)
    {
        ifn->else_body->apply(ifn->else_body, ctx);
        add_text(ctx, "%s:", end_of_else);
    }

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
                    parser_node *else_body = NULL;
                    if (body)
                    {
                        if (tkn->type_id == TKN_ELSE)
                        {
                            tkn = tkn->next;
                            else_body = parse_statement(&tkn);
                            if (!else_body)
                            {
                                return NULL;
                            }
                        }

                        *tkns_ptr = tkn;

                        parser_node *node = (parser_node *)malloc(sizeof(parser_node));
                        node->data = (void *)malloc(sizeof(node_if));
                        node->debug = if_debug;
                        node->apply = if_apply;
                        node_if *f = (node_if *)node->data;
                        f->body = body;
                        f->else_body = else_body;
                        f->cond = cond;

                        return node;
                    }
                }
            }
        }
    }
    return NULL;
}