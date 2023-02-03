% 1)
% bt(data, leftTree, rightTree)
bt(0, 1, 2).
bt(1, [], []).
bt(2, 3, 4).
bt(3, 5, []).
bt(4, [], []).
bt(5, [], []).

countNNodes(Tree, Count) :-
    \+ var(Tree), 
    bt(Tree, LeftTree, RightTree), !, 
    countNNodes(LeftTree, CountLeft), 
    countNNodes(RightTree, CountRight), 
    Count is CountLeft + CountRight + 1.
countNNodes(_, 0).

% 2)
nth(N, TheList, TheItem) :-
    length(TheList, Len), 
    (N =< Len), 
    checkElemOnList(0, N, TheList, TheItem).

checkElemOnList(N, N, [TheItem | Rest], TheItem) :-
    write('herererrere'), nl, 
    write('N = '), write(N), nl, 
    write('Elem = '), write(Elem), write(' | '), write('TheItem = '), write(TheItem), nl, 
    (Elem == TheItem->
        write('EQUAL'), nl
        ;
        write('NOT EQUAL'), nl, 
        fail    
    ).
checkElemOnList(Counter, N, [Elem | Rest], TheItem) :-
    NextCounter is Counter + 1,
    format('-------COUNTER = ~w -------------\n', [NextCounter]), 
    checkElemOnList(NextCounter, N, Rest, TheItem).