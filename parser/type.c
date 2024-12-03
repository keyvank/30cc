#include "../libc.h"
#include "../lexer.h"
#include "parser.h"
#include "type.h"

void type_debug(int depth, parser_node *node)
{
    node_type *tp = (node_type *)node->data;
    printtabs(depth);
    printf("Type(Name: %s):\n", tp->name);
    tp->type->debug(tp->type, depth + 1);
}

parser_node *parse_type(typed_token **tkns_ptr, int allow_naming)
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
        par->name = NULL;
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

        par->type = new_struct_type(struct_name_tkn->data);
        par->name = NULL;
        tkn = struct_name_tkn->next;
    }

    if (node != NULL)
    {
        node_type *par = (node_type *)node->data;
        while (tkn->type_id == TKN_STAR)
        {
            tkn = tkn->next;
            par->type = new_pointer_type(par->type);
            par->name = NULL;
        }
    }

    if (node != NULL && tkn->type_id == TKN_L_PAREN)
    {
        int num_fun_ptr = 0;
        char *fun_name = NULL;

        tkn = tkn->next;
        while (tkn->type_id == TKN_STAR)
        {
            num_fun_ptr++;
            tkn = tkn->next;
        }

        if (allow_naming && tkn->type_id == TKN_ID)
        {
            fun_name = (char *)tkn->data;
            tkn = tkn->next;
        }

        if (tkn->type_id == TKN_R_PAREN)
        {
            tkn = tkn->next;
            if (tkn->type_id == TKN_L_PAREN)
            {
                tkn = tkn->next;
                parser_node **arg_types = (parser_node **)malloc(sizeof(parser_node *) * 128);
                int arg_count = 0;
                while (1)
                {
                    parser_node *arg_type = parse_type(&tkn, 1);
                    if (arg_type)
                    {
                        arg_types[arg_count++] = arg_type;
                    }
                    if (tkn->type_id == TKN_R_PAREN)
                    {
                        tkn = tkn->next;
                        break;
                    }
                    else if (arg_type && tkn->type_id == TKN_COMMA)
                    {
                        tkn = tkn->next;
                        continue;
                    }
                    else
                    {
                        return NULL;
                    }
                }
                node_type *par = (node_type *)node->data;
                linked_list *args = new_linked_list();
                for (int i = 0; i < arg_count; i++)
                {
                    add_to_list(args, ((node_type *)arg_types[i]->data)->type);
                }
                par->type = new_func_type(par->type, args);
                for (int i = 0; i < num_fun_ptr; i++)
                    par->type = new_pointer_type(par->type);
                par->name = fun_name;
            }
        }
    }

    if (allow_naming && tkn->type_id == TKN_ID)
    {
        node_type *par = (node_type *)node->data;
        par->name = (char *)tkn->data;
        tkn = tkn->next;
    }

    if (node)
    {
        *tkns_ptr = tkn;
    }

    return node;
}
