
#include "../libc.h"
#include "../lexer.h"
#include "../vec.h"
#include "parser.h"
#include "program.h"
#include "func.h"
#include "var_decl.h"
#include "../codegen/codegen.h"
#include "../linked_list.h"
#include "struct_def.h"
#include "type.h"
#include "extern.h"

void program_debug(int depth, parser_node *node)
{
    node_program *prog = (node_program *)node->data;
    printtabs(depth);
    printf("Program(\n");
    for (int i = 0; i < prog->externs->total; i++)
    {
        parser_node *node = (parser_node *)get_vec(prog->externs, i);
        node->debug(depth + 1, node);
    }
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
    int has_main_func = 0;
    node_program *prog = (node_program *)node->data;
    for (int i = 0; i < prog->externs->total; i++)
    {
        parser_node *node = (parser_node *)get_vec(prog->externs, i);
        node->apply(node, ctx);
    }
    for (int i = 0; i < prog->num_struct_defs; i++)
    {
        prog->struct_defs[i]->apply(prog->struct_defs[i], ctx);
    }
    for (int i = 0; i < prog->num_functions; i++)
    {
        ctx->symbol_table = new_linked_list();
        ctx->stack_size = 0;
        parser_node *node = prog->functions[i];
        char *func_name = ((node_func_def *)node->data)->identity;
        if (strcmp(func_name, "main") == 0)
        {
            has_main_func = 1;
        }
        node_func_def *nfd = ((node_func_def *)node->data);
        general_type *func_ret = ((node_type *)nfd->return_type->data)->type;
        linked_list *arg_types = new_linked_list();
        for (int j = 0; j < nfd->num_params; j++)
        {
            general_type *tp = ((node_type *)nfd->params[j]->data)->type;
            // tp->debug(tp, ctx, 0);
            add_to_list(arg_types, tp);
        }
        general_type *func_type = new_pointer_type(new_func_type(func_ret, arg_types));
        // func_type->debug(func_type, ctx, 0);
        new_global_symbol(ctx, func_name, func_name, func_type);
        node->apply(node, ctx);
        int total = ctx->stack_size;
        // 16 byte stack alignment
        total = total + (16 - total % 16);
        if (nfd->statements)
            add_data(ctx, "__%s_size: equ %u", ((node_func_def *)node->data)->identity, total);
    }
    if (has_main_func)
    {
        add_text(ctx, "extern exit");
        add_text(ctx, "global _start");
        add_text(ctx, "_start:");

        add_text(ctx, "; Pass argc and argv");
        add_text(ctx, "mov rdi, [rsp]");
        add_text(ctx, "mov rsi, rsp");
        add_text(ctx, "add rsi, 8");

        add_text(ctx, "call main");
        add_text(ctx, "mov rdi, rax");
        add_text(ctx, "call exit");
    }
    return NULL;
}

parser_node *parse_program(typed_token **tkn_ptr)
{
    int func_count = 0;
    int struct_def_count = 0;
    int var_decl_count = 0;
    parser_node **funcs = (parser_node **)malloc(sizeof(parser_node *) * 128);
    parser_node **struct_defs = (parser_node **)malloc(sizeof(parser_node *) * 128);
    vector *externs = initialize_vec(sizeof(parser_node *));
    vector *var_decls = initialize_vec(sizeof(parser_node *));
    typed_token *tkn = *tkn_ptr;
    while (tkn)
    {
        if (tkn->type_id == TKN_EOF)
        {
            parser_node *node = new_node(program_debug, program_apply, sizeof(node_program));
            node_program *prog = (node_program *)node->data;
            prog->externs = externs;
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
            push_vec(var_decls, f);
        }
        else if ((f = parse_extern(&tkn)))
        {
            push_vec(externs, f);
        }
        else
        {
            return NULL;
        }
    }

    return NULL;
}
