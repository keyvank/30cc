#ifndef CONTEXT_H
#define CONTEXT_H

#include "../linked_list.h"

typedef struct
{
    linked_list data;
    linked_list text;
    linked_list symbol_table;
    int label_counter;
} context;

context new_context();
void add_text(context *ctx, char *fmt, ...);

typedef struct
{
    char *name;
    int size;
    int offset;
} symbol;

char *asprintf(char *fmt, ...);
symbol *find_symbol(context *tab, char *name);
symbol *new_symbol(context *ctx, char *name, int sz);
symbol *new_temp_symbol(context *ctx, int sz);
char *new_label(context *ctx);
#endif