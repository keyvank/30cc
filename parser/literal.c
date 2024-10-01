

#include <stdlib.h>

#include "../lexer.h"
#include "parser.h"
#include "literal.h"

void literal_debug(int depth, parser_node *node)
{
    node_literal *lit = (node_literal *)node->data;
    printtabs(depth);
    if (lit->type == TKN_STR)
        printf("Literal(Type: %d, Value: %s)\n", lit->type, lit->value);
    else if (lit->type == TKN_LIT_INT)
    {
        printf("Literal(Type: %d, Value: %u)\n", lit->type, *((int *)lit->value));
    }
    else
    {
        printf("Literal(Type: %d)\n", lit->type);
    }
}

parser_node *parse_literal(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    if (tkn->type_id == TKN_STR || tkn->type_id == TKN_LIT_INT)
    {
        typed_token *val_tkn = tkn;
        tkn = tkn->next;
        *tkns_ptr = tkn;

        parser_node *node = (parser_node *)malloc(sizeof(parser_node));
        node->type = NODE_LITERAL;
        node->data = (void *)malloc(sizeof(node_literal));
        node->debug = literal_debug;
        node_literal *lit = (node_literal *)node->data;

        lit->type = val_tkn->type_id;
        if (lit->type == TKN_STR)
        {
            lit->value = malloc(128);
            strcpy(lit->value, val_tkn->data);
        }
        else if (lit->type == TKN_LIT_INT)
        {
            lit->value = malloc(sizeof(int));
            *((int *)lit->value) = *((int *)val_tkn->data);
        }
        else
        {
            return NULL;
        }

        return node;
    }

    return NULL;
}