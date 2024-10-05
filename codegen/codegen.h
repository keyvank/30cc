#ifndef CONTEXT_H
#define CONTEXT_H

#include "../linked_list.h"

typedef struct
{
    linked_list data;
    linked_list text;
    linked_list symbol_table;
} context;

context new_context();

typedef struct
{
    char *name;
    int offset;
} symbol;

int find_symbol(context *tab, char *name);
int new_symbol(context *ctx, char *name);
int new_temp_symbol(context *ctx);

#endif