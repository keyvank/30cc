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
    linked_list *arg_names;
    linked_list *replace;
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

typed_token *chain_tokens(linked_list *tkns)
{
    list_node *curr = tkns->first;
    typed_token *res_first = (typed_token *)curr->value;
    typed_token *curr_tkn = res_first;
    while (curr)
    {
        curr = curr->next;
        if (curr)
        {
            curr_tkn->next = (typed_token *)curr->value;
            curr_tkn = curr_tkn->next;
        }
    }
    return res_first;
}

typed_token *preprocess(typed_token *tkns,
                        const char *path, int depth)
{
    char *filename = NULL;

    linked_list *defines = new_linked_list();
    linked_list *result = new_linked_list();

    typed_token *tkn = tkns;
    while (tkn)
    {
        if (tkn->type_id == TKN_DIRECTIVE)
        {
            typed_token *curr = tkn->data;

            if (curr->type_id == TKN_ID)
            {
                char *dir_type = curr->data;

                if (strcmp(dir_type, "define") == 0)
                {
                    curr = curr->next;
                    if (curr->type_id == TKN_ID)
                    {
                        char *name = cc_asprintf("%s", (char *)curr->data);
                        curr = curr->next;

                        linked_list *arg_names = new_linked_list();

                        if (curr->type_id == TKN_L_PAREN)
                        {
                            curr = curr->next;
                            while (curr)
                            {
                                if (curr->type_id == TKN_R_PAREN)
                                {
                                    curr = curr->next;
                                    break;
                                }
                                if (curr->type_id == TKN_ID)
                                {
                                    add_to_list(arg_names, curr->data);
                                    curr = curr->next;
                                }
                                else
                                {
                                    fprintf(stderr, "Unexpected input!");
                                    exit(1);
                                }

                                if (curr->type_id == TKN_COMMA)
                                {
                                    curr = curr->next;
                                }
                                else
                                {
                                    if (curr->type_id != TKN_R_PAREN)
                                    {
                                        fprintf(stderr, "Unexpected input!");
                                        exit(1);
                                    }
                                }
                            }
                        }

                        define *def = (define *)malloc(sizeof(define));
                        def->id = name;
                        def->arg_names = arg_names;
                        def->replace = new_linked_list();
                        while (curr)
                        {
                            if (curr->type_id == TKN_EOF)
                            {
                                break;
                            }
                            add_to_list(def->replace, clone(curr));
                            curr = curr->next;
                        }
                        add_to_list(defines, (void *)def);
                        curr = curr->next;
                        tkn = tkn->next;
                        continue;
                    }
                }

                if (strcmp(dir_type, "ifdef") == 0 || strcmp(dir_type, "ifndef") == 0)
                {
                    int type = curr->type_id;

                    curr = curr->next;
                    if (curr->type_id == TKN_ID)
                    {
                        char *name = cc_asprintf("%s", (char *)curr->data);
                        define *def = find_def(defines, name);

                        if ((!def && strcmp(dir_type, "ifdef") == 0) ||
                            (def && strcmp(dir_type, "ifndef") == 0))
                        {
                            while (tkn)
                            {
                                if (tkn->type_id == TKN_DIRECTIVE)
                                {
                                    if (strcmp(((typed_token *)tkn->data)->data, "endif") == 0)
                                    {
                                        break;
                                    }
                                }
                                tkn = tkn->next;
                            }
                        }
                        curr = curr->next;
                        tkn = tkn->next;
                        continue;
                    }
                }
                if (strcmp(curr->data, "endif") == 0)
                {
                    curr = curr->next;
                    tkn = tkn->next;
                    continue;
                }

                if (strcmp(curr->data, "include") == 0)
                {
                    curr = curr->next;
                    if (curr->type_id == TKN_LIT_STR)
                    {
                        filename = get_path(path, curr->data);
                        typed_token *new_tkn = process(filename, depth + 1);

                        while (new_tkn)
                        {
                            if (new_tkn->type_id == TKN_EOF)
                            {
                                break;
                            }
                            add_to_list(result, new_tkn);
                            new_tkn = new_tkn->next;
                        }

                        curr = curr->next;
                        tkn = tkn->next;
                        continue;
                    }
                }
            }
        }

        if (tkn->type_id == TKN_ID)
        {
            define *def = find_def(defines, (char *)tkn->data);
            if (def)
            {
                tkn = tkn->next;
                linked_list *args = new_linked_list();
                if (tkn->type_id == TKN_L_PAREN)
                {
                    tkn = tkn->next;
                    while (tkn)
                    {
                        if (tkn->type_id == TKN_R_PAREN)
                        {
                            tkn = tkn->next;
                            break;
                        }

                        linked_list *arg = new_linked_list();
                        while (tkn->type_id != TKN_R_PAREN && tkn->type_id != TKN_COMMA && tkn->type_id != TKN_EOF)
                        {
                            add_to_list(arg, tkn);
                            tkn = tkn->next;
                        }
                        if (arg->count == 0)
                        {
                            fprintf(stderr, "Unexpected input!");
                            exit(1);
                        }
                        else
                        {
                            add_to_list(args, arg);
                        }

                        if (tkn->type_id == TKN_COMMA)
                        {
                            tkn = tkn->next;
                        }
                        else
                        {
                            if (tkn->type_id != TKN_R_PAREN)
                            {
                                fprintf(stderr, "Unexpected input!");
                                exit(1);
                            }
                        }
                    }
                }

                list_node *repl_curr = def->replace->first;
                while (repl_curr)
                {
                    typed_token *tkn = repl_curr->value;
                    if (tkn->type_id == TKN_ID)
                    {
                        list_node *curr_arg = args->first;
                        list_node *curr_arg_name = def->arg_names->first;
                        int found = 0;
                        while (curr_arg_name)
                        {
                            if (strcmp(curr_arg_name->value, tkn->data) == 0)
                            {
                                list_node *arg_tkn = ((linked_list *)curr_arg->value)->first;
                                while (arg_tkn)
                                {
                                    add_to_list(result, arg_tkn->value);
                                    arg_tkn = arg_tkn->next;
                                }
                                found = 1;
                                break;
                            }
                            curr_arg_name = curr_arg_name->next;
                            curr_arg = curr_arg->next;
                        }
                        if (!found)
                        {
                            add_to_list(result, tkn);
                        }
                    }
                    else if (tkn->type_id == TKN_SHARP)
                    {
                        repl_curr = repl_curr->next;
                        tkn = repl_curr->value;
                        if (tkn->type_id != TKN_ID)
                        {
                            fprintf(stderr, "Expected identifier!\n");
                            exit(1);
                        }

                        list_node *curr_arg = args->first;
                        list_node *curr_arg_name = def->arg_names->first;
                        int found = 0;
                        while (curr_arg_name)
                        {
                            if (strcmp(curr_arg_name->value, tkn->data) == 0)
                            {
                                linked_list *subs_list = (linked_list *)curr_arg->value;
                                if (subs_list->count != 1)
                                {
                                    fprintf(stderr, "Invalid stringified arg!");
                                    exit(1);
                                }
                                typed_token *id = (typed_token *)subs_list->first->value;
                                if (id->type_id != TKN_ID)
                                {
                                    fprintf(stderr, "Input must be an identifier!");
                                    exit(1);
                                }
                                typed_token *str_tkn = new_tkn(TKN_LIT_STR, id->data, str_tkn_debug);
                                add_to_list(result, str_tkn);
                                found = 1;
                                break;
                            }
                            curr_arg_name = curr_arg_name->next;
                            curr_arg = curr_arg->next;
                        }
                        if (!found)
                        {
                            fprintf(stderr, "Stringified arg not provided!");
                            exit(1);
                        }
                    }
                    else
                    {

                        add_to_list(result, tkn);
                    }
                    repl_curr = repl_curr->next;
                }

                continue;
            }
        }

        add_to_list(result, clone(tkn));

        tkn = tkn->next;
    }

cleanup:
    if (filename)
        free(filename);

    return chain_tokens(result);
}
