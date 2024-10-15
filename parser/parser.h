
#ifndef PARSER_H
#define PARSER_H
#include <stdio.h>
#include "../codegen/codegen.h"

void printtabs(int depth);

struct apply_result_;

typedef struct parser_node_
{
    int type;
    void *data;
    void (*debug)(int, struct parser_node_ *);
    struct apply_result_ *(*apply)(struct parser_node_ *, context *ctx);
} parser_node;

typedef struct apply_result_ {
    char *code;
    parser_node *type;
    char *addr_code;
} apply_result;

apply_result *new_result(char *code, parser_node *type);

#endif