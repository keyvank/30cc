void printf(char *, ...);

char is_num(char c)
{
    return (c >= '0' && c <= '9') ? c : 0;
}

char is_letter(char c)
{
    return ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || c == '_') ? c : 0;
}

char is_letter_or_num(char c)
{
    return (is_num(c) || is_letter(c)) ? c : 0;
}

int main()
{
    for (int i = 10; i < 127; i = i + 1)
        printf("Is num: %c %u\n", i, is_letter_or_num(i));
}