
#include "libc.h"
#include "lexer.h"

char is_num(char c)
{
    return (c >= '0' && c <= '9') ? c : 0;
}

char is_letter(char c)
{
    return ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || c == '_') ? c : 0;
}

char is_letter_or_num(char c)
{
    return (is_num(c) || is_letter(c)) ? c : 0;
}

typed_token *new_tkn(int tkn_id, void *data, void (*debug)(typed_token *))
{
    typed_token *ret = (typed_token *)malloc(sizeof(typed_token));
    ret->type_id = tkn_id;
    ret->data = data;
    ret->debug = debug;
    ret->next = NULL;
    return ret;
}

#define STR(x) #x

void simp_tkn_debug(typed_token *tkn)
{
    printf("%s\n", (char *)tkn->data);
}
void ident_tkn_debug(typed_token *tkn)
{
    printf("%s(%s)\n", STR(TKN_ID), (char *)tkn->data);
}
void str_tkn_debug(typed_token *tkn)
{
    printf("%s(%s)\n", STR(TKN_LIT_STR), (char *)tkn->data);
}
void directive_tkn_debug(typed_token *tkn)
{
    typed_token *curr = (typed_token *)tkn->data;
    printf("%s:\n", STR(TKN_DIRECTIVE));
    while (curr)
    {
        printf("  ");
        curr->debug(curr);
        curr = curr->next;
    }
}
void char_tkn_debug(typed_token *tkn)
{
    printf("%s(%c)\n", STR(TKN_LIT_CHAR), *((char *)tkn->data));
}
void int_lit_tkn_debug(typed_token *tkn)
{
    printf("%s(%u)\n", STR(TKN_LIT_INT), *((int *)tkn->data));
}

#define new_simp_tkn(x) new_tkn(x, (void *)#x, simp_tkn_debug)

typed_token *next_keyword_or_identifier(char **inp_ptr)
{
    char *inp = *inp_ptr;
    char c;
    if ((c = is_letter(*inp)))
    {
        inp++;
        char *val = (char *)malloc(128);
        char *val_ptr = val;
        *val_ptr = c;
        val_ptr++;
        while ((*inp != '\0') && ((c = is_letter_or_num(*inp)) != '\0'))
        {
            *val_ptr = c;
            inp++;
            val_ptr++;
        }
        *val_ptr = '\0';
        *inp_ptr = inp;

        if (strcmp(val, "void") == 0)
            return new_simp_tkn(TKN_VOID);
        else if (strcmp(val, "int") == 0)
            return new_simp_tkn(TKN_INT);
        else if (strcmp(val, "char") == 0)
            return new_simp_tkn(TKN_CHAR);
        else if (strcmp(val, "return") == 0)
            return new_simp_tkn(TKN_RETURN);
        else if (strcmp(val, "for") == 0)
            return new_simp_tkn(TKN_FOR);
        else if (strcmp(val, "if") == 0)
            return new_simp_tkn(TKN_IF);
        else if (strcmp(val, "else") == 0)
            return new_simp_tkn(TKN_ELSE);
        else if (strcmp(val, "do") == 0)
            return new_simp_tkn(TKN_DO);
        else if (strcmp(val, "while") == 0)
            return new_simp_tkn(TKN_WHILE);
        else if (strcmp(val, "struct") == 0)
            return new_simp_tkn(TKN_STRUCT);
        else if (strcmp(val, "sizeof") == 0)
            return new_simp_tkn(TKN_SIZEOF);
        else if (strcmp(val, "typedef") == 0)
            return new_simp_tkn(TKN_TYPEDEF);
        else if (strcmp(val, "goto") == 0)
            return new_simp_tkn(TKN_GOTO);
        else if (strcmp(val, "break") == 0)
            return new_simp_tkn(TKN_BREAK);
        else if (strcmp(val, "continue") == 0)
            return new_simp_tkn(TKN_CONTINUE);
        else if (strcmp(val, "switch") == 0)
            return new_simp_tkn(TKN_SWITCH);
        else if (strcmp(val, "case") == 0)
            return new_simp_tkn(TKN_CASE);
        else if (strcmp(val, "default") == 0)
            return new_simp_tkn(TKN_DEFAULT);
        else if (strcmp(val, "extern") == 0)
            return new_simp_tkn(TKN_EXTERN);
        else if (strcmp(val, "__asm__") == 0)
            return new_simp_tkn(TKN_ASM);
        else
            return new_tkn(TKN_ID, val, ident_tkn_debug);
    }
    else
    {
        return NULL;
    }
}

typed_token *next_op(char **inp_ptr, int is_newline)
{
    char *inp = *inp_ptr;
    if (is_num(*inp))
    {
        int a = (int)*inp - 48;
        inp++;
        while (is_num(*inp))
        {

            a = a * 10;
            a += ((int)*inp - 48);
            inp++;
        }
        *inp_ptr = inp;
        int *val = (int *)malloc(sizeof(int));
        *val = a;
        return new_tkn(TKN_LIT_INT, (void *)val, int_lit_tkn_debug);
    }
    if (is_newline && *inp == '#')
    {
        char *line = (char *)malloc(512);
        int sz = 0;
        inp++;
        while (*inp)
        {
            if (*inp == '\\')
            {
                inp++;
                while (*inp)
                {
                    if (*inp == ' ')
                        inp++;
                    else if (*inp == '\n')
                    {
                        inp++;
                        break;
                    }
                    else
                    {
                        fprintf(stderr, "Invalid character '%c' coming after '\\'!\n", *inp);
                        exit(1);
                    }
                }
                continue;
            }

            if (*inp == '\n')
                break;

            line[sz] = *inp;
            sz++;
            inp++;
        }
        line[sz] = '\0';
        *inp_ptr = inp;
        typed_token *dir_tkns = tokenize(line);
        return new_tkn(TKN_DIRECTIVE, dir_tkns, directive_tkn_debug);
    }
    if (*inp == '?')
    {
        *inp_ptr += 1;
        return new_simp_tkn(TKN_QUEST);
    }
    if (*inp == ':')
    {
        *inp_ptr += 1;
        return new_simp_tkn(TKN_COLON);
    }
    if (*inp == '(')
    {
        *inp_ptr += 1;
        return new_simp_tkn(TKN_L_PAREN);
    }
    if (*inp == ')')
    {
        *inp_ptr += 1;
        return new_simp_tkn(TKN_R_PAREN);
    }
    if (*inp == '{')
    {
        *inp_ptr += 1;
        return new_simp_tkn(TKN_L_BRACE);
    }
    if (*inp == '}')
    {
        *inp_ptr += 1;
        return new_simp_tkn(TKN_R_BRACE);
    }
    if (*inp == '[')
    {
        *inp_ptr += 1;
        return new_simp_tkn(TKN_L_BRACK);
    }
    if (*inp == ']')
    {
        *inp_ptr += 1;
        return new_simp_tkn(TKN_R_BRACK);
    }
    if (*inp == ';')
    {
        *inp_ptr += 1;
        return new_simp_tkn(TKN_SEMICOLON);
    }
    if (*inp == ',')
    {
        *inp_ptr += 1;
        return new_simp_tkn(TKN_COMMA);
    }
    if (*inp == '#')
    {
        *inp_ptr += 1;
        return new_simp_tkn(TKN_SHARP);
    }
    if (*inp == '&')
    {
        char peeked = *(inp + 1);
        if (peeked == '&')
        {
            *inp_ptr += 2;
            return new_simp_tkn(TKN_ANDAND);
        }
        else if (peeked == '=')
        {
            *inp_ptr += 2;
            return new_simp_tkn(TKN_ANDEQ);
        }
        else
        {
            *inp_ptr += 1;
            return new_simp_tkn(TKN_AND);
        }
    }
    if (*inp == '|')
    {
        char peeked = *(inp + 1);
        if (peeked == '|')
        {
            *inp_ptr += 2;
            return new_simp_tkn(TKN_OROR);
        }
        if (peeked == '=')
        {
            *inp_ptr += 2;
            return new_simp_tkn(TKN_OREQ);
        }
        else
        {
            *inp_ptr += 1;
            return new_simp_tkn(TKN_OR);
        }
    }
    if (*inp == '\'')
    {
        if (*(inp + 1) == '\\')
        {
            if (*(inp + 2) != '\0' && *(inp + 3) == '\'')
            {
                *inp_ptr += 4;
                char e = *(inp + 2);
                char *ch = (char *)malloc(1);
                if (e == 'n')
                {
                    *ch = '\n';
                }
                else if (e == 't')
                {
                    *ch = '\t';
                }
                else if (e == '0')
                {
                    *ch = '\0';
                }
                else
                {
                    *ch = *(inp + 2);
                }
                return new_tkn(TKN_LIT_CHAR, (void *)ch, char_tkn_debug);
            }
        }
        else if (*(inp + 1) != '\0' && *(inp + 2) == '\'')
        {
            *inp_ptr += 3;
            char *ch = (char *)malloc(1);
            *ch = *(inp + 1);
            return new_tkn(TKN_LIT_CHAR, (void *)ch, char_tkn_debug);
        }
    }
    if (*inp == '"')
    {
        int sz = 0;
        char *val = (char *)malloc(256);
        inp++;
        while (*inp)
        {
            if (*inp == '"')
            {
                inp += 1;
                val[sz] = '\0';
                *inp_ptr = inp;
                return new_tkn(TKN_LIT_STR, val, str_tkn_debug);
            }
            char c = *inp;
            if (*inp == '\\')
            {
                inp++;
                if (*inp == 'n')
                {
                    c = '\n';
                }
                else if (*inp == 't')
                {
                    c = '\t';
                }
                else
                {
                    c = *inp;
                }
            }
            val[sz] = c;
            sz++;
            inp++;
        }
        free(val); //
    }
    if (*inp == '=')
    {
        if (*(inp + 1) == '=')
        {
            *inp_ptr += 2;
            return new_simp_tkn(TKN_EQ);
        }
        else
        {
            *inp_ptr += 1;
            return new_simp_tkn(TKN_ASSIGN);
        }
    }
    if (*inp == '<')
    {
        if (*(inp + 1) == '=')
        {
            *inp_ptr += 2;
            return new_simp_tkn(TKN_LTE);
        }
        else
        {
            *inp_ptr += 1;
            return new_simp_tkn(TKN_LT);
        }
    }
    if (*inp == '>')
    {
        if (*(inp + 1) == '=')
        {
            *inp_ptr += 2;
            return new_simp_tkn(TKN_GTE);
        }
        else
        {
            *inp_ptr += 1;
            return new_simp_tkn(TKN_GT);
        }
    }
    if (*inp == '!')
    {
        if (*(inp + 1) == '=')
        {
            *inp_ptr += 2;
            return new_simp_tkn(TKN_NEQ);
        }
        else
        {
            *inp_ptr += 1;
            return new_simp_tkn(TKN_NOT);
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
            return new_simp_tkn(TKN_COMMENT);
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
                    return new_simp_tkn(TKN_COMMENT);
                }
                inp++;
            }
        }
    }

    if (*inp == '+')
    {
        if (*(inp + 1) == '+')
        {
            *inp_ptr += 2;
            return new_simp_tkn(TKN_PLUSPLUS);
        }
        else if (*(inp + 1) == '=')
        {
            *inp_ptr += 2;
            return new_simp_tkn(TKN_PLUSEQ);
        }
        else
        {
            *inp_ptr += 1;
            return new_simp_tkn(TKN_PLUS);
        }
    }
    if (*inp == '-')
    {
        if (*(inp + 1) == '>')
        {
            *inp_ptr += 2;
            return new_simp_tkn(TKN_ARROW);
        }
        else if (*(inp + 1) == '-')
        {
            *inp_ptr += 2;
            return new_simp_tkn(TKN_MINMIN);
        }
        else if (*(inp + 1) == '=')
        {
            *inp_ptr += 2;
            return new_simp_tkn(TKN_MINEQ);
        }
        else
        {
            *inp_ptr += 1;
            return new_simp_tkn(TKN_MIN);
        }
    }
    if (*inp == '*')
    {
        if (*(inp + 1) == '=')
        {
            *inp_ptr += 2;
            return new_simp_tkn(TKN_STAREQ);
        }
        else
        {
            *inp_ptr += 1;
            return new_simp_tkn(TKN_STAR);
        }
    }
    if (*inp == '/')
    {
        if (*(inp + 1) == '=')
        {
            *inp_ptr += 2;
            return new_simp_tkn(TKN_DIVEQ);
        }
        else
        {
            *inp_ptr += 1;
            return new_simp_tkn(TKN_DIV);
        }
    }
    if (*inp == '%')
    {
        if (*(inp + 1) == '=')
        {
            *inp_ptr += 2;
            return new_simp_tkn(TKN_MODEQ);
        }
        else
        {
            *inp_ptr += 1;
            return new_simp_tkn(TKN_MOD);
        }
    }
    if (*inp == '.')
    {
        if (*(inp + 1) == '.' && *(inp + 2) == '.')
        {
            *inp_ptr += 3;
            return new_simp_tkn(TKN_DOTS);
        }
        else
        {
            *inp_ptr += 1;
            return new_simp_tkn(TKN_DOT);
        }
    }
    return NULL;
}

int skip_whitespaces(char **inp_ptr, int is_start)
{
    char *inp = *inp_ptr;
    int is_newline = is_start || (*inp == '\n');
    while (*inp != '\0' && (*inp == ' ' || *inp == '\n' || *inp == '\t'))
    {
        is_newline = (*inp == '\n');
        inp++;
    }
    *inp_ptr = inp;
    return is_newline;
}

typed_token *next_token(char **inp_ptr, int *is_start)
{
    int is_newline = skip_whitespaces(inp_ptr, *is_start);
    *is_start = 0;

    char *inp = *inp_ptr;

    // Return NULL if there is nothing left
    if (!*inp)
        return new_simp_tkn(TKN_EOF);

    typed_token *tkn = next_keyword_or_identifier(inp_ptr);
    if (!tkn)
        tkn = next_op(inp_ptr, is_newline);
    if (tkn)
    {
        return tkn;
    }
    else
    {
        fprintf(stderr, "Unexpected character '%c'!\n", **inp_ptr);
        exit(0);
    }
}

typed_token *tokenize(char *inp)
{
    int is_start = 1;
    char **ptr = &inp;
    typed_token *t;
    while ((t = next_token(ptr, &is_start))->type_id == TKN_COMMENT)
    {
    }

    typed_token *first = t;

    while (t)
    {
        if (t->type_id == TKN_EOF)
        {
            break;
        }
        typed_token *next = next_token(ptr, &is_start);
        if (next->type_id == TKN_COMMENT)
        {
            continue;
        }
        t->next = next;
        t = next;
    }
    return first;
}

typed_token *tokenize_file(char *path)
{
    void *fp = NULL;

    fp = fopen(path, "rb");
    if (fp == NULL)
    {
        fprintf(stderr, "Error opening file: %s\n", path);
        exit(1);
    }

    char *data = NULL;
    data = (char *)calloc(32768, sizeof(char));
    if (!data)
        goto ret;

    int rd = fread(data, sizeof(char), 32768, fp);
    data[rd] = '\0';

    return tokenize(data);
ret:
    return NULL;
}

typed_token *eof_token()
{
    return new_simp_tkn(TKN_EOF);
}