#ifndef CONTEXT_H
#define CONTEXT_H

#include "../linked_list.h"

typedef struct
{
    char *name;
    int num_pointing;
    int is_struct;
    int dim;
    int *dims;
} context_type;

typedef struct
{
    char *name;
    int num_fields;
    context_type **fields;
} context_struct;

typedef struct
{
    linked_list data;
    linked_list text;
    linked_list symbol_table;
    linked_list global_table;
    linked_list structs;
    int label_counter;
    int stack_size;
} context;

typedef struct general_type_
{
    void *data;
    void (*debug)(struct general_type_ *self, context *ctx, int depth);
    int (*size)(struct general_type_ *self, context *ctx);
} general_type;

typedef struct
{
    char *type_name;
} primitive_type;

typedef struct
{
    int num_fields;
    char **field_names;
    general_type **fields;
} struct_type;

typedef struct
{
    general_type *of;
} pointer_type;

general_type *new_primitive_type(char *type_name);
general_type *new_struct_type(int num_fields, char **field_names, general_type **fields);
general_type *new_pointer_type(general_type *of);

context new_context();
void add_text(context *ctx, char *fmt, ...);
void add_data(context *ctx, char *fmt, ...);

typedef struct
{
    char *name;
    int size;
    int offset;
    char *repl;
} symbol;

char *cc_asprintf(char *fmt, ...);
symbol *find_symbol(context *tab, char *name);
symbol *new_symbol(context *ctx, char *name, int sz);
symbol *new_global_symbol(context *ctx, char *name, char *repl);
symbol *new_temp_symbol(context *ctx, int sz);
char *new_label(context *ctx);

context_struct *find_struct(context *ctx, char *name);
void new_struct(context *ctx, context_struct *s);

int size_of(context *ctx, context_type *tp);
context_type *new_type(char *name,
                       int num_pointing,
                       int is_struct,
                       int dim,
                       int *dims);
#endif
