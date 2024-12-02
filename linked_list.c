#include "libc.h"
#include "linked_list.h"

linked_list *new_linked_list()
{
    linked_list *l = (linked_list *)malloc(sizeof(linked_list));
    l->first = NULL;
    l->last = NULL;
    l->count = 0;
    return l;
}

void add_to_list(linked_list *l, void *value)
{
    list_node *node = (list_node *)malloc(sizeof(list_node));
    node->value = value;
    node->next = NULL;
    node->prev = l->last;

    if (l->first == NULL)
    {

        l->first = node;
        l->last = node;
    }
    else
    {
        l->last->next = node;
        l->last = node;
    }
    l->count++;
}

void pop_list(linked_list *l)
{
    if (l->last)
    {
        list_node *new_last = l->last->prev;
        if (new_last)
            new_last->next = NULL;
        l->last = new_last;
        l->count--;
        // When we pop the last element also set the first to null
        if (l->count == 0)
            l->first = NULL;
    }
}

void free_list(linked_list *l)
{
    list_node *ptr = l->first;
    while (ptr)
    {
        list_node *tmp = ptr;
        ptr = ptr->next;
        free(tmp);
    }
}
