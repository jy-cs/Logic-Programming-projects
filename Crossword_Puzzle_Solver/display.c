#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "one arg needed\n");
    }
    char *selected = *(argv + 1);
    FILE *selected_ptr = fopen(selected, "r");
    if (selected_ptr == NULL) {
        fprintf(stderr, "file, \"%s\", can't be opened \n", selected);
    }
    // char row[101];
    char c = fgetc(selected_ptr);
    if (c != '[') {
        fprintf(stderr, "file, \"%s\", can't be read \n", selected);
    }
    c = fgetc(selected_ptr);
    if (c != '[') {
        fprintf(stderr, "file, \"%s\", can't be read \n", selected);
    }

    // get length of a row and print the first row
    char first_row[101];
    int len = 0;
    bool end_of_puzzle = false;
    while (1) {
        c = fgetc(selected_ptr);
        if (c == '[' || c == ',') {
            continue;
        } else if (c == ']') {
            c = fgetc(selected_ptr);
            if (c == ',') end_of_puzzle = false;
            else end_of_puzzle = true;
            break;
        } else {
            if ('a' <= c && c <= 'z') {
                c = 'A' + (c - 'a');
            } else if (c == '#') {
                c = ' ';
            }
            first_row[len] = c;
            len++;
        }
    }
    char spliter_row[] = "---";
    for (int i = 0; i < len; i++) {
        printf("%s", spliter_row);
    }
    printf("\n");
    for (int i = 0; i < len; i++) {
        c = first_row[i];
        printf("[%c]", c);
    }
    printf("\n");
    for (int i = 0; i < len; i++) {
        printf("%s", spliter_row);
    }
    printf("\n");

    // read Puzzle and output
    if (end_of_puzzle) {
        fclose(selected_ptr);
        return 0;
    }
    while (1) {
        c = fgetc(selected_ptr);
        if (c == '[' || c == ',') {
            continue;
        } else if (c == ']') {
            printf("\n");
            for (int i = 0; i < len; i++) {
                printf("%s", spliter_row);
            }
            printf("\n");
            c = fgetc(selected_ptr);
            if (c == ',') continue;
            else break;
        } else {
            if ('a' <= c && c <= 'z') {
                c = 'A' + (c - 'a');
            } else if (c == '#') {
                c = ' ';
            }
            printf("[%c]", c);
        }
    }

    fclose(selected_ptr);
    return 0;
}

