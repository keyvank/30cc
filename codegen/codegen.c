#include <stdio.h>

#include "codegen.h"
#include "../linked_list.h"

context new_context()
{
    context ctx;
    ctx.data = new_linked_list();
    ctx.text = new_linked_list();
    return ctx;
}