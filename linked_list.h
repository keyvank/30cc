#ifndef LINKED_LIST_H
#define LINKED_LIST_H

typedef struct node_
{
    void *value;
    struct node_ *next;
    struct node_ *prev;
} list_node;

typedef struct
{
    int count;
    list_node *first;
    list_node *last;
} linked_list;

linked_list *new_linked_list();
void free_list(linked_list *l);
void pop_list(linked_list *l);

void add_to_list(linked_list *l, void *value);
#endif