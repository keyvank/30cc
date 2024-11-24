#ifndef CONTEXT_H
#define CONTEXT_H

#include "../linked_list.h"

typedef struct
{
    linked_list *data;
    linked_list *text;
    linked_list *symbol_table;
    linked_list *global_table;
    linked_list *structs;
    int label_counter;
    linked_list *loop_end_labels;
    linked_list *loop_start_labels;
    int stack_size;
} context;

typedef struct general_type_
{
    int kind;
    void *data;
    void (*debug)(struct general_type_ *self, int depth);
    int (*size)(struct general_type_ *self, context *ctx);
} general_type;

typedef struct
{
    int struct_id;
    char *struct_name;
    char *typedef_name;
    int num_fields;
    char **field_names;
    general_type **fields;
} context_struct;

#define TYPE_PRIMITIVE 0
#define TYPE_POINTER 1
#define TYPE_FUNC 2
#define TYPE_STRUCT 3

typedef struct
{
    char *type_name;
} primitive_type;

typedef struct
{
    char *struct_name;
} struct_type;

typedef struct
{
    general_type *of;
} pointer_type;

typedef struct
{
    general_type *return_type;
    linked_list *arg_types;
} func_type;

general_type *new_primitive_type(char *type_name);
general_type *new_struct_type(char *struct_name);
general_type *new_pointer_type(general_type *of);
general_type *new_func_type(general_type *return_type, linked_list *arg_types);
int types_equal(general_type *a, general_type *b, context *ctx);

context new_context();
void add_text(context *ctx, char *fmt, ...);
void add_data(context *ctx, char *fmt, ...);
void replace_text(context *ctx, char *a, char *b);

typedef struct
{
    char *name;
    general_type *type;
    int offset;
    char *repl;
} symbol;

char *cc_asprintf(char *fmt, ...);
symbol *find_symbol(context *tab, char *name);
symbol *new_symbol(context *ctx, char *name, general_type *type);
symbol *new_global_symbol(context *ctx, char *name, char *repl, general_type *type);
symbol *new_temp_symbol(context *ctx, general_type *type);
char *new_label(context *ctx);
char *new_loop_end_label(context *ctx);
char *get_current_loop_end_label_counter(context *ctx, char* name);
char *new_loop_start_label(context *ctx);
char *get_current_loop_start_label_counter(context *ctx, char* name);
void exit_loop(context *ctx);

context_struct *find_struct(context *ctx, char *name);
void new_struct(context *ctx, context_struct *s);

char *reg_a(general_type *tp, context *ctx);
char *reg_b(general_type *tp, context *ctx);

void debug_reg(char *reg,context *ctx);
void halt(context *ctx);
#endif
