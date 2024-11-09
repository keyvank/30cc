void printf(char *, ...);

int main() {
    char grade = 'B';
    char* s;

    // Switch with case and default
    switch(grade) {
        // this print is not happening on cc
        printf("1");

        case 'A':
            s = "Excellent!\n";
            break;
        case 'B':
        case 'C':
            s = "Well done\n";
            break;
        case 'D':
            s = "You passed\n";
            break;
        case 'F':
            s = "Better try again\n";
            break;
        default:
            s = "Invalid grade\n";
    }


    // Switch with only default case
    switch(1) {
        default:
            printf("default case\n");
    }

    // Switch without default case
    switch(2) {
        case 2:
            printf("is two\n");
    }
    printf("%s\n", s);

    return 0;
}
