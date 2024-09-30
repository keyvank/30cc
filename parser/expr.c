
#include <stdlib.h>

#include "../lexer.h"
#include "parser.h"
#include "expr.h"
#include "literal.h"

void binary_op_debug(int depth, parser_node *node)
{
    node_binary_op *binop = (node_binary_op *)node->data;
    printtabs(depth);
    printf("BinaryOp(Op: %d)\n", binop->op);
    printtabs(depth + 1);
    printf("Left:\n");
    binop->left->debug(depth + 2, binop->left);
    printtabs(depth + 1);
    printf("Right:\n");
    binop->right->debug(depth + 2, binop->right);
}

parser_node *parse_expr(typed_token **tkns_ptr)
{
    typed_token *tkn = *tkns_ptr;

    parser_node *left = NULL;

    if (tkn->type_id == TKN_L_PAREN)
    {
        tkn = tkn->next;
        left = parse_expr(&tkn);
        if (left)
        {
            if (tkn->type_id == TKN_R_PAREN)
            {
                tkn = tkn->next;
            }
        }
        else
        {
            return NULL;
        }
    }

    if (!left)
        left = parse_literal(&tkn);

    if (left)
    {
        if (tkn->type_id == TKN_PLUS)
        {
            tkn = tkn->next;
            parser_node *right = parse_expr(&tkn);
            if (right)
            {
                *tkns_ptr = tkn;

                parser_node *node = (parser_node *)malloc(sizeof(parser_node));
                node->type = NODE_FUNCTION;
                node->data = (void *)malloc(sizeof(node_binary_op));
                node->debug = binary_op_debug;
                node_binary_op *binop = (node_binary_op *)node->data;
                binop->left = left;
                binop->right = right;
                binop->op = TKN_PLUS;

                return node;
            }
            else
            {
                return NULL;
            }
        }
        else
        {
            *tkns_ptr = tkn;
            return left;
        }
    }

    return NULL;
}