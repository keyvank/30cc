#include "../libc.h"
#include "goto.h"

void label_debug(int depth, parser_node *node)
{
    node_label *lab = (node_label *)node->data;
    printtabs(depth);
    printf("Label: %s\n", lab->name);
}

apply_result *label_apply(parser_node *node, context *ctx)
{
    node_label *lab = (node_label *)node->data;
    add_text(ctx, "%s:", lab->name);
    return NULL;
}

parser_node *parse_label(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;

    if (tkn->type_id == TKN_ID)
    {
        typed_token *name_tkn = tkn;
        tkn = tkn->next;

        if (tkn->type_id == TKN_COLON)
        {
            tkn = tkn->next;
            *tkns_ptr = tkn;
            parser_node *node = (parser_node *)malloc(sizeof(parser_node));
            node->data = (void *)malloc(sizeof(node_label));
            node->debug = label_debug;
            node->apply = label_apply;
            node_label *lab = (node_label *)node->data;
            lab->name = (char *)name_tkn->data;

            return node;
        }
    }

    return NULL;
}

void goto_debug(int depth, parser_node *node)
{
    node_goto *go = (node_goto *)node->data;
    printtabs(depth);
    printf("Goto: %s\n", go->label);
}

apply_result *goto_apply(parser_node *node, context *ctx)
{
    node_goto *go = (node_goto *)node->data;
    add_text(ctx, "jmp %s", go->label);
    return NULL;
}

parser_node *parse_goto(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;

    if (tkn->type_id == TKN_GOTO)
    {
        tkn = tkn->next;
        if (tkn->type_id == TKN_ID)
        {
            typed_token *label_tkn = tkn;
            tkn = tkn->next;

            if (tkn->type_id == TKN_SEMICOLON)
            {
                tkn = tkn->next;
                *tkns_ptr = tkn;
                parser_node *node = (parser_node *)malloc(sizeof(parser_node));
                node->data = (void *)malloc(sizeof(node_goto));
                node->debug = goto_debug;
                node->apply = goto_apply;
                node_goto *go = (node_goto *)node->data;
                go->label = (char *)label_tkn->data;

                return node;
            }
        }
    }

    return NULL;
}
