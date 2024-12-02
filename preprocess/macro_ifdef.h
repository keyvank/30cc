#ifndef MACRO_IFDEF_H
#define MACRO_IFDEF_H

#include "../linked_list.h"
#include "preprocess.h"

typedef struct
{
    int ndef;
    char *def;
    typed_token *endif;
} seg_ifdef;

seg_ifdef *parse_ifdef(prep_ctx *ctx, typed_token **tkns_ptr);
int is_endif(typed_token *tkn);

#endif