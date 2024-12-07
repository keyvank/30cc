#include "../libc.h"
#include "../lexer.h"
#include "parser.h"
#include "asm.h"
#include "statement.h"
#include "../codegen/codegen.h"
#include "../linked_list.h"

apply_result *asm_apply(parser_node *node, context *ctx)
{
    node_asm *as = (node_asm *)node->data;
    list_node *curr = as->lines->first;
    while (curr)
    {
        add_text(ctx, curr->value);
        curr = curr->next;
    }
    return NULL;
}

void asm_debug(int depth, parser_node *node)
{
    node_asm *as = (node_asm *)node->data;
    printtabs(depth);
    list_node *curr = as->lines->first;
    printf("Asm:\n");
    while (curr)
    {
        printtabs(depth + 1);
        printf("\"%s\"\n", (char *)curr->value);
        curr = curr->next;
    }
}

parser_node *parse_asm(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;

    if (tkn->type_id == TKN_ASM)
    {
        tkn = tkn->next;
        if (tkn->type_id == TKN_L_PAREN)
        {
            tkn = tkn->next;
            linked_list *lines = new_linked_list();
            while (tkn)
            {
                if (tkn->type_id == TKN_R_PAREN)
                {
                    tkn = tkn->next;
                    if (tkn->type_id == TKN_SEMICOLON)
                    {
                        tkn = tkn->next;
                        *tkns_ptr = tkn;

                        parser_node *node = (parser_node *)malloc(sizeof(parser_node));
                        node->data = (void *)malloc(sizeof(node_compound_statement));
                        node->debug = asm_debug;
                        node->apply = asm_apply;
                        node_asm *as = (node_asm *)node->data;
                        as->lines = lines;

                        return node;
                    }
                }
                else if (tkn->type_id == TKN_LIT_STR)
                {
                    add_to_list(lines, tkn->data);
                    tkn = tkn->next;
                }
                else
                {
                    return NULL;
                }
            }
        }
    }
    return NULL;
}