#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <string.h>

#include "codegen.h"
#include "../linked_list.h"

context new_context()
{
    context ctx;
    ctx.data = new_linked_list();
    ctx.text = new_linked_list();
    ctx.global_table = new_linked_list();
    ctx.symbol_table = new_linked_list();
    ctx.structs = new_linked_list();
    ctx.label_counter = 0;
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
    add_to_list(&ctx->data, txt);
}

void add_text(context *ctx, char *fmt, ...)
{
    char *txt = (char *)malloc(128);
    va_list args;
    va_start(args, fmt);
    vsprintf(txt, fmt, args);
    va_end(args);
    add_to_list(&ctx->text, txt);
}

symbol *find_symbol(context *ctx, char *name)
{
    list_node *curr = ctx->symbol_table.last;
    while (curr)
    {
        symbol *sym = (symbol *)curr->value;
        if (strcmp(sym->name, name) == 0)
        {
            return sym;
        }
        curr = curr->prev;
    }
    curr = ctx->global_table.last;
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

symbol *new_global_symbol(context *ctx, char *name, char *repl)
{
    symbol *newsym = (symbol *)malloc(sizeof(symbol));
    newsym->name = name;
    newsym->repl = repl;
    newsym->offset = 0;
    add_to_list(&ctx->global_table, newsym);
    return newsym;
}

symbol *new_symbol(context *ctx, char *name, int sz)
{
    symbol *newsym = (symbol *)malloc(sizeof(symbol));
    newsym->name = name;
    newsym->offset = 0;
    newsym->size = sz;
    if (ctx->symbol_table.last)
    {
        symbol *lastsym = ((symbol *)ctx->symbol_table.last->value);
        newsym->offset = lastsym->offset + lastsym->size;
    }
    newsym->repl = cc_asprintf("[rsp+%u]", newsym->offset);
    add_to_list(&ctx->symbol_table, newsym);
    ctx->stack_size += sz;
    return newsym;
}

symbol *new_temp_symbol(context *ctx, int sz)
{
    return new_symbol(ctx, "", sz);
}

context_struct *find_struct(context *ctx, char *name)
{
    list_node *curr = ctx->structs.last;
    while (curr)
    {
        context_struct *s = (context_struct *)curr->value;
        if (strcmp(s->name, name) == 0)
        {
            return s;
        }
        curr = curr->prev;
    }
    fprintf(stderr, "Unknown struct '%s'!\n", name);
    exit(1);
    return NULL;
}
void new_struct(context *ctx, context_struct *s)
{
    add_to_list(&ctx->structs, s);
}

void printtabs(int depth);
void primitive_type_debug(general_type *self, context *ctx, int depth)
{
    primitive_type *p = (primitive_type *)self->data;
    printtabs(depth);
    printf("%s\n", p->type_name);
}

int primitive_type_size(general_type *self, context *ctx)
{
    primitive_type *p = (primitive_type *)self->data;
    if (strcmp(p->type_name, "TKN_INT") == 0)
        return 8;
    if (strcmp(p->type_name, "TKN_CHAR") == 0)
        return 1;
    fprintf(stderr, "Unknown type '%s'!\n", p->type_name);
    exit(1);
    return 0;
}

void pointer_type_debug(general_type *self, context *ctx, int depth)
{
    pointer_type *p = (pointer_type *)self->data;
    printtabs(depth);
    printf("Pointer of:\n");
    p->of->debug(p->of, ctx, depth + 1);
}

int pointer_type_size(general_type *self, context *ctx)
{
    return 8;
}

void struct_type_debug(general_type *self, context *ctx, int depth)
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
    ret->data = data;
    ret->debug = pointer_type_debug;
    ret->size = pointer_type_size;
    return ret;
}

general_type *new_struct_type(char *struct_name)
{
    general_type *ret = (general_type *)malloc(sizeof(general_type));
    struct_type *data = (struct_type *)malloc(sizeof(struct_type));
    data->struct_name = struct_name;
    ret->data = data;
    ret->debug = struct_type_debug;
    ret->size = struct_type_size;
    return ret;
}