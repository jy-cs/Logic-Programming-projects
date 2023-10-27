# Crossword Puzzle Solver
## I. Query that solves the puzzle in Step 1
    crossword(X).

## II. How to understand the selectedwords.txt
    "selectedwords.txt" contains the value of variable, Puzzle, in 
    the crossword(Puzzle) rule. It is a list of two elements. First
    element is a list of rows of the puzzle. It implements the puzzle 
    with filling grid of variable and empty grid of "#" symbol. The 
    second element is a list of function symbols, w_info. w_info provides
    information of one word in the puzzle. The first argument of w_info
    is a list of adjacent variables in the puzzle, the second and third
    argument is the starting grid and ending grid of the word.

## III. How to compile and run
    $ gcc generator.c -o generator.o
    $ gcc display.c -o display.o
    $ ./generator.o words1.txt binpattern1.txt
    -> run step2.pl
    $ ./display.o selectedwords.txt
    -> showing the result as a standard output
    $ ./generator.o words2.txt binpattern2.txt
    -> run step2.pl
    $ ./display.o selectedwords.txt
    -> showing the result as a standard output
