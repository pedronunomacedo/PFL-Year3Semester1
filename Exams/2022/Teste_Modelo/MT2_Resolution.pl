:- use_module(library(lists)).

:- dynamic round/4.
% round(RoundNumber, DanceStyle, Minutes, [Dancer1-Dancer2 | DancerPairs])
% round/4 indica, para cada ronda, o estilo de dança, a sua duração, e os pares de dançarinos participantes.
round(1, waltz, 8, [eugene-fernanda]).
round(2, quickstep, 4, [asdrubal-bruna,cathy-dennis,eugene-fernanda]).
round(3, foxtrot, 6, [bruna-dennis,eugene-fernanda]).
round(4, samba, 4, [cathy-asdrubal,bruna-dennis,eugene-fernanda]).
round(5, rhumba, 5, [bruna-asdrubal,eugene-fernanda]).
% tempo(DanceStyle, Speed).
% tempo/2 indica a velocidade de cada estilo de dança.
tempo(waltz, slow).
tempo(quickstep, fast).
tempo(foxtrot, slow).
tempo(samba, fast).
tempo(rhumba, slow).

% 1)
style_round_number(Style, Round):-
    round(Round, Style, _Min, _Pairs).

% 2)
n_dancers(RoundNumber, NDancers) :-
    round(RoundNumber, _DanceStyle, _Min, Pairs), 
    length(Pairs, NPairs), 
    NDancers is NPairs * 2.
    
% 3)
danced_in_round(RoundNumber, Dancer) :-
    round(RoundNumber, _DanceStyle, _Min, Pairs), 
    ( member(Dancer-_P, Pairs) ; member(_P-Dancer, Pairs) ).

% 4)
n_rounds(NRounds) :-
    round(NRounds, _DanceStyle, _Min, _Pairs), 
    \+ (round(R1, _, _, _) , R1 > NRounds).

% 5)
add_dancer_pair(RoundNumber, Dancer1, Dancer2) :-
    \+ danced_in_round(RoundNumber, Dancer1),
    \+ danced_in_round(RoundNumber, Dancer2), 
    retract(round(RoundNumber, DanceStyle, Min, Pairs)), 
    assert(round(RoundNumber, DanceStyle, Min, [Dancer1-Dancer2 | Pairs])).

% 6)
total_dance_time(Dancer, Time) :-
    dance_time(Dancer, [], 0, Time).

dance_time(Dancer, Rounds, Acc, Time) :-
    danced_in_round(RoundNumber, Dancer), % all rounds dancer participated
    \+ member(RoundNumber, Rounds), !,
    round(RoundNumber, _, Min, _Pairs), 
    NewAcc is Acc + Min, 
    dance_time(Dancer, [RoundNumber | Rounds], NewAcc, Time).
dance_time(_Dancer, _Rounds, Acc, Acc).

% 7)
print_program :-
    round(RoundNumber, DanceStyle, Min, Pairs), 
    length(Pairs, NPairs), 
    write(DanceStyle), write(' ('), write(Min), write(') - '), write(NPairs), nl, 
    fail.
print_program.

% 8)
dancer_n_dances(Dancer, NDances) :-
    % findall(RoundNumber, ((DanceStyle, Min)^round(RoundNumber, DanceStyle, Min, Pairs), (member(Dancer-_Pair, Pairs) ; member(_Pair-Dancer, Pairs))), Rounds), 
    bagof(RoundNumber, danced_in_round(RoundNumber, Dancer), Rounds), 
    length(Rounds, NDances).

% 9)
most_tireless_dancer(Dancer) :-
    setof(D-T, Round^(danced_in_round(Round, D) , total_dance_time(D, T)), List), 
    reverse(List, [Dancer-_Time | _]).


% Information 
predX([],0).
predX([X|Xs],N):-
    X =.. [_|T],
    length(T,2),
    !,
    predX(Xs,N1),
    N is N1 + 1.
predX([_|Xs],N):-
    predX(Xs,N).

% 10) The predicate predX/2 receives two arguments (List of terms and a return variable N).
%     This precicate returns in N the number of terms with ariety 2 (this is, terms with 2 arguments).

% 11) The cut is read because it affects the solutions received by predX/2. (You can check if the result change if the '!' is removed, by copying the code to a file, call it and seeing the results).
%     You can test it using the following instruction: "predX([dancer_n_dances(_, _), dance_time(_, _, _, _), total_dance_time(_, _)], N)." -> Always type 'n.' instead of just hitting 'Enter'.
%     If the cut was removed, predX/2 will return different values for N (inferior to the correct result) by backtracking.

% 12) A unificação produz sempre o mínimo de substituições possíveis para que X e Y sejam idênticos.

% 13) O uso de listas de diferença permite reimplementar certos predicados de complexidade temporal quadrática em
%     tempo linear.
%     EXPLANATION: Considere-se o exemplo visto do predicado
%                  append/3, que passa de complexidade linear no tamanho da primeira lista para
%                  constante. Considere-se agora um outro predicado que chama o predicado
%                  append/3 N vezes, resultando numa
%                  complexidade quadrática; usando listas de diferença, a complexidade passa a ser linear pois cada
%                  append é agora realizado
%                  em tempo constante.

% 14) :- op(580, xfy, and).
%     EXPLANATION: The possible values for associativity are:

%       - "fx": prefix operator, left associative
%       - "fy": postfix operator, right associative
%       - "xf": infix operator, left associative
%       - "yf": infix operator, right associative
%       - "xfx": infix operator, non-associative
%       - "xfy": infix operator, right associative
%       - "yfx": infix operator, left associative

%     In the case of "op(580, xfy, and)", the operator "and" is a infix operator with right associativity, meaning that it will be applied 
%     to the rightmost operand first when it appears multiple times in a row.

% 15) :- op(600, xfx, dances).
%     EXPLANATION: É a única opção que permite termos com 'dances' na raiz da árvore, e dois operandos (pessoa e danças).

% Information
edge(a,b).
edge(a,c).
edge(a,d).
edge(b,e).
edge(b,f).
edge(c,b).
edge(c,d).
edge(c,e).
edge(d,a).
edge(d,e).
edge(d,f).
edge(e,f).

% 16)
% shortest_safe_path(Origin, Destination, ProhibitedNodes, Path) :-
%     find_path(Origin, Destination, ProhibitedNodes, [], [Origin], Path).

% find_path(Origin, Destination, ProhibitedNodes, Visited, CurrentPath, Path) :-
%     \+ (Origin == Destination), 
%     edge(Origin, Edge2), !, 
%     (\+ member(Edge2, ProhibitedNodes), \+ member(Edge2, Visited)),
%     reverse(CurrentPath, CurrentPathReversed), 
%     NextCurrentPathReversed = [Edge2 | CurrentPathReversed], 
%     reverse(NextCurrentPathReversed, NextCurrentPath), 
%     NextVisited = [Edge2 | Visited], 
%     find_path(Edge2, Destination, ProhibitedNodes, NextVisited, NextCurrentPath, Path).
% find_path(_, _, _, _, CurrentPath, CurrentPath).

shortest_safe_path(Ni, Nf, PNs, Path):-
    \+member(Ni, PNs),
    \+member(Nf, PNs),
    bfs([[Ni]], Nf, PNs, PathInv),
    reverse(PathInv, Path).

bfs( [ [Nf|T]|_], Nf, _, [Nf|T]).
bfs( [ [Na|T]|Ns], Nf, PNs, Sol):-
    findall(
        [Nb,Na|T],
        (edge(Na,Nb), \+mem ber(Nb, [Na|T]), \+member(Nb, PNs)),
        Ns1
    ),
    append(Ns, Ns1, Ns2),
    bfs(Ns2, Nf, PNs, Sol).

% 17)
all_shortest_safe_paths(Origin, Destination, ProhibitedNodes, ListOfPaths) :-
    shortest_safe_path(Origin, Destination, ProhibitedNodes, AShortestPath), 
    !, % if exists a path between Origin and Destination, prohibite backtracking to find another solutions
    length(AShortestPath, ShortestPathLen), 
    length(Path, ShortestPathLen), % Make a path have as length 'ShortestPathLen'
    findall(Path, shortest_safe_path(Origin, Destination, ProhibitedNodes, Path), ListOfPaths).