void *malloc(int sz);
void printf(char *s, ...);

typedef struct node_
{
    int val;
    struct node_ *next;
} node;

struct linked_list
{
    node *first;
};

struct linked_list *new_list()
{
    struct linked_list *ret = (struct linked_list *)malloc(sizeof(struct linked_list));
    return ret;
}

void add_val(struct linked_list *lst, int val)
{
    node *new = (node *)malloc(sizeof(node));
    *((int *)(&new->next)) = 0;
    new->val = val;
    if (lst->first)
    {
        node *curr = lst->first;
        while (curr->next)
        {
            curr = (struct node *)curr->next;
        }
        curr->next = new;
    }
    else
    {
        lst->first = new;
    }
}

int main()
{
    struct linked_list *lst = new_list();
    add_val(lst, 123);
    add_val(lst, 432);
    add_val(lst, 999);
    add_val(lst, 873);
    node *curr = lst->first;
    while (curr)
    {
        printf("%u\n", curr->val);
        curr = (struct node *)curr->next;
    }
    return 0;
}
