#include "../libc.h"
#include "codegen.h"
#include "../linked_list.h"
#include "stdarg.h"
#define UNUSED(x) (void)(x)

context new_context()
{
    context ctx;
    ctx.data = new_linked_list();
    ctx.text = new_linked_list();
    ctx.global_table = new_linked_list();
    ctx.symbol_table = new_linked_list();
    ctx.structs = new_linked_list();
    ctx.label_counter = 0;
    ctx.loop_end_labels = new_linked_list();
    ctx.loop_start_labels = new_linked_list();
    ctx.stack_size = 0;
    return ctx;
}

char *cc_asprintf(char *fmt, ...)
{
    char *txt = (char *)malloc(128);
    va_list args;
    va_start(args, fmt);
    vsprintf(txt, fmt, args);
    va_end(args);
    return txt;
}

void add_data(context *ctx, char *fmt, ...)
{
    char *txt = (char *)malloc(128);
    va_list args;
    va_start(args, fmt);
    vsprintf(txt, fmt, args);
    va_end(args);
    add_to_list(ctx->data, txt);
}

void add_text(context *ctx, char *fmt, ...)
{
    char *txt = (char *)malloc(128);
    va_list args;
    va_start(args, fmt);
    vsprintf(txt, fmt, args);
    va_end(args);
    add_to_list(ctx->text, txt);
}

void replace_text(context *ctx, char *a, char *b)
{
    list_node *curr = ctx->text->first;
    while (curr)
    {
        if (strcmp(curr->value, a) == 0)
        {
            curr->value = b;
        }
        curr = curr->next;
    }
}

symbol *find_symbol(context *ctx, char *name)
{
    list_node *curr = ctx->symbol_table->last;
    while (curr)
    {
        symbol *sym = (symbol *)curr->value;
        if (strcmp(sym->name, name) == 0)
        {
            return sym;
        }
        curr = curr->prev;
    }
    curr = ctx->global_table->last;
    while (curr)
    {
        symbol *sym = (symbol *)curr->value;
        if (strcmp(sym->name, name) == 0)
        {
            return sym;
        }
        curr = curr->prev;
    }
    fprintf(stderr, "Unknown identifier '%s'!\n", name);
    exit(1);
    return NULL;
}

char *new_label(context *ctx)
{
    char *name = (char *)malloc(128);
    sprintf(name, "__tmp_label_%u", ctx->label_counter);
    ctx->label_counter++;
    return name;
}

char *new_loop_end_label(context *ctx)
{
    char *name = new_label(ctx);
    int *label_id = malloc(sizeof(int));
    *label_id = ctx->label_counter - 1;
    add_to_list(ctx->loop_end_labels, label_id);
    return name;
}

char *get_current_loop_end_label_counter(context *ctx, char *name)
{
    if (ctx->loop_end_labels->count == 0)
    {
        fprintf(stderr, "Not inside loop\n");
        return NULL;
    }
    int value = *(int *)ctx->loop_end_labels->last->value;
    sprintf(name, "__tmp_label_%u", value);
    return name;
}

char *new_loop_start_label(context *ctx)
{
    char *name = new_label(ctx);
    int *label_id = malloc(sizeof(int));
    *label_id = ctx->label_counter - 1;
    add_to_list(ctx->loop_start_labels, label_id);

    add_text(ctx, "; enter loop");
    return name;
}

char *get_current_loop_start_label_counter(context *ctx, char *name)
{
    if (ctx->loop_start_labels->count == 0)
    {
        fprintf(stderr, "Not inside loop\n");
        return NULL;
    }
    int value = *(int *)ctx->loop_start_labels->last->value;
    sprintf(name, "__tmp_label_%u", value);
    return name;
}

void exit_loop(context *ctx)
{
    if (ctx->loop_end_labels->count > 0)
        pop_list(ctx->loop_end_labels);

    if (ctx->loop_start_labels->count > 0)
        pop_list(ctx->loop_start_labels);
    add_text(ctx, "; exit loop");
}

symbol *new_global_symbol(context *ctx, char *name, char *repl, general_type *type)
{
    symbol *newsym = (symbol *)malloc(sizeof(symbol));
    newsym->name = name;
    newsym->repl = repl;
    newsym->offset = 0;
    newsym->type = type;
    add_to_list(ctx->global_table, newsym);
    return newsym;
}

symbol *new_symbol(context *ctx, char *name, general_type *type)
{
    int sz = type->size(type, ctx);
    symbol *newsym = (symbol *)malloc(sizeof(symbol));
    newsym->name = name;
    newsym->offset = 0;
    newsym->type = type;
    if (ctx->symbol_table->last)
    {
        symbol *lastsym = ((symbol *)ctx->symbol_table->last->value);
        newsym->offset = lastsym->offset + lastsym->type->size(lastsym->type, ctx);
    }
    newsym->repl = cc_asprintf("[rbp-%u]", newsym->offset + sz);
    add_to_list(ctx->symbol_table, newsym);
    ctx->stack_size += sz;
    return newsym;
}

symbol *new_temp_symbol(context *ctx, general_type *type)
{
    return new_symbol(ctx, "", type);
}

context_struct *find_struct(context *ctx, char *name)
{
    list_node *curr = ctx->structs->last;
    while (curr)
    {
        context_struct *s = (context_struct *)curr->value;
        if (s->struct_name)
        {
            if (strcmp(s->struct_name, name) == 0)
            {
                return s;
            }
        }
        if (s->typedef_name)
        {
            if (strcmp(s->typedef_name, name) == 0)
            {
                return s;
            }
        }
        curr = curr->prev;
    }
    fprintf(stderr, "Unknown struct '%s'!\n", name);
    exit(1);
    return NULL;
}
void new_struct(context *ctx, context_struct *s)
{
    add_to_list(ctx->structs, s);
}

void printtabs(int depth);
void primitive_type_debug(general_type *self, int depth)
{
    primitive_type *p = (primitive_type *)self->data;
    printtabs(depth);
    printf("%s\n", p->type_name);
}

int primitive_type_size(general_type *self, context *ctx)
{
    UNUSED(ctx);
    primitive_type *p = (primitive_type *)self->data;
    if (strcmp(p->type_name, "TKN_INT") == 0)
        return 8;
    if (strcmp(p->type_name, "TKN_CHAR") == 0)
        return 1;
    if (strcmp(p->type_name, "TKN_VOID") == 0)
        return 0;
    fprintf(stderr, "Unknown type '%s'!\n", p->type_name);
    exit(1);
    return 0;
}

void pointer_type_debug(general_type *self, int depth)
{
    pointer_type *p = (pointer_type *)self->data;
    printtabs(depth);
    printf("Pointer of:\n");
    p->of->debug(p->of, depth + 1);
}

int pointer_type_size(general_type *self, context *ctx)
{
    UNUSED(self);
    UNUSED(ctx);
    return 8;
}

void func_type_debug(general_type *self, int depth)
{
    func_type *p = (func_type *)self->data;
    printtabs(depth);
    printf("Func:\n");
    printtabs(depth + 1);
    printf("Returns:\n");
    p->return_type->debug(p->return_type, depth + 2);
    printtabs(depth + 1);
    printf("Args:\n");
    list_node *curr = p->arg_types->first;
    while (curr)
    {
        general_type *tp = ((general_type *)curr->value);
        tp->debug(tp, depth + 2);
        curr = curr->next;
    }
}

int func_type_size(general_type *self, context *ctx)
{
    UNUSED(self);
    UNUSED(ctx);
    fprintf(stderr, "Function-type has no size!\n");
    exit(1);
}

void struct_type_debug(general_type *self, int depth)
{
    struct_type *p = (struct_type *)self->data;
    printtabs(depth);
    printf("struct %s\n", p->struct_name);
}

int struct_type_size(general_type *self, context *ctx)
{
    struct_type *p = (struct_type *)self->data;
    context_struct *s = find_struct(ctx, p->struct_name);
    int sz = 0;
    for (int i = 0; i < s->num_fields; i++)
    {
        sz += s->fields[i]->size(s->fields[i], ctx);
    }
    return sz;
}

general_type *new_primitive_type(char *type_name)
{
    general_type *ret = (general_type *)malloc(sizeof(general_type));
    primitive_type *data = (primitive_type *)malloc(sizeof(primitive_type));
    data->type_name = type_name;
    ret->kind = TYPE_PRIMITIVE;
    ret->data = data;
    ret->debug = primitive_type_debug;
    ret->size = primitive_type_size;
    return ret;
}

general_type *new_pointer_type(general_type *of)
{
    general_type *ret = (general_type *)malloc(sizeof(general_type));
    pointer_type *data = (pointer_type *)malloc(sizeof(pointer_type));
    data->of = of;
    ret->kind = TYPE_POINTER;
    ret->data = data;
    ret->debug = pointer_type_debug;
    ret->size = pointer_type_size;
    return ret;
}

general_type *new_func_type(general_type *return_type, linked_list *arg_types)
{
    general_type *ret = (general_type *)malloc(sizeof(general_type));
    func_type *data = (func_type *)malloc(sizeof(func_type));
    data->return_type = return_type;
    data->arg_types = arg_types;
    ret->kind = TYPE_FUNC;
    ret->data = data;
    ret->debug = func_type_debug;
    ret->size = func_type_size;
    return ret;
}

general_type *new_struct_type(char *struct_name)
{
    general_type *ret = (general_type *)malloc(sizeof(general_type));
    struct_type *data = (struct_type *)malloc(sizeof(struct_type));
    data->struct_name = struct_name;
    ret->kind = TYPE_STRUCT;
    ret->data = data;
    ret->debug = struct_type_debug;
    ret->size = struct_type_size;
    return ret;
}

int types_equal(general_type *a, general_type *b, context *ctx)
{
    // Special case for handling assigning NULL to pointers
    if (a->kind == TYPE_POINTER)
    {
        if (b->kind == TYPE_PRIMITIVE)
        {
            char *type_name = ((primitive_type *)b->data)->type_name;
            if (strcmp(type_name, "TKN_INT") == 0)
                return 1;
        }
    }

    if ((a->debug != b->debug) || (a->size != b->size))
    {
        return 0;
    }
    if (a->size == primitive_type_size)
    {
        char *a_name = ((primitive_type *)a->data)->type_name;
        char *b_name = ((primitive_type *)b->data)->type_name;
        return strcmp(a_name, b_name) == 0;
    }
    else if (a->size == struct_type_size)
    {
        char *a_name = ((struct_type *)a->data)->struct_name;
        char *b_name = ((struct_type *)b->data)->struct_name;
        context_struct *a_struct = find_struct(ctx, a_name);
        context_struct *b_struct = find_struct(ctx, b_name);
        if (!a_struct)
            return 0;
        if (!b_struct)
            return 0;
        return a_struct->struct_id == b_struct->struct_id;
    }
    else if (a->size == pointer_type_size)
    {
        general_type *a_of = ((pointer_type *)a->data)->of;
        general_type *b_of = ((pointer_type *)b->data)->of;
        return types_equal(a_of, b_of, ctx);
    }
    else if (a->size == func_type_size)
    {
        general_type *a_ret = ((func_type *)a->data)->return_type;
        general_type *b_ret = ((func_type *)b->data)->return_type;
        if (!types_equal(a_ret, b_ret, ctx))
            return 0;
        linked_list *a_args = ((func_type *)a->data)->arg_types;
        linked_list *b_args = ((func_type *)b->data)->arg_types;
        if (a_args->count != b_args->count)
            return 0;
        list_node *a_curr = a_args->first;
        list_node *b_curr = b_args->first;
        for (int i = 0; i < a_args->count; i++)
        {
            general_type *a_arg = (general_type *)a_curr->value;
            general_type *b_arg = (general_type *)b_curr->value;
            if (!types_equal(a_arg, b_arg, ctx))
                return 0;
            a_curr = a_curr->next;
            b_curr = b_curr->next;
        }
        return 1;
    }
    return 0;
}

char *reg_a(general_type *tp, context *ctx)
{
    int sz = tp->size(tp, ctx);
    if (sz == 1)
        return "al";
    else if (sz == 8)
        return "rax";
    return NULL;
}

char *reg_b(general_type *tp, context *ctx)
{
    int sz = tp->size(tp, ctx);
    if (sz == 1)
        return "bl";
    else if (sz == 8)
        return "rbx";
    return NULL;
}

char *reg_typed(char *reg, general_type *tp, context *ctx)
{
    int sz = tp->size(tp, ctx);
    if (strcmp(reg, "rdi") == 0)
    {
        if (sz == 8)
            return "rdi";
        else if (sz == 4)
            return "edi";
        else if (sz == 2)
            return "di";
        else if (sz == 1)
            return "dil";
    }
    else if (strcmp(reg, "rsi") == 0)
    {
        if (sz == 8)
            return "rsi";
        else if (sz == 4)
            return "esi";
        else if (sz == 2)
            return "si";
        else if (sz == 1)
            return "sil";
    }
    else if (strcmp(reg, "rdx") == 0)
    {
        if (sz == 8)
            return "rdx";
        else if (sz == 4)
            return "edx";
        else if (sz == 2)
            return "dx";
        else if (sz == 1)
            return "dl";
    }
    else if (strcmp(reg, "rcx") == 0)
    {
        if (sz == 8)
            return "rcx";
        else if (sz == 4)
            return "ecx";
        else if (sz == 2)
            return "cx";
        else if (sz == 1)
            return "cl";
    }
    else if (strcmp(reg, "r8") == 0)
    {
        if (sz == 8)
            return "r8";
        else if (sz == 4)
            return "r8d";
        else if (sz == 2)
            return "r8w";
        else if (sz == 1)
            return "r8b";
    }
    else if (strcmp(reg, "r9") == 0)
    {
        if (sz == 8)
            return "r9";
        else if (sz == 4)
            return "r9d";
        else if (sz == 2)
            return "r9w";
        else if (sz == 1)
            return "r9b";
    }
    else
    {
        fprintf(stderr, "Unknown register %s!\n", reg);
        exit(1);
    }
    fprintf(stderr, "Unknown size %u!\n", sz);
    exit(1);
    return "";
}