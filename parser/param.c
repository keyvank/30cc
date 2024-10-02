

#include <stdlib.h>

#include "../lexer.h"
#include "parser.h"
#include "param.h"
#include "type.h"

void param_debug(int depth, parser_node *node)
{
    node_param *par = (node_param *)node->data;
    printtabs(depth);
    printf("Param: %s\n", par->identity);
    par->type->debug(depth + 1, par->type);
}

parser_node *parse_param(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    parser_node *tp = parse_type(&tkn);
    if (tp)
    {
        if (tkn->type_id == TKN_ID)
        {
            typed_token *name_tkn = tkn;
            tkn = tkn->next;
            *tkns_ptr = tkn;

            parser_node *node = (parser_node *)malloc(sizeof(parser_node));
            node->data = (void *)malloc(sizeof(node_param));
            node->debug = param_debug;
            node_param *par = (node_param *)node->data;

            par->identity = malloc(128);
            strcpy(par->identity, name_tkn->data);
            par->type = tp;

            return node;
        }
        else
        {
            *tkns_ptr = tkn;

            parser_node *node = (parser_node *)malloc(sizeof(parser_node));
            node->data = (void *)malloc(sizeof(node_param));
            node->debug = param_debug;
            node_param *par = (node_param *)node->data;
            par->identity = NULL;
            par->type = tp;

            return node;
        }
    }

    return NULL;
}