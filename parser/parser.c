#include <stdlib.h>

#include "parser.h"

void printtabs(int depth)
{
    for (int i = 0; i < depth; i++)
    {
        printf("  ");
    }
}

apply_result *new_result(char *code, parser_node *type) {
    apply_result *ret = (apply_result*)malloc(sizeof(apply_result));
    ret->code = code;
    ret->type = type;
    return ret;
}