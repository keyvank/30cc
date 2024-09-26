#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>

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

typedef struct typed_struct_
{
    unsigned char type_id;
    void *data;
    struct typed_struct_ *next;
} typed_struct;

char *read_source_file(FILE *fp);

char isnum(char c)
{
    return (c >= '0' && c <= '9') ? c : 0;
}

char isletter(char c)
{
    return ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || c == '_') ? c : 0;
}

char isalnum(char c)
{
    return (isnum(c) || isletter(c)) ? c : 0;
}

#define TKN_EOF 0
#define TKN_VOID 1
#define TKN_INT 2
#define TKN_RETURN 3
#define TKN_FOR 4
#define TKN_IF 5
#define TKN_DO 6
#define TKN_WHILE 7
#define TKN_ID 32
#define TKN_ASSIGN 64
#define TKN_EQ 65
#define TKN_LT 66
#define TKN_GT 67
#define TKN_LTE 68
#define TKN_GTE 69
#define TKN_NEG 70
#define TKN_NEQ 71
#define TKN_COMMENT 128

typed_struct *new_tkn(int tkn_id, void *data)
{
    typed_struct *ret = malloc(sizeof(typed_struct));
    ret->type_id = tkn_id;
    ret->data = data;
    ret->next = NULL;
    return ret;
}

typed_struct *next_keyword_or_identifier(char **inp_ptr)
{
    char *inp = *inp_ptr;
    char c;
    if ((c = isletter(*inp)))
    {
        inp++;
        char *val = malloc(128);
        char *val_ptr = val;
        *val_ptr = c;
        val_ptr++;
        while (*inp && (c = isalnum(*inp)))
        {
            *val_ptr = c;
            inp++;
            val_ptr++;
        }
        *val_ptr = '\0';
        *inp_ptr = inp;

        if (strcmp(val, "void") == 0)
            return new_tkn(TKN_VOID, NULL);
        else if (strcmp(val, "int") == 0)
            return new_tkn(TKN_INT, NULL);
        else if (strcmp(val, "return") == 0)
            return new_tkn(TKN_RETURN, NULL);
        else if (strcmp(val, "for") == 0)
            return new_tkn(TKN_FOR, NULL);
        else if (strcmp(val, "if") == 0)
            return new_tkn(TKN_IF, NULL);
        else if (strcmp(val, "do") == 0)
            return new_tkn(TKN_DO, NULL);
        else if (strcmp(val, "while") == 0)
            return new_tkn(TKN_WHILE, NULL);
        else
            return new_tkn(TKN_ID, val);
    }
    else
    {
        return NULL;
    }
}

typed_struct *next_op(char **inp_ptr)
{
    char *inp = *inp_ptr;
    if (*inp == '=')
    {
        if (*(inp + 1) == '=')
        {
            *inp_ptr += 2;
            return new_tkn(TKN_EQ, NULL);
        }
        else
        {
            *inp_ptr += 1;
            return new_tkn(TKN_ASSIGN, NULL);
        }
    }
    if (*inp == '<')
    {
        if (*(inp + 1) == '=')
        {
            *inp_ptr += 2;
            return new_tkn(TKN_LTE, NULL);
        }
        else
        {
            *inp_ptr += 1;
            return new_tkn(TKN_LT, NULL);
        }
    }
    if (*inp == '>')
    {
        if (*(inp + 1) == '=')
        {
            *inp_ptr += 2;
            return new_tkn(TKN_GTE, NULL);
        }
        else
        {
            *inp_ptr += 1;
            return new_tkn(TKN_GT, NULL);
        }
    }
    if (*inp == '!')
    {
        if (*(inp + 1) == '=')
        {
            *inp_ptr += 2;
            return new_tkn(TKN_NEQ, NULL);
        }
        else
        {
            *inp_ptr += 1;
            return new_tkn(TKN_NEG, NULL);
        }
    }
    if (*inp == '/')
    {
        if (*(inp + 1) == '/')
        {
            inp += 2;
            while (*inp != '\n' && *inp != '\0')
                inp++;
            *inp_ptr = inp;
            return new_tkn(TKN_COMMENT, NULL);
        }
        else if (*(inp + 1) == '*')
        {
            inp += 2;
            while (*inp)
            {
                if (*inp == '*' && *(inp + 1) == '/')
                {
                    inp += 2;
                    *inp_ptr = inp;
                    return new_tkn(TKN_COMMENT, NULL);
                }
                inp++;
            }
        }
    }
    return NULL;
}

void skip_whitespaces(char **inp_ptr)
{
    char *inp = *inp_ptr;
    while (*inp != 0 && (*inp == ' ' || *inp == '\n' || *inp == '\t'))
    {
        inp++;
    }
    *inp_ptr = inp;
}

typed_struct *next_token(char **inp_ptr)
{
    skip_whitespaces(inp_ptr);

    char *inp = *inp_ptr;

    // Return NULL if there is nothing left
    if (!*inp)
        return new_tkn(TKN_EOF, NULL);

    typed_struct *tkn = next_keyword_or_identifier(inp_ptr);
    if (!tkn)
        tkn = next_op(inp_ptr);
    if (tkn)
    {
        return tkn;
    }
    else
    {
        perror("Lexer error!");
        exit(0);
    }
}

typed_struct *tokenize(char *inp)
{
    char **ptr = &inp;
    typed_struct *t = next_token(ptr);

    while (t)
    {
        if (t->type_id == TKN_EOF)
        {
            printf("EOF!");
            break;
        }
        if (t->type_id == TKN_ID)
        {
            printf("ID: %s\n", (char *)t->data);
        }
        else
        {
            printf("Other: %d\n", t->type_id);
        }
        t = next_token(ptr);
    }
    return NULL;
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
