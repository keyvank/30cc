

#include <stdlib.h>

#include "../lexer.h"
#include "parser.h"
#include "program.h"
#include "func.h"
#include "../codegen/codegen.h"
#include "../linked_list.h"

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
    printtabs(depth);
    printf(")\n");
}

char *program_apply(parser_node *node, context *ctx)
{
    node_program *prog = (node_program *)node->data;
    for (int i = 0; i < prog->num_functions; i++)
    {
        parser_node *node = prog->functions[i];
        node->apply(node, ctx);
    }
    add_to_list(&ctx->text, "extern exit");
    add_to_list(&ctx->text, "global _start");
    add_to_list(&ctx->text, "_start:");
    add_to_list(&ctx->text, "call main");
    add_to_list(&ctx->text, "mov rdi, 0");
    add_to_list(&ctx->text, "call exit");
    return NULL;
}

parser_node *parse_program(typed_token **tkn_ptr)
{
    int func_count = 0;
    parser_node **funcs = (parser_node **)malloc(sizeof(parser_node *) * 128);
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
            return node;
        }
        parser_node *f = parse_function(&tkn);
        if (f)
        {
            funcs[func_count++] = f;
        }
        else
        {
            return NULL;
        }
    }

    return NULL;
}