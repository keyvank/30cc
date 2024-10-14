

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
    printf(")");
    if (tp->is_struct == 1) {
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
        par->name = ret_type_tkn->data;
    } else if (tkn->type_id == TKN_LIT_STRUCT) 
    {
        tkn = tkn->next;
        typed_token *struct_name_tkn = tkn;
        // TODO: maybe error?
        if (struct_name_tkn == NULL) {
            return NULL;
        }
        node = (parser_node *)malloc(sizeof(parser_node));
        node->data = (void *)malloc(sizeof(node_type));
        node->debug = type_debug;
        node_type *par = (node_type *)node->data;
        if (tkn->next == NULL) {
            // After name there must be either { or the variable name
            return NULL;
        }
        // This is a struct definition not variable
        if (tkn->next->type_id == TKN_L_BRACE) {
            return NULL;
        }
        par->name = malloc(128);
        par->is_struct = 1;
        strcpy(par->name, struct_name_tkn->data);
        tkn = struct_name_tkn->next;
    }
    
    if (node != NULL) {
        int num_pointing = 0;
        while (tkn->type_id == TKN_STAR)
        {
            tkn = tkn->next;
            num_pointing++;
        }
        node_type *par = (node_type *)node->data;
        par->num_pointing = num_pointing;
        par->dim = 0;
        par->dims = NULL;
        *tkns_ptr = tkn;
    }
    return node;
}
