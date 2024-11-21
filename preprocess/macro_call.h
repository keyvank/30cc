#ifndef MACRO_CALL_H
#define MACRO_CALL_H

#include "../linked_list.h"
#include "preprocess.h"
#include "macro_define.h"

typedef struct
{
    seg_define *def;
    linked_list *args;
} seg_macro_call;

seg *parse_macro_call(prep_ctx *ctx, typed_token **tkns_ptr);

#endif