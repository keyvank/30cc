

#include <stdlib.h>
#include <string.h>

#include "../lexer.h"
#include "parser.h"
#include "type.h"

void type_debug(int depth, parser_node *node)
{
    node_type *tp = (node_type *)node->data;
    printtabs(depth);
    printf("Type(%s", tp->type->name);
    for (int i = 0; i < tp->type->num_pointing; i++)
    {
        printf("*");
    }
    for (int i = 0; i < tp->type->dim; i++)
    {
        printf("[%u]", tp->type->dims[i]);
    }
    printf(")");
    if (tp->type->is_struct == 1)
    {
        printf("struct");
    }
    printf("\n");
}

parser_node *parse_type(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    parser_node *node = NULL;
    if (tkn->type_id == TKN_INT || tkn->type_id == TKN_VOID || tkn->type_id == TKN_CHAR)
    {
        typed_token *ret_type_tkn = tkn;
        tkn = tkn->next;
        node = (parser_node *)malloc(sizeof(parser_node));
        node->data = (void *)malloc(sizeof(node_type));
        node->debug = type_debug;
        node_type *par = (node_type *)node->data;
        par->type = new_type(ret_type_tkn->data, 0, 0, 0, NULL);
    }
    else if (tkn->type_id == TKN_LIT_STRUCT)
    {
        tkn = tkn->next;
        typed_token *struct_name_tkn = tkn;
        // TODO: maybe error?
        if (struct_name_tkn == NULL)
        {
            return NULL;
        }
        node = (parser_node *)malloc(sizeof(parser_node));
        node->data = (void *)malloc(sizeof(node_type));
        node->debug = type_debug;
        node_type *par = (node_type *)node->data;
        if (tkn->next == NULL)
        {
            // After name there must be either { or the variable name
            return NULL;
        }
        // This is a struct definition not variable
        if (tkn->next->type_id == TKN_L_BRACE)
        {
            return NULL;
        }

        char *tp_name = malloc(128);
        strcpy(tp_name, struct_name_tkn->data);
        par->type = new_type(tp_name, 0, 1, 0, NULL);
        tkn = struct_name_tkn->next;
    }

    if (node != NULL)
    {
        int num_pointing = 0;
        while (tkn->type_id == TKN_STAR)
        {
            tkn = tkn->next;
            num_pointing++;
        }
        node_type *par = (node_type *)node->data;
        par->type->num_pointing = num_pointing;
        par->type->dim = 0;
        par->type->dims = NULL;
        *tkns_ptr = tkn;
    }
    return node;
}
