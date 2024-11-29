void *malloc(int);
void printf(char *, ...);
void sprintf(char *, char *, ...);

#define PUSHARGS() __asm__("push rdi" \
                           "push rsi" \
                           "push rdx" \
                           "push rcx" \
                           "push r8"  \
                           "push r9")
#define SLARGS() __asm__("mov rdi, rsi" \
                         "mov rsi, rdx" \
                         "mov rdx, rcx" \
                         "mov rcx, r8"  \
                         "mov r8, r9"   \
                         "mov r9, 0")
#define SRARGS() __asm__("mov r9, r8"   \
                         "mov r8, rcx"  \
                         "mov rcx, rdx" \
                         "mov rdx, rsi" \
                         "mov rsi, rdi" \
                         "mov rdi, 0")
#define POPARGS() __asm__("pop r9"  \
                          "pop r8"  \
                          "pop rcx" \
                          "pop rdx" \
                          "pop rsi" \
                          "pop rdi")

char *cc_asprintf(char *inp, ...)
{
    SRARGS();
    PUSHARGS();
    char *ret = (char *)malloc(128);
    POPARGS();
    sprintf(ret, inp);
    return ret;
}

int main()
{
    char *ret = cc_asprintf("salam %s %u%c", "donya", 123, '!');
    printf("%s %s\n", "haha", ret);
    return 0;
}