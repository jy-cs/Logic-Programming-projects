# Symmetric Binary Tree Verification
## I. The meaning of each symbol introduced in the program
### 1. is_symmetric(BT)
        Type: Predicate symbol
        Meaning: The binary tree, BT, is symmetric.
### 2. are_mirror_image(BT_1, BT_2)
        Type: Predicate symbol
        Meaning: The binary tree, BT_1, and the binary tree, BT_2, are mirror images.
                 If we put BT_1 and BT_2 horizontally with same level(meaning that
                 two roots are on same level of height, the children of the roots 
                 are on the same level of height, and so on), we can draw a vertical
                 line through the gap between BT_1 and BT_2 so that BT_1 mirrors
                 BT_2.
### 3. bt(Val, Left, Right)
        Type: Function symbol
        Meaning: bt(Val, Left, Right) produces a binary tree with a node containing
                 the value of Val, a left subtree of Left, and a right subtree of
                 Right.
                 Val can be any data type.
                 Left and Right are binary tree data structures defined by either
                 bt(_ ,_ ,_ ) recursively or empty(meaning empty tree).
### 4. empty
        Type: constant, term
        Meaning: empty tree
### 5. Left, Right, BT1_Left, BT1_Right, BT2_Left, BT2_Right
        Type: variable, term
        Meaning: binary trees

## II. List all the function symbols introduced in the program
    1. bt(Val, Left, Right)

## III. List all the predicate symbols introduced in the program
    1. is_symmetric(BT)
    2. are_mirror_image(BT_1, BT_2)

## IV. The query to check whether the sample binary tree is symmetric
    1. Example
is_symmetric(bt(a0, bt(a1, bt(a2, bt(a3, empty, empty),
                           bt(a4, bt(a5, empty, empty),
                                  bt(a6, bt(a7, empty, empty), 
                                         bt(a8, empty, empty)))),
                    bt(a9, empty, empty)),
             bt(a10, bt(a11, empty, empty),
                     bt(a12, bt(a13, bt(a14, bt(a15, empty, empty),
                                             bt(a16, empty, empty)),
                                     bt(a17, empty, empty)),
                             bt(a18, empty, empty))))).
