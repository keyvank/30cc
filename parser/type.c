

#include <stdlib.h>
#include <string.h>

#include "../lexer.h"
#include "parser.h"
#include "type.h"

void type_debug(int depth, parser_node *node)
{
    node_type *tp = (node_type *)node->data;
    tp->type->debug(tp->type, NULL, depth);
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
        par->type = new_primitive_type(ret_type_tkn->data);
    }
    else if (tkn->type_id == TKN_STRUCT || tkn->type_id == TKN_ID)
    {
        if (tkn->type_id == TKN_STRUCT)
        {
            tkn = tkn->next;
        }
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
        par->type = new_struct_type(tp_name);
        tkn = struct_name_tkn->next;
    }

    if (node != NULL)
    {
        node_type *par = (node_type *)node->data;
        while (tkn->type_id == TKN_STAR)
        {
            tkn = tkn->next;
            par->type = new_pointer_type(par->type);
        }
        *tkns_ptr = tkn;
    }
    return node;
}
