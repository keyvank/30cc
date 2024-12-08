#include "../libc.h"
#include "../lexer.h"
#include "parser.h"
#include "while.h"
#include "statement.h"
#include "expr/expr.h"
#include "../codegen/codegen.h"

apply_result *while_apply(parser_node *node, context *ctx)
{
    node_while *w = (node_while *)node->data;

    char *start_while = new_loop_start_label(ctx);
    char *end_while = new_loop_end_label(ctx);

    add_text(ctx, "%s:", start_while);
    apply_result *condv = w->cond->apply(w->cond, ctx);
    char *rega = reg_a(condv->type, ctx);
    add_text(ctx, "mov %s, %s", rega, condv->code);
    add_text(ctx, "cmp %s, 0", rega);
    add_text(ctx, "je %s", end_while);
    w->body->apply(w->body, ctx);
    add_text(ctx, "jmp %s", start_while);
    add_text(ctx, "%s:", end_while);

    exit_loop(ctx);

    return NULL;
}

void while_debug(int depth, parser_node *node)
{
    node_while *w = (node_while *)node->data;
    printtabs(depth);
    printf("While(\n");
    printtabs(depth + 1);
    printf("Cond:\n");
    w->cond->debug(depth + 2, w->cond);
    printtabs(depth + 1);
    printf("Body:\n");
    w->body->debug(depth + 2, w->body);
}

parser_node *parse_while(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    if (tkn->type_id == TKN_WHILE)
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

                        parser_node *node = new_node(while_debug, while_apply, sizeof(node_while));
                        node_while *w = (node_while *)node->data;
                        w->body = body;
                        w->cond = cond;

                        return node;
                    }
                }
            }
        }
    }
    return NULL;
}

apply_result *do_while_apply(parser_node *node, context *ctx)
{
    node_while *w = (node_while *)node->data;

    char *start_while = new_loop_start_label(ctx);
    char *end_while = new_loop_end_label(ctx);

    add_text(ctx, "%s:", start_while);
    w->body->apply(w->body, ctx);

    apply_result *condv = w->cond->apply(w->cond, ctx);
    char *rega = reg_a(condv->type, ctx);
    add_text(ctx, "mov %s, %s", rega, condv->code);
    add_text(ctx, "cmp %s, 0", rega);
    add_text(ctx, "je %s", end_while);
    add_text(ctx, "jmp %s", start_while);

    add_text(ctx, "%s:", end_while);
    exit_loop(ctx);

    return NULL;
}

void do_while_debug(int depth, parser_node *node)
{
    node_while *w = (node_while *)node->data;
    printtabs(depth);
    printf("DoWhile(\n");
    printtabs(depth + 1);
    printf("Cond:\n");
    w->cond->debug(depth + 2, w->cond);
    printtabs(depth + 1);
    printf("Body:\n");
    w->body->debug(depth + 2, w->body);
}

parser_node *parse_do_while(typed_token **tkns_ptr)
{

    typed_token *tkn = *tkns_ptr;
    if (tkn->type_id == TKN_DO)
    {
        tkn = tkn->next;
        parser_node *body = parse_statement(&tkn);
        if (!body)
        {
            return NULL;
        }

        if (tkn->type_id == TKN_WHILE)
        {
            tkn = tkn->next;
            if (tkn->type_id == TKN_L_PAREN)
            {
                tkn = tkn->next;
                parser_node *cond = parse_expr(&tkn);
                if (!cond)
                {
                    return NULL;
                }

                if (tkn->type_id == TKN_R_PAREN)
                {
                    tkn = tkn->next;
                    if (tkn->type_id == TKN_SEMICOLON)
                    {
                        tkn = tkn->next;
                        *tkns_ptr = tkn;

                        parser_node *node = new_node(do_while_debug, do_while_apply, sizeof(node_while));
                        node_while *w = (node_while *)node->data;
                        w->body = body;
                        w->cond = cond;

                        return node;
                    }
                }
            }
        }
    }

    return NULL;
}
