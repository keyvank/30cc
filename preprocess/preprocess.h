#ifndef PREPROCESS_H
#define PREPROCESS_H

#include "../lexer.h"

typedef struct
{
    linked_list *defs;
} prep_ctx;

typedef struct seg_
{
    char *stringified;
    void *data;
    linked_list *(*to_code)(struct seg_ *self, prep_ctx *ctx);
} seg;

typed_token *preprocess(typed_token *tkn);

#endif