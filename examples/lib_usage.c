void printf(char *, ...);
int strcmp(char *, char *);
void strcat(char *, char *);
void strcpy(char *, char *);
void *malloc(int);
void fprintf(FILE *, char *, ...);

typedef struct
{
    char *_ptr;
    int _cnt;
    char *_base;
    int _flag;
    int _file;
    int _charbuf;
    int _bufsiz;
    char *_tmpfname;
} FILE;

FILE *fopen(char *, char *);
int fclose(FILE *);

int main()
{
    char *a = "salam ";
    char *b = "khubi";
    char *c = (char *)malloc(100);
    strcpy(c, a);
    strcat(c, b);
    printf("%s\n", c);

    FILE *file_ptr;
    file_ptr = fopen("output.txt", "w");
    if (!file_ptr)
    {
        printf("Error opening file!");
        return 1;
    }
    fprintf(file_ptr, "Hello, World!\n");
    fclose(file_ptr);
}