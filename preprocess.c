#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "lexer.h"
#include "linked_list.h"
#include "preprocess.h"
#include "codegen/codegen.h"

#define MAX_PATH_LEN 128

extern typed_token *process(const char *filename, int depth);

typedef struct
{
    char *id;
    typed_token *replace;
} define;

typed_token *clone(typed_token *tkn)
{
    typed_token *ret = (typed_token *)malloc(sizeof(typed_token));
    memcpy((void *)ret, (void *)tkn, sizeof(typed_token));
    ret->next = NULL;
    return ret;
}

define *find_def(linked_list *defs, char *id)
{
    list_node *curr = defs->first;
    while (curr)
    {
        define *def = (define *)curr->value;
        if (strcmp(def->id, id) == 0)
        {
            return def;
        }
        curr = curr->next;
    }
    return NULL;
}

char *get_path(const char *path, const char *ipath)
{
    char *realpath;
    char base[MAX_PATH_LEN - 2];

    if (ipath[0] == '/')
        return strdup(ipath);

    // finding the base path
    int i = 0, slash = -1;
    for (const char *c = path; *c != '\0'; c++, i++)
    {
        if (*c == '/')
            slash = i;
    }

    if (slash == -1)
        return strdup(ipath);

    strncpy(base, path, slash);
    base[slash] = '\0';

    realpath = (char *)malloc(MAX_PATH_LEN);
    snprintf(realpath, MAX_PATH_LEN, "%s/%s", base, ipath);

    return realpath;
}

typed_token *preprocess(typed_token *tkns,
        const char *path, int depth)
{
    char *filename = NULL;

    linked_list *defines = new_linked_list();

    typed_token *first = NULL;
    typed_token *last = NULL;

    typed_token *tkn = tkns;
    while (tkn)
    {
        if (tkn->type_id == TKN_MACRO_DEFINE)
        {
            tkn = tkn->next;
            if (tkn->type_id == TKN_ID)
            {
                char *name = cc_asprintf("%s", (char *)tkn->data);
                tkn = tkn->next;
                define *def = (define *)malloc(sizeof(define));
                def->id = name;
                def->replace = clone(tkn);
                add_to_list(defines, (void *)def);
                tkn = tkn->next;
                continue;
            }
        }

        if (tkn->type_id == TKN_MACRO_IFDEF || tkn->type_id == TKN_MACRO_IFNDEF)
        {
            int type = tkn->type_id;

            tkn = tkn->next;
            if (tkn->type_id == TKN_ID)
            {
                char *name = cc_asprintf("%s", (char *)tkn->data);
                define *def = find_def(defines, name);

                if ((!def && type == TKN_MACRO_IFDEF) ||
                        (def && type == TKN_MACRO_IFNDEF))
                {
                    while (tkn && tkn->type_id != TKN_MACRO_ENDIF)
                    {
                        tkn = tkn->next;
                    }
                }
                tkn = tkn->next;
                continue;
            }
        }
        if (tkn->type_id == TKN_MACRO_ENDIF)
        {
            tkn = tkn->next;
            continue;
        }

        if (tkn->type_id == TKN_ID)
        {
            define *def = find_def(defines, (char *)tkn->data);
            if (def)
            {

                // Add tkn
                if (!first)
                {
                    first = clone(def->replace);
                    last = first;
                }
                else
                {
                    last->next = clone(def->replace);
                    last = last->next;
                }

                tkn = tkn->next;
                continue;
            }
        }

        if (tkn->type_id == TKN_MACRO_INCLUDE)
        {
            tkn = tkn->next;
            if (tkn->type_id == TKN_LIT_STR)
            {
                filename = get_path(path, tkn->data);
                typed_token *next_tkn = process(filename, depth+1);

                if (next_tkn == NULL)
                {
                    // cleanup
                    while (first)
                    {
                        typed_token *next = first->next;
                        free(first);
                        first = next;
                    }
                    goto cleanup;
                }

                if (!first)
                {
                    first = next_tkn;
                    last = first;
                }
                else
                {
                    last->next = next_tkn;
                }

                while (last->next)
                {
                    // ignore TKN_EOF for included files
                    if (last->next->type_id == TKN_EOF) {
                        free(last->next);
                        break;
                    }
                    last = last->next;
                }

                tkn = tkn->next;
                continue;
            }
        }

        // Add tkn
        if (!first)
        {
            first = clone(tkn);
            last = first;
        }
        else
        {
            last->next = clone(tkn);
            last = last->next;
        }

        tkn = tkn->next;
    }

cleanup:
    if (filename)
        free(filename);

    return first;
}
