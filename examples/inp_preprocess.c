void printf(char *, ...);

#define DEBUG 1

#ifdef DEBUG
int function() {
    return 69;
}
#endif

#ifdef RELEASE
int function() {
    return 13;
}
#endif

int main() {
    printf("value is %d\n", function());
    return 0;
}
