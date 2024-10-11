#include <stdio.h>
#include <stdarg.h>

#include "codegen.h"
#include "../linked_list.h"

context new_context()
{
    context ctx;
    ctx.data = new_linked_list();
    ctx.text = new_linked_list();
    ctx.symbol_table = new_linked_list();
    ctx.label_counter = 0;
    return ctx;
}

char *asprintf(char *fmt, ...)
{
    char *txt = malloc(128);
    va_list args;
    va_start(args, fmt);
    vsprintf(txt, fmt, args);
    va_end(args);
    return txt;
}

void add_text(context *ctx, char *fmt, ...)
{
    char *txt = malloc(128);
    va_list args;
    va_start(args, fmt);
    vsprintf(txt, fmt, args);
    va_end(args);
    add_to_list(&ctx->text, txt);
}

symbol *find_symbol(context *ctx, char *name)
{
    list_node *curr = ctx->symbol_table.first;
    while (curr)
    {
        symbol *sym = (symbol *)curr->value;
        if (strcmp(sym->name, name) == 0)
        {
            return sym;
        }
        curr = curr->next;
    }
    return NULL;
}

char *new_label(context *ctx)
{
    char *name = malloc(128);
    sprintf(name, "__tmp_label_%u", ctx->label_counter);
    ctx->label_counter++;
    return name;
}

symbol *new_symbol(context *ctx, char *name, int sz)
{
    symbol *newsym = (symbol *)malloc(sizeof(symbol));
    newsym->name = name;
    newsym->offset = 0;
    newsym->size = sz;

    list_node *curr = ctx->symbol_table.first;
    if (!curr)
    {
        add_to_list(&ctx->symbol_table, newsym);
        return newsym;
    }
    int offset = 0;
    while (curr)
    {
        symbol *sym = (symbol *)curr->value;
        if (strcmp(sym->name, name) == 0)
        {
            printf("Symbol already there!\n");
            exit(1);
        }
        offset += sym->size;
        curr = curr->next;
    }
    newsym->offset = offset;
    add_to_list(&ctx->symbol_table, newsym);
    return newsym;
}

symbol *new_temp_symbol(context *ctx, int sz)
{
    list_node *curr = ctx->symbol_table.first;
    int cnt = 0;
    while (curr)
    {
        cnt += 1;
        curr = curr->next;
    }
    char *name = malloc(128);
    sprintf(name, "__tmp_sym_%u", cnt);
    return new_symbol(ctx, name, sz);
}