
#include <stdlib.h>
#include <string.h>

#include "../lexer.h"
#include "parser.h"
#include "struct_def.h"
#include "var_decl.h"
#include "type.h"

void struct_def_debug(int depth, parser_node *node)
{
    node_struct_def *sd = (node_struct_def *)node->data;
    printtabs(depth);
    printf("Struct(Name: %s, Typedef: %s)\n", sd->struct_name, sd->typedef_name);
    for (int i = 0; i < sd->num_fields; i++)
    {
        sd->fields[i]->debug(depth + 1, sd->fields[i]);
    }
}

apply_result *struct_def_apply(parser_node *node, context *ctx)
{
    node_struct_def *sd = (node_struct_def *)node->data;
    general_type **fields = (general_type **)malloc(sizeof(general_type *) * sd->num_fields);
    char **field_names = (char **)malloc(sizeof(char *) * sd->num_fields);
    for (int j = 0; j < sd->num_fields; j++)
    {
        node_var_decl *var_decl = (node_var_decl *)sd->fields[j]->data;
        field_names[j] = var_decl->identity;
        fields[j] = ((node_type *)var_decl->type->data)->type;
    }
    context_struct *cs = (context_struct *)malloc(sizeof(context_struct));
    cs->struct_id = ctx->structs.count;
    cs->num_fields = sd->num_fields;
    cs->fields = fields;
    cs->field_names = field_names;
    cs->struct_name = sd->struct_name;
    cs->typedef_name = sd->typedef_name;
    new_struct(ctx, cs);
}

parser_node *parse_struct_def(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;

    int is_typedef = 0;
    if (tkn->type_id == TKN_TYPEDEF)
    {
        tkn = tkn->next;
        is_typedef = 1;
    }

    if (tkn->type_id == TKN_STRUCT)
    {
        tkn = tkn->next;
        typed_token *struct_name_tkn = NULL;
        typed_token *typedef_name_tkn = NULL;
        if (tkn->type_id == TKN_ID)
        {
            struct_name_tkn = tkn;
            tkn = tkn->next;
        }
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
                    if (is_typedef)
                    {
                        if (tkn->type_id == TKN_ID)
                        {
                            typedef_name_tkn = tkn;
                            tkn = tkn->next;
                        }
                        else
                        {
                            return NULL;
                        }
                    }
                    if (tkn->type_id == TKN_SEMICOLON)
                    {
                        tkn = tkn->next;
                        *tkns_ptr = tkn;
                        parser_node *node = (parser_node *)malloc(sizeof(parser_node));
                        node->data = (void *)malloc(sizeof(node_struct_def));
                        node->debug = struct_def_debug;
                        node->apply = struct_def_apply;
                        node_struct_def *sd = (node_struct_def *)node->data;

                        sd->struct_name = NULL;
                        sd->typedef_name = NULL;
                        if (struct_name_tkn)
                        {
                            sd->struct_name = malloc(128);
                            strcpy(sd->struct_name, (char *)struct_name_tkn->data);
                        }
                        if (typedef_name_tkn)
                        {
                            sd->typedef_name = malloc(128);
                            strcpy(sd->typedef_name, (char *)typedef_name_tkn->data);
                        }
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

    return NULL;
}