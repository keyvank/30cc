

#include <stdlib.h>

#include "../lexer.h"
#include "parser.h"
#include "literal.h"

void literal_debug(int depth, parser_node *node)
{
    node_literal *lit = (node_literal *)node->data;
    printtabs(depth);
    printf("Literal(Type: %d, Value: %s)\n", lit->type, lit->value);
}

parser_node *parse_literal(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    if (tkn->type_id == TKN_STR)
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
        lit->value = malloc(128);
        strcpy(lit->value, val_tkn->data);

        return node;
    }

    return NULL;
}