#include <stdlib.h>
#include "linked_list.h"

linked_list new_linked_list()
{
    linked_list l;
    l.first = NULL;
    l.last = NULL;
    l.count = 0;
    return l;
}

void add_to_list(linked_list *l, void *value)
{
    list_node *node = (list_node *)malloc(sizeof(list_node));
    node->value = value;
    node->next = NULL;

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