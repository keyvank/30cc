#ifndef VEC_H
#define VEC_H

typedef struct {
    void ** items;
    int capacity;
    int total;
    int item_size;
} vector;

vector *initialize_vec(int);
void push_vec(vector*, void*);
void *get_vec(vector*, int );

#endif
