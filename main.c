#include "libc.h"
#include "lexer.h"
#include "parser/program.h"
#include "linked_list.h"
#include "preprocess/preprocess.h"
#include "preprocess/macro_define.h"

typed_token *process(char *filename, int log_lex, int log_prep)
{
    prep_ctx *ctx = (prep_ctx *)malloc(sizeof(prep_ctx));
    ctx->curr_path = NULL;
    ctx->defs = new_linked_list();

    seg_define *_30cc_define = (seg_define *)malloc(sizeof(seg_define));
    _30cc_define->arg_names = new_linked_list();
    _30cc_define->id = "_30CC";
    _30cc_define->replace = new_linked_list();
    add_to_list(ctx->defs, _30cc_define);

    typed_token *lexed = tokenize_file(filename);
    if (log_lex)
    {
        typed_token *t = lexed;
        while (t)
        {
            t->debug(t);
            t = t->next;
        }
    }

    typed_token *prep = preprocess(ctx, filename);
    if (log_prep)
    {
        typed_token *t = prep;
        while (t)
        {
            t->debug(t);
            t = t->next;
        }
    }

    return prep;
}

int main(int argc, char **argv)
{
    if (argc != 3)
    {
        fprintf(stderr, "Usage: %s <filename> <mode> (<mode>: --lex, --prep, --asm or --tree)\n", argv[0]);
        return 1;
    }

    if (strcmp(argv[2], "--lex") != 0 && strcmp(argv[2], "--asm") != 0 && strcmp(argv[2], "--tree") != 0 && strcmp(argv[2], "--prep") != 0)
    {
        fprintf(stderr, "Unknown argument %s", argv[2]);
        return 1;
    }

    int log_lex = !strcmp(argv[2], "--lex");
    int log_prep = !strcmp(argv[2], "--prep");

    typed_token *tkn = process(argv[1], log_lex, log_prep);
    if (tkn == NULL)
    {
        return 1;
    }

    parser_node *prog = parse_program(&tkn);
    if (prog)
    {
        if (strcmp(argv[2], "--tree") == 0)
        {
            prog->debug(0, prog);
            return 0;
        }
    }
    else
    {
        fprintf(stderr, "Parse failed!\n");
        return 1;
    }

    if (strcmp(argv[2], "--asm") == 0)
    {
        context *ctx = new_context();
        prog->apply(prog, ctx);
        list_node *curr = ctx->data->first;
        printf("section .data\n");
        while (curr)
        {
            printf("%s\n", (char *)curr->value);
            curr = curr->next;
        }
        printf("section .text\n");
        curr = ctx->text->first;
        while (curr)
        {
            printf("%s\n", (char *)curr->value);
            curr = curr->next;
        }
    }

    return 0;
}
