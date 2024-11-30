#include "libc.h"
#include "libc.h"

int main()
{
    char *a = "salam ";
    char *b = "khubi";
    char *c = (char *)malloc(100);
    strcpy(c, a);
    strcat(c, b);
    printf("%s\n", c);

    void *file_ptr;
    file_ptr = fopen("output.txt", "w");
    if (!file_ptr)
    {
        printf("Error opening file!");
        return 1;
    }
    fprintf(file_ptr, "Hello, World!\n");
    fclose(file_ptr);
    return 0;
}
