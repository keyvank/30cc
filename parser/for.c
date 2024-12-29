#include "../libc.h"
#include "../lexer.h"
#include "parser.h"
#include "for.h"
#include "var_decl.h"
#include "statement.h"
#include "expr/expr.h"
#include "../codegen/codegen.h"
#include "../linked_list.h"

apply_result *for_apply(parser_node *node, context *ctx)
{
    node_for *forn = (node_for *)node->data;

    int num_syms = ctx->symbol_table->count;

    forn->init->apply(forn->init, ctx);

    char *start_for = new_loop_start_label(ctx);
    char *end_for = new_loop_end_label(ctx);
    char *cond_for = new_label(ctx);

    add_text(ctx, "jmp %s", cond_for);
    add_text(ctx, "%s:", start_for);
    forn->act->apply(forn->act, ctx);

    add_text(ctx, "%s:", cond_for);
    apply_result *condv = forn->cond->apply(forn->cond, ctx);
    char *rega = reg_a(condv->type, ctx);
    add_text(ctx, "mov %s, %s", rega, condv->code);
    add_text(ctx, "cmp %s, 0", rega);
    add_text(ctx, "je %s", end_for);
    forn->body->apply(forn->body, ctx);
    add_text(ctx, "jmp %s", start_for);
    add_text(ctx, "%s:", end_for);
    while (ctx->symbol_table->count > num_syms)
    {
        pop_list(ctx->symbol_table);
    }

    exit_loop(ctx);

    return NULL;
}

void for_debug(int depth, parser_node *node)
{
    node_for *func = (node_for *)node->data;
    printtabs(depth);
    printf("For(\n");
    printtabs(depth + 1);
    printf("Init:\n");
    func->init->debug(depth + 2, func->init);
    printtabs(depth + 1);
    printf("Cond:\n");
    func->cond->debug(depth + 2, func->cond);
    printtabs(depth + 1);
    printf("Act:\n");
    func->act->debug(depth + 2, func->act);
    printtabs(depth + 1);
    printf("Body:\n");
    func->body->debug(depth + 2, func->body);
}

parser_node *parse_for(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    if (tkn->type_id == TKN_FOR)
    {
        tkn = tkn->next;
        if (tkn->type_id == TKN_L_PAREN)
        {
            tkn = tkn->next;
            parser_node *init = parse_var_decl(&tkn);
            if (init)
            {
                parser_node *cond = parse_expr(&tkn);
                if (cond)
                {
                    if (tkn->type_id == TKN_SEMICOLON)
                    {
                        tkn = tkn->next;
                        parser_node *act = parse_expr(&tkn);
                        if (act)
                        {
                            if (tkn->type_id == TKN_R_PAREN)
                            {
                                tkn = tkn->next;
                                parser_node *body = parse_statement(&tkn);
                                if (body)
                                {
                                    *tkns_ptr = tkn;

                                    parser_node *node = new_node(for_debug, for_apply, sizeof(node_for));
                                    node_for *f = (node_for *)node->data;
                                    f->act = act;
                                    f->body = body;
                                    f->cond = cond;
                                    f->init = init;

                                    return node;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return NULL;
}
