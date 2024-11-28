#ifndef MACRO_IFNDEF_H
#define MACRO_IFNDEF_H

#include "../linked_list.h"
#include "preprocess.h"

typedef struct
{
    char *def;
} seg_ifndef;

seg_ifndef *parse_ifndef(prep_ctx *ctx, typed_token **tkns_ptr);
int is_endif(typed_token *tkn);

#endif