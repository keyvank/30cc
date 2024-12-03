#include "break.h"
#include "../libc.h"
#include "parser.h"

void break_debug(int depth, parser_node *node)
{
    printtabs(depth);
    printf("Break\n");
}

apply_result *break_apply(parser_node *node, context *ctx)
{
    char* loop_end_label = (char*)malloc(128);
    get_current_loop_end_label_counter(ctx, loop_end_label);
    add_text(ctx, "jmp %s", loop_end_label);
    free(loop_end_label);
    return NULL;
}

parser_node *parse_break(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    if (tkn->type_id == TKN_BREAK)
    {
        if (tkn->next->type_id != TKN_SEMICOLON) {
            return NULL;
        }
        parser_node *break_node = (parser_node *)malloc(sizeof(parser_node));
        break_node->debug = break_debug;
        break_node->apply = break_apply;
        *tkns_ptr = tkn->next->next;
        return break_node;
    }

    return NULL;
}

void continue_debug(int depth, parser_node *node)
{
    printtabs(depth);
    printf("continue\n");
}

apply_result *continue_apply(parser_node *node, context *ctx)
{
    char* loop_end_label = (char*)malloc(128);
    get_current_loop_start_label_counter(ctx, loop_end_label);
    add_text(ctx, "jmp %s", loop_end_label);
    free(loop_end_label);
    return NULL;
}

parser_node *parse_continue(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    if (tkn->type_id == TKN_CONTINUE)
    {
        if (tkn->next->type_id != TKN_SEMICOLON) {
            return NULL;
        }
        parser_node *continue_node = (parser_node *)malloc(sizeof(parser_node));
        continue_node->debug = break_debug;
        continue_node->apply = break_apply;
        *tkns_ptr = tkn->next->next;
        return continue_node;
    }

    return NULL;
}
