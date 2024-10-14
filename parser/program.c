

#include <stdlib.h>

#include "../lexer.h"
#include "parser.h"
#include "program.h"
#include "func.h"
#include "var_decl.h"
#include "../codegen/codegen.h"
#include "../linked_list.h"
#include "struct_def.h"

void program_debug(int depth, parser_node *node)
{
    node_program *prog = (node_program *)node->data;
    printtabs(depth);
    printf("Program(\n");
    for (int i = 0; i < prog->num_functions; i++)
    {
        parser_node *node = prog->functions[i];
        node->debug(depth + 1, node);
    }
    for (int i = 0; i < prog->num_struct_defs; i++)
    {
        parser_node *node = prog->struct_defs[i];
        node->debug(depth + 1, node);
    }
    printtabs(depth);
    printf(")\n");
}

apply_result *program_apply(parser_node *node, context *ctx)
{
    node_program *prog = (node_program *)node->data;
    for (int i = 0; i < prog->num_functions; i++)
    {
        ctx->symbol_table = new_linked_list();
        ctx->stack_size = 0;
        parser_node *node = prog->functions[i];
        node->apply(node, ctx);
        int total = ctx->stack_size;
        // 16 byte stack alignment
        total = total + (16 - total % 16);
        add_data(ctx, "__%s_size: equ %u", ((node_func_def *)node->data)->identity, total);
    }
    add_text(ctx, "extern exit");
    add_text(ctx, "global _start");
    add_text(ctx, "_start:");
    add_text(ctx, "call main");
    add_text(ctx, "mov rdi, 0");
    add_text(ctx, "call exit");
    return NULL;
}

parser_node *parse_program(typed_token **tkn_ptr)
{
    int func_count = 0;
    int struct_def_count = 0;
    int var_decl_count = 0;
    parser_node **funcs = (parser_node **)malloc(sizeof(parser_node *) * 128);
    parser_node **struct_defs = (parser_node **)malloc(sizeof(parser_node *) * 128);
    parser_node **var_decls = (parser_node **)malloc(sizeof(parser_node *) * 128);
    typed_token *tkn = *tkn_ptr;
    while (tkn)
    {
        if (tkn->type_id == TKN_EOF)
        {
            parser_node *node = (parser_node *)malloc(sizeof(parser_node));
            node->data = (void *)malloc(sizeof(node_program));
            node->debug = program_debug;
            node->apply = program_apply;
            node_program *prog = (node_program *)node->data;

            prog->num_functions = func_count;
            prog->functions = funcs;
            prog->num_struct_defs = struct_def_count;
            prog->struct_defs = struct_defs;
            return node;
        }
        parser_node *f = NULL;

        if ((f = parse_function(&tkn)))
        {
            funcs[func_count++] = f;
        }
        else if ((f = parse_struct_def(&tkn)))
        {
            struct_defs[struct_def_count++] = f;
        }
        else if ((f = parse_var_decl(&tkn)))
        {
            var_decls[var_decl_count++] = f;
        }
        else
        {
            return NULL;
        }
    }

    return NULL;
}