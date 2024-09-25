#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_FILE_SZ (8192)
#define BUFF_SZ (128)

typedef struct typed_struct_
{
    unsigned char type_id;
    void *data;
    struct typed_struct_ *next;
} typed_struct;

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
    typed_struct *a = next_token(ptr);
    printf("%s", (char *)a->data);
    typed_struct *b = next_token(ptr);
    printf("%s", (char *)b->data);
    typed_struct *c = next_token(ptr);
    printf("%s", (char *)c->data);
    return NULL;
}

int main(void)
{
    FILE *fptr = fopen("inp.c", "r");
    char *content = malloc(sizeof(char) * MAX_FILE_SZ);
    char buff[BUFF_SZ];
    content[0] = 0;
    while (fgets(buff, 100, fptr))
    {
        strcat(content, buff);
    }

    typed_struct *tkn = tokenize(content);
    while (tkn)
    {
        tkn = tkn->next;
    }

    free(content);
}