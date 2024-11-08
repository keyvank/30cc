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

#ifndef RELEASE
int function2() {
    return 99;
}
#endif

int main() {
    printf("function(): %d\n", function());
    printf("function2(): %d\n", function2());
    return 0;
}
