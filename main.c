#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include "lexer.h"

char *read_source_file(FILE *fp);
/**
 * free() ignores NULL pointer by default. set each pointer to NULL
 * after calling free() to avoid double free error.
 */
#define xfree(p)    \
    do              \
    {               \
        free((p));  \
        (p) = NULL; \
    } while (0)

#define NODE_PROGRAM 1
#define NODE_FUNCTION 2
#define NODE_STATEMENT 3

typedef struct parser_node_
{
    int node_type;
    void *node_data;
    void (*node_debug)(int, struct parser_node_ *);
} parser_node;

typedef struct
{

} node_statement;

typedef struct
{
    int num_statements;
    parser_node **statements;
} node_function;

typedef struct
{
    int num_functions;
    parser_node **functions;
} node_program;

void printtabs(int depth)
{
    for (int i = 0; i < depth; i++)
    {
        printf("  ");
    }
}

void program_debug(int depth, parser_node *node)
{
    node_program *prog = (node_program *)node->node_data;
    printtabs(depth);
    printf("Program(\n");
    for (int i = 0; i < prog->num_functions; i++)
    {
        parser_node *node = prog->functions[i];
        node->node_debug(depth + 1, node);
    }
    printtabs(depth);
    printf(")\n");
}
void function_debug(int depth, parser_node *node)
{
    node_function *func = (node_function *)node->node_data;
    printtabs(depth);
    printf("Function(\n");
    for (int i = 0; i < func->num_statements; i++)
    {
        parser_node *node = func->statements[i];
        node->node_debug(depth + 1, node);
    }
    printtabs(depth);
    printf(")\n");
}
void statement_debug(int depth, parser_node *node)
{
    node_program *stmt = (node_statement *)node->node_data;
    printtabs(depth);
    printf("Statement\n");
}

parser_node *parse_function(typed_token **tkns_ptr);
parser_node *parse_program(typed_token **tkns_ptr);
parser_node *parse_statement(typed_token **tkns_ptr);

parser_node *parse_program(typed_token **tkns_ptr)
{
    parser_node *node = (parser_node *)malloc(sizeof(parser_node));
    node->node_type = NODE_PROGRAM;
    node->node_data = (void *)malloc(sizeof(node_program));
    node->node_debug = program_debug;
    node_program *prog = (node_program *)node->node_data;

    prog->num_functions = 3;
    prog->functions = (parser_node **)malloc(sizeof(parser_node *) * prog->num_functions);
    prog->functions[0] = parse_function(tkns_ptr);
    prog->functions[1] = parse_function(tkns_ptr);
    prog->functions[2] = parse_function(tkns_ptr);

    return node;
}

parser_node *parse_function(typed_token **tkns_ptr)
{
    parser_node *node = (parser_node *)malloc(sizeof(parser_node));
    node->node_type = NODE_FUNCTION;
    node->node_data = (void *)malloc(sizeof(node_function));
    node->node_debug = function_debug;
    node_function *func = (node_function *)node->node_data;

    func->num_statements = 3;
    func->statements = (parser_node **)malloc(sizeof(parser_node *) * func->num_statements);
    func->statements[0] = parse_statement(tkns_ptr);
    func->statements[1] = parse_statement(tkns_ptr);
    func->statements[2] = parse_statement(tkns_ptr);

    return node;
}

parser_node *parse_statement(typed_token **tkns_ptr)
{
    parser_node *node = (parser_node *)malloc(sizeof(parser_node));
    node->node_type = NODE_STATEMENT;
    node->node_data = (void *)malloc(sizeof(node_statement));
    node->node_debug = statement_debug;
    node_statement *stmt = (node_statement *)node->node_data;

    return node;
}

int main(void)
{
    int ret = 0;
    char *content = NULL;

    FILE *fp = fopen("./inp.c", "rb");
    if (!fp)
    {
        perror("failed to read source file");
        ret = 1;
        goto defer_exit;
    }

    content = read_source_file(fp);

    if (!content)
    {
        fprintf(stderr, "failed to read source file: read_source_file returned NULL\n");
        ret = 1;
        goto defer_exit;
    }

    typed_token *tkns = tokenize(content);
    parser_node *prog = parse_program(&tkns);

    printf("========\n");

    prog->node_debug(0, prog);

defer_exit:
    if (fp)
        fclose(fp);
    if (content)
        xfree(content);
    return ret;
}

char *read_source_file(FILE *fp)
{
    char *data = NULL;
    struct stat st;

    if (fstat(fileno(fp), &st) == -1)
        goto ret;

    data = calloc(st.st_size + 1, sizeof(char));
    if (!data)
        goto ret;

    fread(data, sizeof(char), st.st_size, fp);
    data[st.st_size] = '\0';

ret:
    return data;
}
