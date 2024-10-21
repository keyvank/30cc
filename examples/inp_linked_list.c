void *malloc(int sz);
void printf(char *s, ...);

struct node
{
    int val;
    void *next;
};

struct linked_list
{
    struct node *first;
};

struct linked_list *new_list()
{
    struct linked_list *ret = (struct linked_list *)malloc(sizeof(struct linked_list));
    return ret;
}

void add_val(struct linked_list *lst, int val)
{
    struct node *new = (struct node *)malloc(sizeof(struct node));
    *((int *)(&new->next)) = 0;
    new->val = val;
    if (lst->first)
    {
        struct node *curr = lst->first;
        while (curr->next)
        {
            curr = (struct node *)curr->next;
        }
        curr->next = (void *)new;
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
    struct node *curr = lst->first;
    while (curr)
    {
        printf("%u\n", curr->val);
        curr = (struct node *)curr->next;
    }
}