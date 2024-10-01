typedef struct node_
{
    void *value;
    struct node_ *next;
} list_node;

typedef struct
{
    list_node *first;
    list_node *last;
} linked_list;

linked_list *new_linked_list();
void free_list(linked_list *l);

void add_to_list(linked_list *l, void *value);
