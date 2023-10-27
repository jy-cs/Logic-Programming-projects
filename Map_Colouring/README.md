# Map Colouring
## I. How to provide different maps and different colour sets
### 1. Construction of a Map:
        A map is represented by Graph starting from line-38
        Assume we have an arbitrary map, M, of n regions on it, and
            each region is distinctly labeled as R_{i}, where 1 <= i <= n.
        We can map the map M to a planar graph, G, where
            G = {V, E}
              = {{R_{i} | 1 <= i <= n},
                 {e(R_{i}, R_{j}) | R_{i} and R_{j} share some segment of border in M ,i != j}}
        In our prolog program, from line-38 to line-50,
            we define G as a nested list in the form of 
            [[R_{1}, R_{2}, ..., R_{n}],
             [e(R_{i_1}, R_{j_1}),
              e(R_{i_2}, R_{j_2}),
              ...
              ...
              e(R_{i_m}, R_{j_m})]]
        Note that each Node is a variable, the first letter of the region label should
            be capitalized
### 2. Construction of a Colour Set:
        A colour set is represented by colour_set(List) at line-36,
            where List is either
                          * an empty list, or
                          * a list of colour labels
        Note that each colour in the list is a constant

## II. The meaning of each symbol introduced in the program
    1. colour_set(list)
        Type: Predicate symbol
        Meaning: The colour set, list, is a set of colours.

    2. result(Graph)
        Type: Predicate symbol
        Meaning: A map, Graph, can be coloured in a way that no two adjacent regions are
                 given in the same colour.

    3. e(A, B)
        Type: Function symbol
        Meaning: e(A, B) produces an edge between node A and node B in a graph.

    4. colouring_nodes(Graph, Colours)
        Type: Predicate symbol
        Meaning: Every node in Graph can be coloured by the colour labels from 
                 the colour set, Colours.
    
    5. diff(Graph)
        Type: Predicate symbol
        Meaning: Every pair of adjacent nodes in Graph are given different colours.
    
    6. diff_edge_set(E2)
        Type: Predicate symbol
        Meaning: Every pair of adjacent nodes in the edge set, E2, are given different colours.
    
    7. diff_edge_colour(E1)
        Type: Predicate symbol
        Meaning: Two nodes that are both incident with the edge, E1, are given different colours.

