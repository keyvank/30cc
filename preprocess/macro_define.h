#ifndef MACRO_DEFINE_H
#define MACRO_DEFINE_H

#include "../linked_list.h"
#include "preprocess.h"

typedef struct
{
    char *id;
    linked_list *arg_names;
    linked_list *replace;
} seg_define;

seg *parse_define(prep_ctx *ctx, typed_token **tkns_ptr);
seg_define *find_define(prep_ctx *defs, char *id);

#endif