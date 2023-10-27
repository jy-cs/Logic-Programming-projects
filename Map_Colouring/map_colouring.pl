% *******************************
% Construction of a Map:
%     A map is represented by Graph starting from line-38
%     Assume we have an arbitrary map, M, of n regions on it, and
%         each region is distinctly labeled as R_{i}, where 1 <= i <= n.
%     We can map the map M to a planar graph, G, where
%         G = {V, E}
%           = {{R_{i} | 1 <= i <= n},
%              {e(R_{i}, R_{j}) | R_{i} and R_{j} share some segment of border in M ,i != j}}
%     In our prolog program, from line-38 to line-50,
%         we define G as a nested list in the form of 
%         [[R_{1}, R_{2}, ..., R_{n}],
%          [e(R_{i_1}, R_{j_1}),
%           e(R_{i_2}, R_{j_2}),
%           ...
%           ...
%           e(R_{i_m}, R_{j_m})]]
%     Note that each Node is a variable, the first letter of the region label should
%         be capitalized
%
% Construction of a Colour Set:
%     A colour set is represented by colour_set(List) at line-36,
%         where List is either
%                       * an empty list, or
%                       * a list of colour labels
%     Note that each colour in the list is a constant
% *******************************

colour_set([r, g, b]).
result(Graph) :-
    Graph = [[A, B, C, D, E, F],
             [e(A, B), 
              e(A, C),
              e(A, D),
              e(A, F),
              e(B, C),
              e(B, E),
              e(B, F),
              e(C, D),
              e(C, E),
              e(D, E),
              e(D, F),
              e(E, F)]],
    colour_set(Colours),
    colouring_nodes(Graph, Colours),
    diff(Graph).

colouring_nodes([[]|_], _).
colouring_nodes([[Node|Rest_nodes], Edge_set], Colours) :-
    member(Node, Colours),
    colouring_nodes([Rest_nodes, Edge_set], Colours).

diff_edge_colour(e(N1_colour, N2_colour)) :-
    N1_colour \= N2_colour.

diff_edge_set([]).
diff_edge_set([E1|T]) :-
    diff_edge_colour(E1),
    diff_edge_set(T).

diff([_|[E2|_]]) :-
    diff_edge_set(E2).

% Sample Map and Colour Set on the Assignment Instruction
% (Map) 
%     Graph = [[A, B, C, D, E, F],
%              [e(A, B), 
%               e(A, C),
%               e(A, D),
%               e(A, F),
%               e(B, C),
%               e(B, E),
%               e(B, F),
%               e(C, D),
%               e(C, E),
%               e(D, E),
%               e(D, F),
%               e(E, F)]]
% (Colour Set)
%     colour_set([r, g, b]).
%
%
% My Test Cases
%
% Query: result(X).
% 1. (Map) 
%        Graph = [[Region_1],
%                 []]
%    (Colour Set)
%        colour_set([]). % empty colour set
%    Expected Output: False
%
% 2. (Map) 
%        Graph = [[Region_1],
%                 []]
%    (Colour Set)
%        colour_set([lavender, cerulean]). 
%    Expected Output: All Colouring Found
%    
% 3. (Map) 
%        Graph = [[Region_1, Region_2],
%                 [e(Region_1, Region_2)]]
%    (Colour Set)
%        colour_set([lavender, cerulean, olive]). 
%    Expected Output: All Colouring Found
%
% 4. (Map) 
%        Graph = [[Region_1, Region_2],
%                 [e(Region_1, Region_2)]]
%    (Colour Set)
%        colour_set([olive]). 
%    Expected Output: False
%    
% 5. (Map) 
%        Graph = [[Region_1, Region_2],
%                 []]
%    (Colour Set)
%        colour_set([olive]). 
%    Expected Output: All Colouring Found
%
% 6. (Map) 
%        Graph = [[Region_1, Region_2, Region_3],
%                 [e(Region_1, Region_2),
%                  e(Region_1, Region_3),
%                  e(Region_2, Region_3)]]
%    (Colour Set)
%        colour_set([indigo, teal, cyan]). 
%    Expected Output: All Colouring Found
%
% 7. (Map) 
%        Graph = [[Region_1, Region_2, Region_3],
%                 [e(Region_1, Region_2),
%                  e(Region_1, Region_3),
%                  e(Region_2, Region_3)]]
%    (Colour Set)
%        colour_set([teal, cyan]). 
%    Expected Output: False
%
% 8. (Map) 
%        Graph = [[Region_1, Region_2, Region_3],
%                 [e(Region_1, Region_2),
%                  e(Region_2, Region_3)]]
%    (Colour Set)
%        colour_set([teal, cyan, magenta, amber]). 
%    Expected Output: All Colouring Found
%
% 9. (Map) 
%        Graph = [[Region_1, Region_2, Region_3],
%                 [e(Region_1, Region_2),
%                  e(Region_2, Region_3)]]
%    (Colour Set)
%        colour_set([magenta, amber]). 
%    Expected Output: All Colouring Found
%
% 10. (Map) 
%        Graph = [[Region_1, Region_2, Region_3],
%                 [e(Region_1, Region_2),
%                  e(Region_2, Region_3)]]
%    (Colour Set)
%        colour_set([amber]). 
%    Expected Output: False
%    
% 11. (Map) 
%        Graph = [[Region_1, Region_2, Region_3, Region_4],
%                 [e(Region_1, Region_2),
%                  e(Region_1, Region_3),
%                  e(Region_1, Region_4),
%                  e(Region_2, Region_3),
%                  e(Region_2, Region_4),
%                  e(Region_3, Region_4)]]
%    (Colour Set)
%        colour_set([teal, cyan, magenta, amber]). 
%    Expected Output: All Colouring Found
%    
% 12. (Map) 
%        Graph = [[Region_1, Region_2, Region_3, Region_4],
%                 [e(Region_1, Region_2),
%                  e(Region_1, Region_3),
%                  e(Region_1, Region_4),
%                  e(Region_2, Region_3),
%                  e(Region_2, Region_4),
%                  e(Region_3, Region_4)]]
%    (Colour Set)
%        colour_set([cyan, magenta, amber]). 
%    Expected Output: False
% 
% 13. (Map) 
%        Graph = [[Region_1, Region_2, Region_3, Region_4],
%                 [e(Region_1, Region_2),
%                  e(Region_1, Region_3),
%                  e(Region_2, Region_4)]]
%    (Colour Set)
%        colour_set([magenta, amber]). 
%    Expected Output: All Colouring Found
%    
% 14. (Map) 
%        Graph = [[Region_1, Region_2, Region_3, Region_4],
%                 [e(Region_1, Region_2),
%                  e(Region_1, Region_3),
%                  e(Region_2, Region_4)]]
%    (Colour Set)
%        colour_set([amber]). 
%    Expected Output: False
%    
% 15. (Map) 
%        Graph = [[Region_1, Region_2, Region_3, Region_4],
%                 [e(Region_1, Region_2),
%                  e(Region_1, Region_3),
%                  e(Region_2, Region_4),
%                  e(Region_3, Region_4)]]
%    (Colour Set)
%        colour_set([amber, magenta]). 
%    Expected Output: All Colouring Found
%
% 16. (Map) 
%        Graph = [[Region_1, Region_2, Region_3, Region_4],
%                 [e(Region_1, Region_2),
%                  e(Region_1, Region_3),
%                  e(Region_2, Region_4),
%                  e(Region_3, Region_4)]]
%    (Colour Set)
%        colour_set([amber, magenta, cyan]). 
%    Expected Output: All Colouring Found
%
% 17. (Map) 
%        Graph = [[Region_1, Region_2, Region_3, Region_4],
%                 [e(Region_1, Region_2),
%                  e(Region_1, Region_3),
%                  e(Region_1, Region_4),
%                  e(Region_2, Region_4),
%                  e(Region_3, Region_4)]]
%    (Colour Set)
%        colour_set([indigo, amber, magenta]). 
%    Expected Output: All Colouring Found (6 colourings)
%    
% 18. (Map) 
%        Graph = [[Region_1, Region_2, Region_3, Region_4],
%                 [e(Region_1, Region_2),
%                  e(Region_1, Region_3),
%                  e(Region_1, Region_4),
%                  e(Region_2, Region_4),
%                  e(Region_3, Region_4)]]
%    (Colour Set)
%        colour_set([indigo, amber]). 
%    Expected Output: False
%    
% 19. (Map) 
%        Graph = [[Region_1, Region_2, Region_3, Region_4,
%                  Region_5, Region_6, Region_7, Region_8],
%                 [e(Region_1, Region_2),
%                  e(Region_1, Region_3),
%                  e(Region_1, Region_4),
%                  e(Region_1, Region_5),
%                  e(Region_1, Region_6),
%                  e(Region_1, Region_7),
%                  e(Region_1, Region_8),
%                  e(Region_2, Region_3),
%                  e(Region_2, Region_4),
%                  e(Region_2, Region_5),
%                  e(Region_2, Region_6),
%                  e(Region_2, Region_7),
%                  e(Region_2, Region_8),
%                  e(Region_3, Region_4),
%                  e(Region_3, Region_5),
%                  e(Region_3, Region_6),
%                  e(Region_3, Region_7),
%                  e(Region_3, Region_8),
%                  e(Region_4, Region_5),
%                  e(Region_4, Region_6),
%                  e(Region_4, Region_7),
%                  e(Region_4, Region_8),
%                  e(Region_5, Region_6),
%                  e(Region_5, Region_7),
%                  e(Region_5, Region_8),
%                  e(Region_6, Region_7),
%                  e(Region_6, Region_8),
%                  e(Region_7, Region_8)]]
%    (Colour Set)
%        colour_set([lavender, cerulean, olive, indigo, amber, teal, cyan, magenta]). 
%    Expected Output: All Colouring Found
% 20. (Map) 
%        Graph = [[Region_1, Region_2, Region_3, Region_4,
%                  Region_5, Region_6, Region_7, Region_8],
%                 [e(Region_1, Region_2),
%                  e(Region_1, Region_3),
%                  e(Region_1, Region_4),
%                  e(Region_1, Region_5),
%                  e(Region_1, Region_6),
%                  e(Region_1, Region_7),
%                  e(Region_1, Region_8),
%                  e(Region_2, Region_3),
%                  e(Region_2, Region_4),
%                  e(Region_2, Region_5),
%                  e(Region_2, Region_6),
%                  e(Region_2, Region_7),
%                  e(Region_2, Region_8),
%                  e(Region_3, Region_4),
%                  e(Region_3, Region_5),
%                  e(Region_3, Region_6),
%                  e(Region_3, Region_7),
%                  e(Region_3, Region_8),
%                  e(Region_4, Region_5),
%                  e(Region_4, Region_6),
%                  e(Region_4, Region_7),
%                  e(Region_4, Region_8),
%                  e(Region_5, Region_6),
%                  e(Region_5, Region_7),
%                  e(Region_5, Region_8),
%                  e(Region_6, Region_7),
%                  e(Region_6, Region_8),
%                  e(Region_7, Region_8)]]
%    (Colour Set)
%        colour_set([lavender, cerulean, olive, indigo, amber, teal, cyan]). 
%    Expected Output: False
%
% 21. (Map) 
%        Graph = [[Region_1, Region_2, Region_3, Region_4,
%                  Region_5, Region_6, Region_7, Region_8],
%                 [e(Region_1, Region_2),
%                  e(Region_2, Region_3),
%                  e(Region_3, Region_4),
%                  e(Region_4, Region_5),
%                  e(Region_5, Region_6),
%                  e(Region_6, Region_7),
%                  e(Region_7, Region_8),
%                  e(Region_8, Region_1)]]
%    (Colour Set)
%        colour_set([cerulean, indigo]). 
%    Expected Output: All Colouring Found (2 colouring)
%
