

#include "../../libc.h"
#include "../../lexer.h"
#include "../parser.h"
#include "access.h"

void access_debug(int depth, parser_node *node)
{
    node_access *acc = (node_access *)node->data;
    printtabs(depth);
    printf("Access:\n");
    printtabs(depth + 1);
    printf("Object:\n");
    acc->object->debug(depth + 2, acc->object);
    printtabs(depth + 1);
    printf("Field: %s\n", acc->field_name);
    printtabs(depth + 1);
    printf("IsPtr: %u\n", acc->is_ptr);
}

apply_result *access_apply(parser_node *node, context *ctx)
{
    node_access *acc = (node_access *)node->data;

    apply_result *obj = acc->object->apply(acc->object, ctx);
    char *struct_name = NULL;
    if (acc->is_ptr)
    {
        struct_name = ((struct_type *)((pointer_type *)obj->type->data)->of->data)->struct_name;
    }
    else
    {
        struct_name = ((struct_type *)obj->type->data)->struct_name;
    }
    context_struct *ctx_struct = find_struct(ctx, struct_name);

    int offset = 0;
    general_type *field_type = NULL;
    for (int i = 0; i < ctx_struct->num_fields; i++)
    {
        if (strcmp(ctx_struct->field_names[i], acc->field_name) == 0)
        {
            field_type = ctx_struct->fields[i];
            break;
        }
        offset += ctx_struct->fields[i]->size(ctx_struct->fields[i], ctx);
    }
    if (field_type)
    {
        symbol *sym_addr = new_temp_symbol(ctx, new_pointer_type(field_type));

        if (acc->is_ptr)
            add_text(ctx, "mov rax, %s", obj->code);
        else
            add_text(ctx, "mov rax, %s", obj->addr_code);
        add_text(ctx, "add rax, %u", offset);
        add_text(ctx, "mov %s, rax", sym_addr->repl);

        symbol *sym_val = new_temp_symbol(ctx, field_type);
        char *rega = reg_a(field_type, ctx);

        // We don't need to store the value of a field which its type is
        // non-primitive into a register! Its address is the only thing
        // the user needs, for accessing its sub-fields!
        if (rega)
        {
            add_text(ctx, "mov %s, [rax]", rega);
            add_text(ctx, "mov %s, %s", sym_val->repl, rega);
        }

        apply_result *res = new_result(sym_val->repl, field_type);
        res->addr_code = sym_addr->repl;
        return res;
    }
    else
    {
        fprintf(stderr, "Field '%s' not found!\n", acc->field_name);
        exit(1);
        return NULL;
    }
}

parser_node *parse_access(typed_token **tkns_ptr, parser_node *obj)
{
    typed_token *tkn = *tkns_ptr;

    if (tkn->type_id == TKN_DOT || tkn->type_id == TKN_ARROW)
    {
        int is_ptr = tkn->type_id == TKN_ARROW;
        tkn = tkn->next;
        if (tkn->type_id == TKN_ID)
        {
            typed_token *field_tkn = tkn;
            tkn = tkn->next;
            *tkns_ptr = tkn;
            parser_node *node = (parser_node *)malloc(sizeof(parser_node));
            node->data = (void *)malloc(sizeof(node_access));
            node->debug = access_debug;
            node->apply = access_apply;
            node_access *acc = (node_access *)node->data;
            acc->object = obj;
            acc->field_name = cc_asprintf("%s", field_tkn->data);
            acc->is_ptr = is_ptr;

            return node;
        }
        else
        {
            return NULL;
        }
    }

    return NULL;
}