

#include <stdlib.h>

#include "../lexer.h"
#include "parser.h"
#include "program.h"
#include "func.h"

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
            node->type = NODE_PROGRAM;
            node->data = (void *)malloc(sizeof(node_program));
            node->debug = program_debug;
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