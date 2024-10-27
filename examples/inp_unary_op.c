void printf(char *, ...);

int main() {
  int a = 2;
  printf("%d\n", -a);
  printf("%d\n", --a);
  printf("%d\n", !a);
  printf("%d\n", !!a);
  printf("%d\n", +-a);
  printf("%d\n", ++a);
  printf("%d\n", a++);
  printf("%d\n", a--);

  for (int i = 0; i < 5; i++) {
    printf("%d\n", i);
  }
}
