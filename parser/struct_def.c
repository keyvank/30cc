
#include <stdlib.h>
#include <string.h>

#include "../lexer.h"
#include "parser.h"
#include "struct_def.h"
#include "var_decl.h"

void struct_def_debug(int depth, parser_node *node)
{
    node_struct_def *sd = (node_struct_def *)node->data;
    printtabs(depth);
    printf("Struct(%s)\n", sd->name);
    for (int i = 0; i < sd->num_fields; i++)
    {
        sd->fields[i]->debug(depth + 1, sd->fields[i]);
    }
}

parser_node *parse_struct_def(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;

    if (tkn->type_id == TKN_LIT_STRUCT)
    {
        tkn = tkn->next;
        if (tkn->type_id == TKN_ID)
        {
            typed_token *name_tkn = tkn;
            tkn = tkn->next;
            if (tkn->type_id == TKN_L_BRACE)
            {
                tkn = tkn->next;
                int num_fields = 0;
                parser_node **fields = (parser_node **)malloc(sizeof(parser_node *) * 128);
                while (tkn)
                {
                    if (tkn->type_id == TKN_R_BRACE)
                    {
                        tkn = tkn->next;
                        if (tkn->type_id == TKN_SEMICOLON)
                        {
                            tkn = tkn->next;
                            *tkns_ptr = tkn;
                            parser_node *node = (parser_node *)malloc(sizeof(parser_node));
                            node->data = (void *)malloc(sizeof(node_struct_def));
                            node->debug = struct_def_debug;
                            node_struct_def *sd = (node_struct_def *)node->data;

                            sd->name = malloc(128);
                            strcpy(sd->name, (char *)name_tkn->data);
                            sd->fields = fields;
                            sd->num_fields = num_fields;
                            return node;
                        }
                    }
                    parser_node *p = parse_var_decl(&tkn);
                    if (p)
                    {
                        fields[num_fields++] = p;
                    }
                    else
                    {
                        return NULL;
                    }
                }
            }
        }
    }

    return NULL;
}