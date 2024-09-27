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
    while (tkn)
    {
        tkn = tkn->next;
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
