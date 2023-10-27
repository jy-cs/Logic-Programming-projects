% Structure Definition of a Binary Tree(BT)
% BT is either
%   * empty or
%   * bt(Any, BT, BT)
%
% The first argument of bt(_, _, _) is used to store the node of 
%   the binary tree. The data type can be Any type.
% The second argument of bt(_, _, _) represents the left subtree of the
%   current node
% The third argument of bt(_, _, _) represents the right subtree of the
%   current node
%

is_symmetric(empty).
is_symmetric(bt(_, Left, Right)) :-
    are_mirror_image(Left, Right).

are_mirror_image(empty, empty).
are_mirror_image(bt(_, BT1_Left, BT1_Right), bt(_, BT2_Left, BT2_Right)) :-
    are_mirror_image(BT1_Left, BT2_Right),
    are_mirror_image(BT1_Right, BT2_Left).


% Sample Binary Tree Example on the Assignment Instruction
% BT_sample :
%   bt(a0, bt(a1, bt(a2, bt(a3, empty, empty),
%                        bt(a4, bt(a5, empty, empty),
%                               bt(a6, bt(a7, empty, empty), 
%                                      bt(a8, empty, empty)))),
%                 bt(a9, empty, empty)),
%          bt(a10, bt(a11, empty, empty),
%                  bt(a12, bt(a13, bt(a14, bt(a15, empty, empty),
%                                          bt(a16, empty, empty)),
%                                  bt(a17, empty, empty)),
%                          bt(a18, empty, empty))))
%
% My Test Cases
% Query Format: is_symmetric(Input_BT).
% 1. Input_BT: empty
%    Expected Output: true
%    
% 2. Input_BT: bt(a1, empty, empty)
%    Expected Output: true
%    
% 3. Input_BT: bt(a1, bt(a2, empty, empty), empty)
%    Expected Output: false
%    
% 4. Input_BT: bt(a1, empty, bt(a2, empty, empty))
%    Expected Output: false
%    
% 5. Input_BT: bt(a1, bt(a2, empty, empty), 
%                     bt(a3, empty, empty))
%    Expected Output: true
%    
% 6. Input_BT: bt(a1, bt(a2, bt(a4, empty, empty),
%                            empty), 
%                     bt(a3, empty, empty))
%    Expected Output: false
%    
% 7. Input_BT: bt(a1, bt(a2, empty,
%                            bt(a4, empty, empty)), 
%                     bt(a3, empty, empty))
%    Expected Output: false
%    
% 8. Input_BT: bt(a1, bt(a2, empty, empty), 
%                     bt(a3, bt(a4, empty, empty),
%                            empty))
%    Expected Output: false
%    
% 9. Input_BT: bt(a1, bt(a2, empty, empty), 
%                     bt(a3, empty,
%                            bt(a4, empty, empty)))
%    Expected Output: false
%    
% 10. Input_BT: bt(a1, bt(a2, bt(a4, empty, empty),
%                             bt(a5, empty, empty)), 
%                      bt(a3, empty, empty))
%     Expected Output: false
%     
% 11. Input_BT: bt(a1, bt(a2, bt(a4, empty, empty),
%                             empty), 
%                      bt(a3, bt(a5, empty, empty),
%                             empty))
%     Expected Output: false
%     
% 12. Input_BT: bt(a1, bt(a2, bt(a4, empty, empty),
%                             empty), 
%                      bt(a3, empty,
%                             bt(a5, empty, empty)))
%     Expected Output: true
%     
% 13. Input_BT: bt(a1, bt(a2, empty,
%                             bt(a4, empty, empty)), 
%                      bt(a3, bt(a5, empty, empty),
%                             empty))
%     Expected Output: true
%     
% 14. Input_BT: bt(a1, bt(a2, empty,
%                             bt(a4, empty, empty)), 
%                      bt(a3, empty,
%                             bt(a5, empty, empty)))
%     Expected Output: false
%
% 15. Input_BT: bt(a1, bt(a2, empty,
%                             empty), 
%                      bt(a3, bt(a4, empty, empty),
%                             bt(a5, empty, empty)))
%     Expected Output: false
%
% 16. Input_BT: bt(a0, bt(a1, bt(a2, bt(a3, empty, empty),
%                                    bt(a4, bt(a5, empty, empty),
%                                           bt(a6, bt(a7, empty, empty), 
%                                                  bt(a8, empty, empty)))),
%                             bt(a9, empty, empty)),
%                      bt(a10, bt(a11, empty, empty),
%                              bt(a12, bt(a13, bt(a14, bt(a15, empty, empty),
%                                                      bt(a16, empty, empty)),
%                                              bt(a17, empty, empty)),
%                                      bt(a18, empty, empty))))
%     Expected Output: true
%
% 17. Input_BT: bt(a0, bt(a1, bt(a2, bt(a3, empty, empty),
%                                    bt(a4, bt(a5, empty, empty),
%                                           bt(a6, bt(a7, bt(a17, empty, empty),
%                                                         empty), 
%                                                  bt(a8, empty, empty)))),
%                             bt(a9, empty, empty)),
%                      bt(a10, bt(a11, empty, empty),
%                              bt(a12, bt(a13, bt(a14, bt(a15, empty, empty),
%                                                      bt(a16, empty, empty)),
%                                              bt(a17, empty, empty)),
%                                      bt(a18, empty, empty))))
%     Expected Output: false
%
% 18. Input_BT: bt(a0, bt(a1, bt(a2, bt(a3, empty, empty),
%                                    bt(a4, bt(a5, empty, empty),
%                                           bt(a6, bt(a7, bt(a17, empty, empty),
%                                                         empty), 
%                                                  bt(a8, empty, empty)))),
%                             bt(a9, empty, empty)),
%                      bt(a10, bt(a11, empty, empty),
%                              bt(a12, bt(a13, bt(a14, bt(a15, empty, empty),
%                                                      bt(a16, empty, 
%                                                              bt(a18, empty, empty))),
%                                              bt(a17, empty, empty)),
%                                      bt(a18, empty, empty))))
%     Expected Output: true
%
% 19. Input_BT: bt(a0, bt(a1, bt(a2, bt(a3, empty, empty),
%                                    bt(a4, bt(a5, empty, empty),
%                                           bt(a6, bt(a7, bt(a17, empty, empty),
%                                                         empty), 
%                                                  bt(a8, empty, empty)))),
%                             bt(a9, empty, empty)),
%                      bt(a10, bt(a11, empty, empty),
%                              bt(a12, bt(a13, bt(a14, bt(a15, empty, empty),
%                                                      bt(a16, empty, 
%                                                              bt(a18, empty, empty))),
%                                              bt(a17, empty, empty)),
%                                      bt(a18, empty,
%                                              bt(a19, empty, empty)))))
%     Expected Output: false
%





