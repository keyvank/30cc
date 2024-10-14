#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include "lexer.h"
#include "parser/program.h"
#include "linked_list.h"
#include "preprocess.h"

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

int main(int argc, char *argv[])
{
    if (argc != 3)
    {
        fprintf(stderr, "Usage: %s <filename> <mode> (<mode>: --lex, --asm or --tree)\n", argv[0]);
        return 1;
    }

    int ret = 0;
    char *content = NULL;
    const char *filename = argv[1];

    FILE *fp = fopen(filename, "rb");
    if (fp == NULL)
    {
        fprintf(stderr, "Error opening file: %s\n", filename);
        return 1;
    }
    content = read_source_file(fp);

    if (!content)
    {
        fprintf(stderr, "failed to read source file: read_source_file returned NULL\n");
        ret = 1;
        goto defer_exit;
    }

    typed_token *tkn = tokenize(content);

    if (strcmp(argv[2], "--lex") == 0)
    {
        typed_token *t = tkn;
        while (t)
        {
            t->debug(t);
            t = t->next;
        }
    }

    tkn = preprocess(tkn);

    // printf("========\n");
    parser_node *prog = parse_program(&tkn);
    if (prog)
    {
        if (strcmp(argv[2], "--tree") == 0)
        {
            prog->debug(0, prog);
            exit(0);
        }
    }
    else
    {
        printf("Parse failed!\n");
    }

    if (strcmp(argv[2], "--asm") == 0)
    {
        context ctx = new_context();
        prog->apply(prog, &ctx);
        list_node *curr = ctx.data.first;
        printf("section .data\n");
        while (curr)
        {
            printf("%s\n", (char *)curr->value);
            curr = curr->next;
        }
        printf("section .text\n");
        curr = ctx.text.first;
        while (curr)
        {
            printf("%s\n", (char *)curr->value);
            curr = curr->next;
        }
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

    int rd = fread(data, sizeof(char), st.st_size, fp);
    if (rd != st.st_size)
    {
        data = NULL;
        goto ret;
    }
    data[st.st_size] = '\0';

ret:
    return data;
}
