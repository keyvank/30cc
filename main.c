#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include "lexer.h"
#include "parser/program.h"
#include "linked_list.h"
#include "preprocess.h"

char *read_source_file(FILE *fp);

#define MAX_INCLUDE_DEPTH 8
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

int lex = 0;

typed_token *process(const char *filename, int depth)
{
    typed_token *tkn = NULL;
    char *content = NULL;
    FILE *fp = NULL;

    if (depth > MAX_INCLUDE_DEPTH)
    {
        fprintf(stderr, "exceeded maximum include depth (%d)\n", MAX_INCLUDE_DEPTH);
        goto cleanup;
    }

    fp = fopen(filename, "rb");
    if (fp == NULL)
    {
        fprintf(stderr, "Error opening file: %s\n", filename);
        goto cleanup;
    }
    content = read_source_file(fp);

    if (!content)
    {
        fprintf(stderr, "failed to read source file: read_source_file returned NULL\n");
        goto cleanup;
    }

    tkn = tokenize(content);
    if (lex)
    {
        typed_token *t = tkn;
        while (t)
        {
            t->debug(t);
            t = t->next;
        }
    }
    tkn = preprocess(tkn, filename, depth);

cleanup:
    if (fp)
        fclose(fp);
    if (content)
        xfree(content);
    return tkn;
}

int main(int argc, char *argv[])
{
    if (argc != 3)
    {
        fprintf(stderr, "Usage: %s <filename> <mode> (<mode>: --lex, --asm or --tree)\n", argv[0]);
        return 1;
    }

    if (strcmp(argv[2], "--lex") != 0 && strcmp(argv[2], "--asm") != 0 && strcmp(argv[2], "--tree") != 0) {
        fprintf(stderr, "Unknown argument %s", argv[2]);
        return 1;
    }

    lex = !strcmp(argv[2], "--lex");

    typed_token *tkn = process(argv[1], 0);
    if (tkn == NULL)
    {
        return 1;
    }

    parser_node *prog = parse_program(&tkn);
    if (prog)
    {
        if (strcmp(argv[2], "--tree") == 0)
        {
            prog->debug(0, prog);
            return 0;
        }
    }
    else
    {
        fprintf(stderr, "Parse failed!\n");
        return 1;
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

    return 0;
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
