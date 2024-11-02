void printf(char *, ...);

int main() {
  int a = 2;

  printf("first\n");
  goto end;

  a = 69;
  printf("second\n"); // will never printed

end:
  printf("%d\n", a);
}
