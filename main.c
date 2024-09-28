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
#define NODE_PARAM 4

typedef struct parser_node_
{
    int node_type;
    void *node_data;
    void (*node_debug)(int, struct parser_node_ *);
} parser_node;

typedef struct
{
    char *type;
    char *identity;
} node_param;

typedef struct
{

} node_statement;

typedef struct
{
    char *identity;
    int num_params;
    parser_node **params;
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
    for (int i = 0; i < func->num_params; i++)
    {
        parser_node *node = func->params[i];
        node->node_debug(depth + 1, node);
    }
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

void param_debug(int depth, parser_node *node)
{
    node_param *par = (node_param *)node->node_data;
    printtabs(depth);
    printf("Param(%s, %s)\n", par->type, par->identity);
}

parser_node *parse_function(typed_token **tkns_ptr);
parser_node *parse_param(typed_token **tkns_ptr);
parser_node *parse_program(typed_token **tkns_ptr);
parser_node *parse_statement(typed_token **tkns_ptr);

parser_node *parse_program(typed_token **tkn_ptr)
{
    int func_count = 0;
    parser_node **funcs = (parser_node **)malloc(sizeof(parser_node *) * 128);
    typed_token *tkn = *tkn_ptr;
    while (tkn)
    {
        parser_node *f = parse_function(&tkn);
        if (f)
        {
            funcs[func_count++] = f;
        }
        else if (tkn)
        {
            return NULL;
        }
    }

    parser_node *node = (parser_node *)malloc(sizeof(parser_node));
    node->node_type = NODE_PROGRAM;
    node->node_data = (void *)malloc(sizeof(node_program));
    node->node_debug = program_debug;
    node_program *prog = (node_program *)node->node_data;

    prog->num_functions = func_count;
    prog->functions = funcs;

    return node;
}

parser_node *parse_param(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    if (tkn->type_id == TKN_INT)
    {
        typed_token *type_tkn = tkn;
        tkn = tkn->next;
        if (tkn->type_id == TKN_ID)
        {
            typed_token *name_tkn = tkn;
            tkn = tkn->next;
            *tkns_ptr = tkn;

            parser_node *node = (parser_node *)malloc(sizeof(parser_node));
            node->node_type = NODE_PARAM;
            node->node_data = (void *)malloc(sizeof(node_param));
            node->node_debug = param_debug;
            node_param *par = (node_param *)node->node_data;
            par->identity = malloc(128);
            par->type = malloc(128);
            strcpy(par->identity, name_tkn->data);
            strcpy(par->type, type_tkn->data);

            return node;
        }
    }

    return NULL;
}

parser_node *parse_function(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;
    if (tkn->type_id == TKN_INT || tkn->type_id == TKN_VOID)
    {
        tkn = tkn->next;
        if (tkn->type_id == TKN_ID)
        {
            tkn = tkn->next;
            if (tkn->type_id == TKN_L_PAREN)
            {
                int params_count = 0;
                parser_node **params = (parser_node **)malloc(sizeof(parser_node *) * 32); // MAX 32 PARAMS

                tkn = tkn->next;
                while (tkn)
                {
                    parser_node *p = parse_param(&tkn);
                    if (p)
                    {
                        params[params_count++] = p;
                    }
                    else
                    {
                        return NULL;
                    }
                    if (tkn->type_id == TKN_COMMA)
                    {
                        tkn = tkn->next;
                        continue;
                    }
                    else if (tkn->type_id == TKN_R_PAREN)
                    {
                        tkn = tkn->next;
                        break;
                    }
                    else
                    {
                        return NULL;
                    }
                }
                if (tkn->type_id != TKN_L_BRACE)
                {
                    return NULL;
                }
                tkn = tkn->next;
                if (tkn->type_id != TKN_R_BRACE)
                {
                    return NULL;
                }
                tkn = tkn->next;
                *tkns_ptr = tkn;

                parser_node *node = (parser_node *)malloc(sizeof(parser_node));
                node->node_type = NODE_FUNCTION;
                node->node_data = (void *)malloc(sizeof(node_function));
                node->node_debug = function_debug;
                node_function *func = (node_function *)node->node_data;

                func->num_params = params_count;
                func->params = params;
                func->num_statements = 1;
                func->statements = (parser_node **)malloc(sizeof(parser_node *) * func->num_statements);
                func->statements[0] = parse_statement(tkns_ptr);

                return node;
            }
            else
            {
                return NULL;
            }
        }
        else
        {
            return NULL;
        }
    }
    else
    {
        return NULL;
    }

    return NULL;
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

    typed_token *tkn = tokenize(content);

    typed_token *t = tkn;
    while (t)
    {
        t->debug(t);
        t = t->next;
    }

    printf("========\n");
    parser_node *prog = parse_program(&tkn);
    if (prog)
    {
        prog->node_debug(0, prog);
    }
    else
    {
        printf("Parse failed!\n");
    }

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
