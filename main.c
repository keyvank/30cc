#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>

/**
 * free() ignores NULL pointer by default. set each pointer to NULL
 * after calling free() to avoid double free error.
 */
#define xfree(p) do { free((p)); (p) = NULL; } while (0)

typedef struct typed_struct_
{
    unsigned char type_id;
    void *data;
    struct typed_struct_ *next;
} typed_struct;

char *read_source_file(FILE *fp);

typed_struct *next_token(char **inp_ptr)
{
    char *inp = *inp_ptr;
    // Skip whitespaces
    while (*inp != 0 && (*inp == ' ' || *inp == '\n' || *inp == '\t'))
    {
        inp++;
    }
    // Return NULL if there is nothing left
    if (!*inp)
    {
        *inp_ptr = inp;
        return NULL;
    }

    int cnt = 0;
    char *tkn_content = malloc(128);
    tkn_content[0] = '\0';
    while (*inp != 0 && *inp != ' ' && *inp != '\n' && *inp != '\t')
    {
        tkn_content[cnt] = *inp;
        inp++;
        cnt++;
    }
    tkn_content[cnt] = '\0';
    typed_struct *ret = malloc(sizeof(typed_struct));
    ret->data = tkn_content;
    *inp_ptr = inp;
    return ret;
}

typed_struct *tokenize(char *inp)
{
    char **ptr = &inp;
    typed_struct *t = next_token(ptr);
    while (t) {
        printf("%s\n", (char*)t->data);
        t = next_token(ptr);
    }
    return NULL;
}

int main(void)
{
    int ret = 0;
    char *content = NULL;

    FILE *fp = fopen("./inp.c", "rb");
    if (!fp) {
        perror("failed to read source file");
        ret = 1;
        goto defer_exit;
    }

    content = read_source_file(fp);
    if (!content) {
        fprintf(stderr, "failed to read source file: read_source_file returned NULL\n");
        ret = 1;
        goto defer_exit;
    }

    typed_struct *tkn = tokenize(content);
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

char *read_source_file(FILE *fp) {
    char *data = NULL;
    struct stat st;

    if (fstat(fileno(fp), &st) == -1)
        goto ret;

    data = calloc(st.st_size, sizeof(char));
    if (!data)
        goto ret;

    fread(data, sizeof(char), st.st_size, fp);

ret:
    return data;
}
