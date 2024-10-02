
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

#endif