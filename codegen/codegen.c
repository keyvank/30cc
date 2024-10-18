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

int size_of(context *ctx, context_type *tp)
{
    int PTR_SIZE = 8;
    if (tp->num_pointing > 0)
    {
        return PTR_SIZE;
    }
    else
    {
        if (!tp->is_struct)
        {
            if (strcmp(tp->name, "TKN_INT") == 0)
            {
                return 8;
            }
            if (strcmp(tp->name, "TKN_CHAR") == 0)
            {
                return 1;
            }
            fprintf(stderr, "Unknown type '%s'!\n", tp->name);
            exit(1);
            return 0;
        }
        else
        {
            context_struct *cs = find_struct(ctx, tp->name);
            if (cs)
            {
                int ret = 0;
                for (int i = 0; i < cs->num_fields; i++)
                {
                    ret += size_of(ctx, cs->fields[i]);
                }
                return ret;
            }
            else
            {
                fprintf(stderr, "Cannot struct '%s'!\n", tp->name);
                return 0;
            }
        }
    }
    return 0;
}
context_type *new_type(char *name,
                       int num_pointing,
                       int is_struct,
                       int dim,
                       int *dims)
{
    context_type *tp = (context_type *)malloc(sizeof(context_type));
    tp->name = name;
    tp->num_pointing = num_pointing;
    tp->is_struct = is_struct;
    tp->dim = dim;
    tp->dims = dims;
    return tp;
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