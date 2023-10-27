#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
// #include <string.h>


bool is_letter(const char c) {
    return ('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z');
}

bool single_letter(int i, int j, char puzzle[101][101], int row, int col) {
    // upwards
    bool no_cons = (i < 1) || (puzzle[i - 1][j] == '0');
    if (!no_cons) return false;
    // downwards
    no_cons = (i >= row - 1) || (puzzle[i + 1][j] == '0');
    if (!no_cons) return false;
    // leftside
    no_cons = (j < 1) || (puzzle[i][j - 1] == '0');
    if (!no_cons) return false;
    // rightside
    no_cons = (j >= col - 1) || (puzzle[i][j + 1] == '0');
    if (!no_cons) return false;
    return true;
}

void read_words_n_write_lists(char *fname, FILE *pl_fp) {
    FILE* words_ptr;
    char ch, first_ch = ' ';
    bool first_ch_read = false;
    words_ptr = fopen(fname, "r");

    if (words_ptr == NULL) {
        fprintf(stderr, "file, \"%s\", can't be opened \n", fname);
    }

    while (!feof(words_ptr)) {
        fprintf(pl_fp, "[");
        char last_ch = '\n';
        while (1) {
            if (first_ch_read) {
                ch = first_ch;
                first_ch_read = false;
            } else {
                ch = fgetc(words_ptr);
            }
            if (ch == '\n' || feof(words_ptr)) break;
            if (last_ch != '\n') fprintf(pl_fp, ",");
            last_ch = ch;
            if ('A' <= ch && ch <= 'Z') {
                fprintf(pl_fp, "%c", (ch - 'A') + 'a');
            } else if ('a' <= ch && ch <= 'z') {
                fprintf(pl_fp, "%c", ch);
            } else {
                // Invalid word character
                fprintf(pl_fp, "!Invalid!");
            }
        }
        fprintf(pl_fp, "]");
        first_ch = fgetc(words_ptr);
        first_ch_read = true;
        if (feof(words_ptr) || !is_letter(first_ch)) break;
        fprintf(pl_fp, ",\n            ");
    }
    fclose(words_ptr);
    return;
}

// >>> Debugging testing >>>>>
void print_bin_puzzle_for_testing(char p[101][101], int i) {
    for (int j = 0; j < i; j++) {
        printf("%s", p[j]);
    }
    printf("\n");
    return;
}
// <<<<<<<<<<<<<<<<<<<<<<<<<<<

int get_num_col(char line[101]) {
    int res = 0;
    while (line[res] != '\n') {
        res++;
    }
    return res;
}

int get_num_row(char line[101][101], const int limit) {
    int res = 0;
    while (line[res][0] != '\n') {
        if (res >= limit) return limit;
        res++;
    }
    return res;
}

void write_puzzle_row(const int row, const int start, const int end, FILE *pl_fp) {
    if (row != 1) fprintf(pl_fp, ",\n               ");
    fprintf(pl_fp, "w_info([");
    for (int i = start; i <= end; i++) {
        fprintf(pl_fp, "G_%d_%d", row, i);
        if (i != end) fprintf(pl_fp, ",");
    }
    fprintf(pl_fp, "], g(%d,%d), g(%d,%d))", row, start, row, end);
    // the last ",\n" is left for col to determine
    //   if there is no word position for col, we don't need this ",\n"
    //   if there is at least one word position for col, we need to 
    //   write ",\n" first then write "w_info(...)" for word in col
    return;
}

void write_puzzle_col(const int col, const int start, const int end, FILE *pl_fp) {
    // the first space for col == 1 is left for the caller to print
    // if (col != 1) fprintf(pl_fp, ",\n               tt"); // <<< Debugging testing
    fprintf(pl_fp, "w_info([");
    for (int i = start; i <= end; i++) {
        fprintf(pl_fp, "G_%d_%d", i, col);
        if (i != end) fprintf(pl_fp, ",");
    }
    fprintf(pl_fp, "], g(%d,%d), g(%d,%d))", start, col, end, col);
    return;
}

void read_pattern_n_write_puzzle(char *fname, FILE *pl_fp) {
    FILE* pattern_ptr;
    int i = 0;
    char puzzle[101][101];
    pattern_ptr = fopen(fname, "r");

    if (pattern_ptr == NULL) {
        fprintf(stderr, "file, \"%s\", can't be opened \n", fname);
    }
    // read binpattern file and put it into puzzle[][]
    while (1) {
        if (fgets(puzzle[i], 101, pattern_ptr) == NULL) break;
        // update:
        i++;
    }
    fclose(pattern_ptr);
    int num_row = get_num_row(puzzle, i), num_col = get_num_col(puzzle[0]);
    // print_bin_puzzle_for_testing(puzzle, num_row); // <<< Debugging testing
    // printf("Dim: %d * %d\n", num_row, num_col); // <<< Debugging testing
    
    // write the first element, a visualized puzzle, in Puzzle variable
    fprintf(pl_fp, "[");
    for (i = 0; i < num_row; i++) {
        if (i > 0) fprintf(pl_fp, "               ");
        fprintf(pl_fp, "[");
        for (int j = 0; j < num_col; j++) {
            if (puzzle[i][j] == '0') {
                if (i >= 9 && j >= 9) {
                    fprintf(pl_fp, "   #   ");
                } else if (i >= 9 || j >= 9) {
                    fprintf(pl_fp, "  #   ");
                } else {
                    if (num_row >= 10 || num_col >= 10) fprintf(pl_fp, "  #   ");
                    else fprintf(pl_fp, "  #  ");
                }
            } else {
                fprintf(pl_fp, "G_%d_%d", i + 1, j + 1);
            }
            if ((j + 1) < num_col) fprintf(pl_fp, ",");
        }
        fprintf(pl_fp, "]");
        if ((i + 1) < num_row) fprintf(pl_fp, ",\n");
    }
    fprintf(pl_fp, "],\n");

    // write the second element in Puzzle variable
    //   first find all possible word positions
    //   and then write w_info into file
    fprintf(pl_fp, "              [");
    bool has_row_word = false;
    bool has_col_word = false;

    // find word positions in rows and write corresponding w_info()
    for (i = 0; i < num_row; i++) {
        int start = 0, end = 0;
        bool is_word = false;
        for (int j = 0; j < num_col; j++) {
            if (puzzle[i][j] == '1' && !is_word) {
                start = j + 1;
                is_word = true;
            } else if (puzzle[i][j] == '0' && is_word) {
                end = j;
                is_word = false;
                if (start < end) {
                    write_puzzle_row(i + 1, start, end, pl_fp);
                    has_row_word = true;
                }
            } else if (j == (num_col - 1) && puzzle[i][j] == '1' && is_word) {
                write_puzzle_row(i + 1, start, num_col, pl_fp);
                has_row_word = true;
            }
        }
    }

    // find word positions in cols and write corresponding w_info()
    for (int j = 0; j < num_col; j++) {
        int start = 0, end = 0;
        bool is_word = false;
        for (i = 0; i < num_row; i++) {
            if (puzzle[i][j] == '1' && !is_word) {
                start = i + 1;
                is_word = true;
            } else if (puzzle[i][j] == '0' && is_word) {
                end = i;
                is_word = false;
                if (start < end) {
                    if (has_col_word || has_row_word) {
                        fprintf(pl_fp, ",\n               ");
                    }
                    write_puzzle_col(j + 1, start, end, pl_fp);
                    has_col_word = true;
                }
            } else if (i == (num_row - 1) && puzzle[i][j] == '1' && is_word) {
                if (has_col_word || has_row_word) {
                    fprintf(pl_fp, ",\n               ");
                }
                write_puzzle_col(j + 1, start, num_row, pl_fp);
                has_col_word = true;
            }
        }
    }

    // find single-letter word positions and write corresponding w_info()
    bool second_single_letter_word = false;
    for (i = 0; i < num_row; i++) {
        for (int j = 0; j < num_col; j++) {
            if (puzzle[i][j] == '1' && single_letter(i, j, puzzle, num_row, num_col)) {
                if (second_single_letter_word || has_row_word || has_col_word) {
                    fprintf(pl_fp, ",\n               ");
                }
                int s = i + 1;
                int t = j + 1;
                fprintf(pl_fp, "w_info([G_%d_%d], g(%d,%d), g(%d,%d))", s, t, s, t, s, t);
                second_single_letter_word = true;
            }
        }
    }

    fprintf(pl_fp, "]");
    return;
}


int main(int argc, char **argv) {
    if (argc < 3) {
        fprintf(stderr, "two args needed\n");
    }
    char *wordsfile = *(argv + 1);
    char *patternfile = *(argv + 2);

    FILE *pl_fp;
    pl_fp = fopen ("step2.pl", "w");

    // write words_list
    fprintf(pl_fp, "words_list([");
    read_words_n_write_lists(wordsfile, pl_fp);
    fprintf(pl_fp, "]).\n\n");

    // write crossword rule and Puzzle and write query output into a file
    fprintf(pl_fp, "crossword(Puzzle) :-\n");
    fprintf(pl_fp, "    Puzzle = [");
    read_pattern_n_write_puzzle(patternfile, pl_fp);
    fprintf(pl_fp, "],\n");
    fprintf(pl_fp, "    fill(Puzzle),\n");
    fprintf(pl_fp, "    open('selectedwords.txt',write,Out),\n");
    fprintf(pl_fp, "    write(Out, Puzzle),\n");
    fprintf(pl_fp, "    close(Out).\n\n");

    // write rules for fill()
    fprintf(pl_fp, "fill_words([]).\n");
    fprintf(pl_fp, "fill_words([w_info(Empty_word,_,_)| Rest]) :-\n");
    fprintf(pl_fp, "    words_list(List),\n");
    fprintf(pl_fp, "    member(Empty_word, List),\n");
    fprintf(pl_fp, "    fill_words(Rest).\n\n");
    fprintf(pl_fp, "fill([_|[List_w_info|_]]) :- fill_words(List_w_info).\n");

    fclose(pl_fp);
    return 0;
}