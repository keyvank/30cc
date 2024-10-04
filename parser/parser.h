
#ifndef PARSER_H
#define PARSER_H
#include <stdio.h>
#include "../codegen/codegen.h"

void printtabs(int depth);

typedef struct parser_node_
{
    int type;
    void *data;
    void (*debug)(int, struct parser_node_ *);
    char *(*apply)(struct parser_node_ *, context *ctx);
} parser_node;

#endif