#ifndef MACRO_INCLUDE_H
#define MACRO_INCLUDE_H

#include "../linked_list.h"
#include "preprocess.h"

typedef struct
{
    char *path;
} seg_include;

seg *parse_include(prep_ctx *ctx, typed_token **tkns_ptr);

#endif