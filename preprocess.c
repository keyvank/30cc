#include <stdlib.h>
#include <string.h>
#include "lexer.h"
#include "linked_list.h"
#include "preprocess.h"
#include "codegen/codegen.h"

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

typed_token *preprocess(typed_token *tkns)
{
    linked_list defines = new_linked_list();

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
                add_to_list(&defines, (void *)def);
                tkn = tkn->next;
                continue;
            }
        }

        if (tkn->type_id == TKN_ID)
        {
            define *def = find_def(&defines, (char *)tkn->data);
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
    return first;
}
