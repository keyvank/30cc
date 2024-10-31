#ifndef PREPROCESS_H
#define PREPROCESS_H

#include "lexer.h"

typed_token *clone(typed_token *tkn);
typed_token *preprocess(typed_token *tkns,
        const char *curr_filename, int depth);

#endif
