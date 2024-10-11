

#include <stdlib.h>
#include <string.h>

#include "../lexer.h"
#include "parser.h"
#include "type.h"

void type_debug(int depth, parser_node *node)
{
    node_type *tp = (node_type *)node->data;
    printtabs(depth);
    printf("Type(%s", tp->name);
    for (int i = 0; i < tp->num_pointing; i++)
    {
        printf("*");
    }
    for (int i = 0; i < tp->dim; i++) {
        printf("[%u]", tp->dims[i]);
    }
    printf(")\n");
}

parser_node *parse_type(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    if (tkn->type_id == TKN_INT || tkn->type_id == TKN_VOID || tkn->type_id == TKN_CHAR)
    {
        typed_token *ret_type_tkn = tkn;
        tkn = tkn->next;
        int num_pointing = 0;
        while (tkn->type_id == TKN_STAR)
        {
            tkn = tkn->next;
            num_pointing++;
        }
        *tkns_ptr = tkn;
        parser_node *node = (parser_node *)malloc(sizeof(parser_node));
        node->data = (void *)malloc(sizeof(node_type));
        node->debug = type_debug;
        node_type *par = (node_type *)node->data;
        par->name = ret_type_tkn->data;
        par->num_pointing = num_pointing;
        par->dim = 0;
        par->dims = NULL;
        return node;
    }
    return NULL;
}