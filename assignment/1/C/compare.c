int first_ineq(char *a, char *b) {
    int i = 0;

    start_loop:
    if (a[i] == '\0') goto terminate;
    if (b[i] == '\0') goto terminate;
    if (a[i] != b[i]) goto terminate;
    ++i;
    goto start_loop;
    
    terminate: return i;
}

char to_lower(char c) {
    if (c < 'A') goto terminate;
    if (c > 'Z') goto terminate;
    c += 'a' - 'A';
    terminate:
    return c;
}

int first_ineq(char *a, char *b) {
    int i = 0;

    start_loop:
    if (a[i] == '\0') goto terminate;
    if (b[i] == '\0') goto terminate;
    if (to_lower(a[i]) != to_lower(b[i])) goto terminate;
    ++i;
    goto start_loop;
    
    terminate: return i;
}

int compare(char *a, char *b, int type) {
    // type = 0 -> case sensitive
    if (type == 0) {
        int i = first_ineq(a, b);
        if (a[i] == b[i]) return 0;
        else if (a[i] < b[i]) return -1;
        else return +1;
    } else {
        int i = first_ineq_insensitive(a, b);
        if (to_lower(a[i]) == to_lower(b[i])) return 0;
        else if (to_lower(a[i]) < to_lower(b[i])) return -1;
        else return +1;
    }
}


#include <stdio.h>
int main() {
	char a[20], b[20];
	scanf("%s", a);
	scanf("%s", b);
	printf("%d\n", compare(a, b, 0));
	printf("%d\n", compare(a, b, 1));
}
