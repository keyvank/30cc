
#ifndef PARSER_H
#define PARSER_H
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

typedef struct apply_result_
{
    char *code;
    general_type *type;
    char *addr_code;
} apply_result;

apply_result *new_result(char *code, general_type *type);

parser_node *new_node(void (*debug)(int, parser_node *), apply_result *(*apply)(parser_node *, context *), int sz);

#endif