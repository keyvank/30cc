

#include <stdlib.h>

#include "../lexer.h"
#include "parser.h"
#include "literal.h"

char *escape(char *inp)
{
    char *ret = malloc(128);
    int cnt = 0;
    while (*inp)
    {
        char c = *inp;
        if (c == '\n')
        {
            ret[cnt++] = '\\';
            ret[cnt++] = 'n';
        }
        else
        {
            ret[cnt++] = c;
        }
        inp++;
    }
    ret[cnt] = 0;
    return ret;
}

char *literal_apply(parser_node *node, context *ctx)
{
    node_literal *lit = (node_literal *)node->data;
    if (lit->type == TKN_STR)
    {
        char *varname = malloc(128);
        sprintf(varname, "__temp_str_%u", ctx->data.count);

        char *str = malloc(128);
        sprintf(str, "%s db `%s`, 0", varname, escape(lit->value));
        add_to_list(&ctx->data, str);

        return varname;
    }
    return lit->value;
}

void literal_debug(int depth, parser_node *node)
{
    node_literal *lit = (node_literal *)node->data;
    printtabs(depth);
    if (lit->type == TKN_STR)
        printf("Literal(Type: %d, Value: %s)\n", lit->type, lit->value);
    else if (lit->type == TKN_LIT_INT)
    {
        printf("Literal(Type: %d, Value: %u)\n", lit->type, *((int *)lit->value));
    }
    else
    {
        printf("Literal(Type: %d)\n", lit->type);
    }
}

parser_node *parse_literal(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    if (tkn->type_id == TKN_STR || tkn->type_id == TKN_LIT_INT)
    {
        typed_token *val_tkn = tkn;
        tkn = tkn->next;
        *tkns_ptr = tkn;

        parser_node *node = (parser_node *)malloc(sizeof(parser_node));
        node->data = (void *)malloc(sizeof(node_literal));
        node->debug = literal_debug;
        node->apply = literal_apply;
        node_literal *lit = (node_literal *)node->data;

        lit->type = val_tkn->type_id;
        if (lit->type == TKN_STR)
        {
            lit->value = malloc(128);
            strcpy(lit->value, val_tkn->data);
        }
        else if (lit->type == TKN_LIT_INT)
        {
            lit->value = malloc(sizeof(int));
            *((int *)lit->value) = *((int *)val_tkn->data);
        }
        else
        {
            return NULL;
        }

        return node;
    }

    return NULL;
}