#include <stdio.h>

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

int find_symbol(context *ctx, char *name)
{
    list_node *curr = ctx->symbol_table.first;
    while (curr)
    {
        symbol *sym = (symbol *)curr->value;
        if (strcmp(sym->name, name) == 0)
        {
            return sym->offset;
        }
        curr = curr->next;
    }
    return -1;
}

char *new_label(context *ctx)
{
    char *name = malloc(128);
    sprintf(name, "__tmp_label_%u", ctx->label_counter);
    ctx->label_counter++;
    return name;
}

int new_symbol(context *ctx, char *name)
{
    list_node *curr = ctx->symbol_table.first;

    if (!curr)
    {
        symbol *newsym = (symbol *)malloc(sizeof(symbol));
        newsym->name = name;
        newsym->offset = 0;
        add_to_list(&ctx->symbol_table, newsym);
        return 0;
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
        offset = sym->offset;
        curr = curr->next;
    }
    symbol *newsym = (symbol *)malloc(sizeof(symbol));
    newsym->name = name;
    newsym->offset = offset + 8;
    add_to_list(&ctx->symbol_table, newsym);
    return newsym->offset;
}

int new_temp_symbol(context *ctx)
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
    return new_symbol(ctx, name);
}