#ifndef UTILS_H
#define UTILS_H

#include "../lexer.h"

int type_size(int type_id)
{
    switch (type_id)
    {
    case TKN_INT:
        return 8;
        break;
    case TKN_CHAR:
        return 8;
    default:
        break;
    }
}

#endif