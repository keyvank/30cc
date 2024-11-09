void printf(char *, ...);

int main() {
    char grade = 'B';
    char* s;

    switch(grade) {
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
    printf(s);

    return 0;
}
