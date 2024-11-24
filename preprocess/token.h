#ifndef TOKEN_H
#define TOKEN_H

#include "../linked_list.h"
#include "preprocess.h"
#include "../lexer.h"

typedef struct
{
    typed_token *tkn;
} seg_tkn;

seg *parse_token(prep_ctx *ctx, typed_token **tkns_ptr);

#endif

