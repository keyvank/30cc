

#include <stdlib.h>

#include "../lexer.h"
#include "parser.h"
#include "binary_op.h"
#include "expr.h"

void binary_op_debug(int depth, parser_node *node)
{
    node_binary_op *binop = (node_binary_op *)node->data;
    printtabs(depth);
    printf("BinaryOp(Op: %d)\n", binop->op);
    printtabs(depth + 1);
    printf("Left:");
    binop->left->debug(depth + 2, binop->left);
    printf("Right:");
    binop->right->debug(depth + 2, binop->right);
}

parser_node *parse_binary_op(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;

    parser_node *left = parse_expr(&tkn);
    if (left)
    {
        if (tkn->type_id == TKN_PLUS)
        {
            tkn = tkn->next;
            parser_node *right = parse_expr(&tkn);
            if (right)
            {
                printf("DETECTED!");
            }
            else
            {
                return NULL;
            }
        }
        else
        {
            return NULL;
        }
    }

    return NULL;
}