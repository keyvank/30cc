#ifndef CONTEXT_H
#define CONTEXT_H

#include "../linked_list.h"

typedef struct
{
    linked_list data;
    linked_list text;
} context;

context new_context();
char *compile(context *ctx);

#endif