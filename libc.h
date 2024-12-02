#ifndef LIBC_H
#define LIBC_H

#ifndef _30CC
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#endif

#ifdef _30CC
#define NULL 0
void printf(char *, ...);
int strcmp(char *, char *);
void strcat(char *, char *);
void strcpy(char *, char *);
void *malloc(int);
void *calloc(int, int);
void *realloc(void *, int);
void free(void *);
void sprintf(char *, char *, ...);
void fprintf(void *, char *, ...);
extern void *stdout;
extern void *stderr;
void *fopen(char *, char *);
int fclose(void *);
int fread(void *, int, int, void *);
void exit(int);
void memcpy(void *, void *, int);
#endif

#endif
