

#include <stdlib.h>
#include <string.h>

#include "../../lexer.h"
#include "../parser.h"
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

apply_result *literal_apply(parser_node *node, context *ctx)
{
    node_literal *lit = (node_literal *)node->data;
    if (lit->type == TKN_LIT_STR)
    {
        char *varname = cc_asprintf("__temp_str_%u", ctx->data.count);
        add_data(ctx, "%s db `%s`, 0", varname, escape(lit->value));
        return new_result(varname, new_pointer_type(new_primitive_type("TKN_CHAR")));
    }
    if (lit->type == TKN_LIT_INT)
    {
        return new_result(cc_asprintf("%u", *((int *)lit->value)), new_primitive_type("TKN_INT"));
    }
    if (lit->type == TKN_LIT_CHAR)
    {
        return new_result(cc_asprintf("%u", (int)(*((char *)lit->value))), new_primitive_type("TKN_CHAR"));
    }
    return NULL;
}

void literal_debug(int depth, parser_node *node)
{
    node_literal *lit = (node_literal *)node->data;
    printtabs(depth);
    if (lit->type == TKN_LIT_STR)
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
    if (tkn->type_id == TKN_LIT_STR || tkn->type_id == TKN_LIT_INT || tkn->type_id == TKN_LIT_CHAR)
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
        if (lit->type == TKN_LIT_STR)
        {
            lit->value = malloc(128);
            strcpy(lit->value, val_tkn->data);
        }
        else if (lit->type == TKN_LIT_INT)
        {
            lit->value = malloc(sizeof(int));
            *((int *)lit->value) = *((int *)val_tkn->data);
        }
        else if (lit->type == TKN_LIT_CHAR)
        {
            lit->value = malloc(sizeof(char));
            *((char *)lit->value) = *((char *)val_tkn->data);
        }
        else
        {
            return NULL;
        }

        return node;
    }

    return NULL;
}
