void *malloc(int sz);
void printf(char *s, ...);
int strcmp(char *a, char *b);
void exit(int ret);
int getchar();

#define NULL 0

typedef struct typed_token_
{
    int type_id;
    void *data;
    void (*debug)(struct typed_token_ *);
    struct typed_token_ *next;
} typed_token;

#define TKN_EOF 0
#define TKN_VOID 1
#define TKN_INT 2
#define TKN_CHAR 3
#define TKN_RETURN 4
#define TKN_FOR 5
#define TKN_IF 6
#define TKN_DO 7
#define TKN_WHILE 8
#define TKN_STRUCT 9
#define TKN_ELSE 10
#define TKN_SIZEOF 11
#define TKN_TYPEDEF 12
#define TKN_GOTO 13

// Single letter symbols
#define TKN_L_PAREN 16
#define TKN_R_PAREN 17
#define TKN_L_BRACE 18
#define TKN_R_BRACE 19
#define TKN_L_BRACK 20
#define TKN_R_BRACK 21
#define TKN_SEMICOLON 22
#define TKN_COMMA 23
#define TKN_SHARP 24

#define TKN_ID 32
#define TKN_LIT_STR 33
#define TKN_LIT_INT 34
#define TKN_LIT_CHAR 35

#define TKN_ASSIGN 64
#define TKN_EQ 65
#define TKN_LT 66
#define TKN_GT 67
#define TKN_LTE 68
#define TKN_GTE 69
#define TKN_NOT 70
#define TKN_NEQ 71
#define TKN_PLUS 72
#define TKN_PLUSPLUS 73
#define TKN_PLUSEQ 74
#define TKN_MIN 75
#define TKN_MINMIN 76
#define TKN_MINEQ 77
#define TKN_STAR 78
#define TKN_STAREQ 79
#define TKN_DOTS 80
#define TKN_AND 81
#define TKN_ANDAND 82
#define TKN_OR 83
#define TKN_OROR 84
#define TKN_QUEST 85
#define TKN_COLON 86
#define TKN_DOT 87
#define TKN_ARROW 88
#define TKN_DIV 89
#define TKN_DIVEQ 90
#define TKN_MOD 91
#define TKN_MODEQ 92
#define TKN_OREQ 93
#define TKN_ANDEQ 94
#define TKN_BREAK 96
#define TKN_CONTINUE 96
#define TKN_SWITCH 97
#define TKN_CASE 98
#define TKN_DEFAULT 99

#define TKN_COMMENT 128
#define TKN_DIRECTIVE 129

typed_token *tokenize(char *inp);

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
    return (is_num(c) || is_letter(c)) ? c : '\0';
}

typed_token *new_tkn(int tkn_id, void *data, void (*debug)(typed_token *))
{
    typed_token *ret = (typed_token *)malloc(sizeof(typed_token));
    ret->type_id = tkn_id;
    ret->data = data;
    ret->debug = debug;
    ret->next = 0;
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
    typed_token *curr = (typed_token *)curr->data;
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
        char *line = (char *)malloc(256);
        int sz = 0;
        inp++;
        while (*inp)
        {
            if (*inp == '\n' || *inp == '\0')
            {
                line[sz] = '\0';
                *inp_ptr = inp;
                typed_token *dir_tkns = tokenize(line);
                return new_tkn(TKN_DIRECTIVE, dir_tkns, directive_tkn_debug);
            }
            line[sz] = *inp;
            sz++;
            inp++;
        }
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
            }
            val[sz] = c;
            sz++;
            inp++;
        }
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
        is_newline = (int)(*inp == '\n');
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
        printf("Unexpected character '%c'", **inp_ptr);
        exit(1);
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

int main()
{
    typed_token *fst = tokenize("   \n \t    abc 123 'c' \"keyvan\" def ghi void   int llllll  kkkk  23 ");

    typed_token *curr = fst;
    while (curr)
    {
        curr->debug(curr);
        curr = curr->next;
    }

    return 0;
}