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

     for(int i = 0; i >=0; i = i + 1) {
        // 15
        printf("i is %d\n", i);
        for (int j = 0; j < 10; j++) {
        // 19
            printf("j is %d\n", j);
            if (j == 5) {
                break;
            }
        }
        // 20
        break;
    }
        // 16

    return 0;
}
