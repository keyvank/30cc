void printf(char *, ...);

int main() {
    int i = 0;
    while(1) {
        if (i==0) {
            printf("i is 0\n");
            continue;
        }
        break;
    }

    for(int i = 0; i >=0; i = i + 1) {
        if (i==0) {
            printf("i is 0\n");
            continue;
        }
        if (i==1) {
            break;
        }
    }
    return 0;
}
