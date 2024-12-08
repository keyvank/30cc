#include "../libc.h"
#include "parser.h"

void printtabs(int depth)
{
    for (int i = 0; i < depth; i++)
    {
        printf("  ");
    }
}

apply_result *new_result(char *code, general_type *type)
{
    apply_result *ret = (apply_result *)malloc(sizeof(apply_result));
    ret->code = code;
    ret->type = type;
    ret->addr_code = NULL;
    return ret;
}

parser_node *new_node(void (*debug)(int, parser_node *), apply_result *(*apply)(parser_node *, context *), int sz)
{
    parser_node *node = (parser_node *)malloc(sizeof(parser_node));
    node->data = malloc(sz);
    node->debug = debug;
    node->apply = apply;
    return node;
}