words_list([[p,r,o,l,o,g],
            [p,e,r,l],
            [o,n,l,i,n,e],
            [w,e,b],
            [g,n,u],
            [n,f,s],
            [s,q,l],
            [m,a,c],
            [e,m,a,c,s],
            [x,m,l],
            [l,i,n,u,x],
            [j,a,v,a],
            [g,o,o,g,l,e],
            [p,y,t,h,o,n],
            [p,a,r,s,e,r],
            [c,o,o,p],
            [l,o,o,p],
            [f,o,r,k],
            [k,e,r,n,e,l],
            [a,p,i],
            [m,o,u,s,e],
            [f,i,f,o],
            [p,i,p,e]]).

crossword(Puzzle) :-
    Puzzle = [[[G_1_1,G_1_2,G_1_3,G_1_4,G_1_5,G_1_6,  #  ,  #  ,G_1_9],
               [G_2_1,  #  ,G_2_3,  #  ,  #  ,G_2_6,  #  ,  #  ,G_2_9],
               [G_3_1,  #  ,G_3_3,G_3_4,G_3_5,G_3_6,G_3_7,  #  ,G_3_9],
               [G_4_1,  #  ,G_4_3,  #  ,G_4_5,  #  ,G_4_7,G_4_8,G_4_9],
               [  #  ,  #  ,G_5_3,  #  ,G_5_5,G_5_6,G_5_7,  #  ,G_5_9],
               [  #  ,G_6_2,G_6_3,G_6_4,  #  ,  #  ,  #  ,  #  ,  #  ]],
              [w_info([G_1_1,G_1_2,G_1_3,G_1_4,G_1_5,G_1_6], g(1,1), g(1,6)),
               w_info([G_3_3,G_3_4,G_3_5,G_3_6,G_3_7], g(3,3), g(3,7)),
               w_info([G_4_7,G_4_8,G_4_9], g(4,7), g(4,9)),
               w_info([G_5_5,G_5_6,G_5_7], g(5,5), g(5,7)),
               w_info([G_6_2,G_6_3,G_6_4], g(6,2), g(6,4)),
               w_info([G_1_1, G_2_1, G_3_1, G_4_1], g(1,1), g(4,1)),
               w_info([G_1_3, G_2_3, G_3_3, G_4_3, G_5_3, G_6_3], g(1,3), g(6,3)),
               w_info([G_3_5, G_4_5, G_5_5], g(3,5), g(5,5)),
               w_info([G_1_6, G_2_6, G_3_6], g(1,6), g(3,6)),
               w_info([G_3_7, G_4_7, G_5_7], g(3,7), g(5,7)),
               w_info([G_1_9, G_2_9, G_3_9, G_4_9, G_5_9], g(1,9), g(5,9))]],
    fill(Puzzle).


fill_words([]).
fill_words([w_info(Empty_word,_,_)| Rest]) :-
    words_list(List),
    member(Empty_word, List),
    fill_words(Rest).

fill([_|[List_w_info|_]]) :- fill_words(List_w_info).
