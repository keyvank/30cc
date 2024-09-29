
#ifndef PARSER_H
#define PARSER_H
#include <stdio.h>

void printtabs(int depth);

typedef struct parser_node_
{
    int type;
    void *data;
    void (*debug)(int, struct parser_node_ *);
} parser_node;

#define NODE_PROGRAM 1
#define NODE_FUNCTION 2
#define NODE_TYPE 3
#define NODE_PARAM 4
#define NODE_VAR_DECL 5
#define NODE_ASSIGN 6

#endif