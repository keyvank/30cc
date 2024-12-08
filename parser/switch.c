
#include "../libc.h"
#include "switch.h"
#include "expr/expr.h"
#include "parser.h"
#include "../lexer.h"
#include "statement.h"

void switch_debug(int depth, parser_node *node)
{
    node_switch *switch_data = (node_switch *)node->data;
    printtabs(depth);
    printf("Swtich(\n");
    printtabs(depth + 1);
    printf("Cond:\n");
    switch_data->condition->debug(depth + 2, switch_data->condition);
    printtabs(depth + 1);
    printf("Body:\n");
    list_node *stmt = switch_data->statements->first;
    printtabs(depth + 2);
    printf("Statements:\n");
    while (stmt)
    {
        parser_node *stmt_data = (parser_node *)stmt->value;
        stmt_data->debug(depth + 3, stmt_data);
        stmt = stmt->next;
    }
    printtabs(depth + 2);
    printf("Cases:\n");
    list_node *stmt_case = switch_data->cases->first;
    list_node *location = switch_data->case_locations->first;
    while (stmt_case)
    {
        parser_node *stmt_data = (parser_node *)stmt_case->value;
        printf("%d: ", (int)location->value);
        stmt_data->debug(depth + 3, stmt_data);
        stmt_case = stmt_case->next;
        location = location->next;
    }

    if (switch_data->default_location)
    {
        printf("default location: %d\n", switch_data->default_location);
    }
}

apply_result *switch_apply(parser_node *node, context *ctx)
{
    node_switch *switch_node = (node_switch *)node->data;

    add_text(ctx, ";start switch");
    char *end_switch_label = new_loop_end_label(ctx);

    apply_result *condition_eval = switch_node->condition->apply(switch_node->condition, ctx);
    char *rega = reg_a(condition_eval->type, ctx);
    add_text(ctx, "mov %s, %s", rega, condition_eval->code);

    list_node *location = switch_node->case_locations->first;
    list_node *stmt_case = switch_node->cases->first;

    // TODO: Add type checking for cases and condition
    while (stmt_case != NULL)
    {
        parser_node *stmt_data = (parser_node *)stmt_case->value;
        parser_node *case_data = (parser_node *)stmt_case->value;
        apply_result *case_apply = case_data->apply(case_data, ctx);
        char *rega = reg_a(case_apply->type, ctx);
        add_text(ctx, "cmp %s, %s", rega, case_apply->code);
        add_text(ctx, "je case_%s_%d", end_switch_label, (int)location->value);
        stmt_case = stmt_case->next;
        location = location->next;
    }

    add_text(ctx, "jmp case_%s_%d", end_switch_label, switch_node->default_location);

    location = switch_node->case_locations->first;
    list_node *stmt = switch_node->statements->first;
    int stmt_count = 0;
    while (stmt)
    {
        add_text(ctx, "; stmt loc %d", stmt_count);
        if (location != NULL)
        {
            while (stmt_count == (int)location->value)
            {
                add_text(ctx, "case_%s_%d:", end_switch_label, (int)location->value);
                location = location->next;
                if (location == NULL)
                    break;
            }
        }
        if (stmt_count == switch_node->default_location)
        {
            add_text(ctx, "case_%s_%d:", end_switch_label, switch_node->default_location);
        }
        parser_node *stmt_data = (parser_node *)stmt->value;
        stmt_data->apply(stmt_data, ctx);
        stmt = stmt->next;
        stmt_count++;
    }

    pop_list(ctx->loop_end_labels);
    add_text(ctx, "; end switch");
    add_text(ctx, "%s:", end_switch_label);

    return NULL;
}

parser_node *parse_case(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;

    if (tkn->type_id != TKN_CASE)
        return NULL;

    tkn = tkn->next;
    parser_node *expr = parse_expr(&tkn);

    if (expr)
    {
        if (tkn->type_id != TKN_COLON)
            return NULL;
        tkn = tkn->next;
        *tkns_ptr = tkn;
        return expr;
    }
    else
    {
        return NULL;
    }
}

parser_node *parse_switch(typed_token **tkns_ptr)
{

    typed_token *tkn = *tkns_ptr;

    if (tkn->type_id == TKN_SWITCH)
    {
        tkn = tkn->next;
        // TODO: error
        if (tkn->type_id != TKN_L_PAREN)
            return NULL;
        tkn = tkn->next;

        parser_node *condition = parse_expr(&tkn);

        if (tkn->type_id != TKN_R_PAREN)
            return NULL;

        tkn = tkn->next;

        if (tkn->type_id != TKN_L_BRACE)
            return NULL;

        linked_list *stmts = new_linked_list();
        linked_list *cases = new_linked_list();
        linked_list *case_locations = new_linked_list();
        int default_location = 0;
        tkn = tkn->next;
        while (tkn)
        {
            if (tkn->type_id == TKN_R_BRACE)
            {
                tkn = tkn->next;
                *tkns_ptr = tkn;

                parser_node *node = new_node(switch_debug, switch_apply, sizeof(node_switch));
                node_switch *switch_data = (node_switch *)node->data;
                switch_data->condition = condition;
                switch_data->statements = stmts;
                switch_data->case_locations = case_locations;
                switch_data->cases = cases;
                switch_data->default_location = default_location;

                if (case_locations->count != cases->count)
                {
                    fprintf(stderr, "cases and case locations must have equal member count. cases: %d locations: %d", cases->count, case_locations->count);
                    return NULL;
                }

                return node;
            }
            parser_node *stmt = NULL;

            if (tkn->type_id == TKN_DEFAULT)
            {
                tkn = tkn->next;
                if (tkn->type_id != TKN_COLON)
                    return NULL;
                tkn = tkn->next;
                default_location = stmts->count;
                continue;
            }

            stmt = parse_statement(&tkn);
            if (stmt)
            {
                add_to_list(stmts, stmt);
                continue;
            }
            stmt = parse_case(&tkn);
            if (stmt)
            {
                add_to_list(cases, stmt);
                add_to_list(case_locations, (void *)stmts->count);
                continue;
            }

            return NULL;
        }
    }

    return NULL;
}
