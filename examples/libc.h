#ifndef LIBC_H
#define LIBC_H

#define NULL 0
void printf(char *, ...);
int strcmp(char *, char *);
void strcat(char *, char *);
void strcpy(char *, char *);
void *malloc(int);
void sprintf(char *, char *, ...);
void fprintf(void *, char *, ...);
extern void *stdout;
extern void *stderr;
void *fopen(char *, char *);
int fclose(void *);
int fread(void *, int, int, void *);

#endif
