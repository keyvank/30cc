

#include <stdlib.h>

#include "../lexer.h"
#include "parser.h"
#include "type.h"

void type_debug(int depth, parser_node *node)
{
    node_type *tp = (node_type *)node->data;
    printtabs(depth);
    printf("Type(%s)\n", tp->name);
}

parser_node *parse_type(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    if (tkn->type_id == TKN_INT || tkn->type_id == TKN_VOID)
    {

        *tkns_ptr = tkn;
        parser_node *node = (parser_node *)malloc(sizeof(parser_node));
        node->type = NODE_TYPE;
        node->data = (void *)malloc(sizeof(node_type));
        node->debug = type_debug;
        node_type *par = (node_type *)node->data;
        par->name = tkn->data;
        tkn = tkn->next;
        return node;
    }
    return NULL;
}