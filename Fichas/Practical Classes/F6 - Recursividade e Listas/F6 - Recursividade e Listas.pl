% 1) Recursividade
:- use_module(library(lists)).

% a)
factorial(0,1).
factorial(N, F) :-
  N > 0,
  N1 is N - 1,
  factorial(N1, F1),
  F is F1 * N.

% b)
somaRec(0, 0).
somaRec(N, Sum) :-
  N > 0,
  N1 is N - 1,
  somaRec(N1, F1),
  Sum is F1 + N.

% c)
fibonacci(0,0).
fibonacci(1,1).
fibonacci(N,F) :-
  N > 1,
  N1 is N - 1,
  N2 is N - 2,
  fibonacci(N1, Sum1),
  fibonacci(N2, Sum2),
  F is Sum1 + Sum2.

% d)
anyDivisible(X, Div) :- 
  Div < X,
  0 is X rem Div.
anyDivisible(X, Div) :- 
  Div < X,
  NewDiv is Div + 1,
  anyDivisible(X, NewDiv).

isPrime(X) :- 
  X >= 2,
  Div is 2,
  \+ anyDivisible(X, Div).

% 2) Relações Familiares

% a)
ancestor(X, Y) :-
  parent(X, Y).
ancestor(X, Y) :-
  parent(X, Z), 
  ancestor(Z, Y).

% b)
descendant(X, Y) :-
  ancestor(Y, X).

% 3) Cargos e Chefes
cargo(tecnico, eleuterio).
cargo(tecnico, juvenaldo).
cargo(analista, leonilde).
cargo(analista, marciliano).
cargo(engenheiro, osvaldo).
cargo(engenheiro, porfirio).
cargo(engenheiro, reginaldo).
cargo(supervisor, sisnando).
cargo(supervisor_chefe, gertrudes).
cargo(secretaria_exec, felismina).
cargo(diretor, asdrubal).
chefiado_por(tecnico, engenheiro).
chefiado_por(engenheiro, supervisor).
chefiado_por(analista, supervisor).
chefiado_por(supervisor, supervisor_chefe).
chefiado_por(supervisor_chefe, diretor).
chefiado_por(secretaria_exec, diretor).

% superior(+X, +Y)
superior(X, Y) :-
  cargo(CargX, X), 
  cargo(CargY, Y), 
  chefiado_por(CargY, CargX).

% 4)
% a) yes
% b) syntax error
% c) yes
% d) H = pfl,
%    T = [lbaw, redes, ltw]
% e) H = lbaw, 
%    T = [ltw]
% f) H = leic, 
%    T = []
% g) no
% h) H = leic, 
%    T = [[pfl, ltw, lbaw, redes]]
% i) H = leic, 
%    T = [Two]
% j) Inst = gram, 
%    LEIC = feup
% k) One = 1, 
%    Two = 2, 
%    Tail = [3,4]
% l) One = leic, 
%    Rest = [Two|Tail]

% 5)
% a)
list_size([], 0).
list_size([Elem | Rest], Size) :-
  list_size(Rest, Size2), 
  Size is Size2 + 1.

% b)
list_sum([], 0).
list_sum([Elem | Rest], Sum) :-
  list_sum(Rest, Sum2),
  Sum is Sum2 + Elem.

% c)
list_prod([], 1).
list_prod([Elem | Rest], Sum) :-
  list_prod(Rest, Sum2),
  Sum is Sum2 * Elem.

% d)
inner_product([], [], 0).
inner_product([Elem1 | Rest1], [Elem2 | Rest2], Result) :-
  length(Rest1, Len1), 
  length(Rest2, Len2), 
  (Len1 == Len2), 
  inner_product(Rest1, Rest2, Result2), 
  Result is Result2 + (Elem1 * Elem2). 
inner_product(_, _, _) :-
  write('ERROR: Both lists need to have the same size'), nl, fail.

% e)
count(_, [], 0).
count(Elem, [Elem | Rest], N) :-
  count(Elem, Rest, N2),
  N is N2 + 1.
count(Elem, [Elem2 | Rest], N) :-
  (Elem =\= Elem2), 
  count(Elem, Rest, N).


% 6)
% a)
invert(Xs, Rev) :- invert(Xs, [], Rev).
invert([X|Xs], Acc, Rev) :- invert(Xs, [X|Acc], Rev).
invert([], Rev, Rev).

% b)
del_one(Elem, [Elem | Rest1], Rest1).
del_one(Elem, [Elem1 | Rest1], [Elem1 | Rest2]) :-
  del_one(Elem, Rest1, Rest2).

% c)
del_all(_, [], []).
del_all(Elem, [Elem | Rest1], Rest2) :-
  del_all(Elem, Rest1, Rest2).
del_all(Elem, [Elem1 | Rest1], [Elem1 | Rest2]) :-
  del_all(Elem, Rest1, Rest2).

% d)
del_all_list(_, [], []).
del_all_list(LE, [H | T], L2) :- member(H, LE),
                                 del_all_list(LE, T, L2).
del_all_list(LE, [H | T], L2) :- \+ member(H, LE),
                                 del_all_list(LE, T, L),
                                 L2 = [H | L].


% e)
del_dups(L1,L2):- del_dups(L1, [], L2).
del_dups([L|L1], Aux, L2):- 
  member(L, Aux), 
  del_dups(L1, Aux, L2).

del_dups([L|L1], Aux, L2):- 
  \+ member(L, Aux),
  del_dups(L1, [L|Aux], LL), 
  L2 = [L|LL].

del_dups([],_,[]).


% f)
list_perm([], []).
list_perm([H1 | T1], L2) :- 
  del_one(H1, L2, DelL2),
  list_perm(T1, DelL2).

% g)
replicate(0, Elem, []).
replicate(Amount, Elem, [Elem | Rest]) :- 
  NextAmount is Amount - 1,
  replicate(NextAmount, Elem, Rest).


% 7)
% a) 
list_append([], [], []).
list_append([], [Elem2 | Rest2], [Elem2 | Rest3]) :-
  list_append([], Rest2, Rest3).

list_append([Elem1 | Rest1], L2, [Elem1 | Rest3]) :-
  list_append(Rest1, L2, Rest3).

% b)
list_member(Elem, List) :-
  list_append(_, [Elem | _], List).

% c)
list_last(List, Last) :-
  list_append(_, [Last | []], List).

% d)
list_nth(N, List, Elem) :- 
  list_append(Part1, [Elem | _Part2], List),
  length(Part1, N).

% e)
list_append([L1], List) :- L1 = List.
list_append([L1 | LN], List) :- 
  list_append(L1, LRem, List),
  list_append(LN, LRem).

% f) 
list_del(List, Elem, Res) :-
  list_append(P1, [Elem | P2], List),
  list_append(P1, P2, Res). 

% g)
list_before(First, Second, List) :-
  list_append(P1, [First | P2], List), 
  list_append(P1, [Second | _P3], P2).

% h)
list_replace_one(X, Y, List1, List2) :-
  list_append(P1, [X | P2], List1), 
  list_append(P1, [Y | P2], List2).

% i) WRONG!
list_repeated(X, List) :- 
  list_before(X, X, List).

% j)
list_slice(List1, Index, Size, List2) :-
  append(P1, P2, List1), 
  length(P1, Index),
  append(List2, _Front, P2),
  length(List2, Size).

% k)
list_shift_rotate(L1, N, L2) :- 
  list_append(ToRotate, ToKeep, L1),
  list_append(ToKeep, ToRotate, L2),
  length(ToRotate, N).
  
% 8)
% a)
list_to(0, []).
list_to(N, List) :-
  N > 0,
  NextN is N - 1, 
  list_to(NextN, NewList),
  append(NewList, [N], List).

% b)
list_from_to(Sup, Sup, [Sup]).
list_from_to(Inf, Sup, List) :-
  Inf < Sup, 
  NewInf is Inf + 1, 
  list_from_to(NewInf, Sup, NewList), 
  append([Inf], NewList, List).


% c)
list_from_to_step(Inf, _, Sup, []) :- (Inf > Sup).
list_from_to_step(Lim, _, Lim, [Lim]).
list_from_to_step(Inf, Step, Sup, List) :-
  Inf < Sup, 
  NewInf is Inf + Step, 
  list_from_to_step(NewInf, Step, Sup, NewList), 
  append([Inf], NewList, List).

% d)
:- use_module(library(lists)).

list_from_to_c(Inf, Sup, RevList) :-
  Inf > Sup, 
  list_from_to(Sup, Inf, NewList), 
  reverse(NewList, RevList).
list_from_to_c(Inf, Sup, List) :-
  Inf =< Sup, 
  list_from_to(Inf, Sup, List).

list_from_to_step_c(Inf, Step, Sup, RevList) :-
  Inf > Sup, 
  list_from_to_step(Sup, Step, Inf, NewList), 
  reverse(NewList, RevList).
list_from_to_step_c(Inf, Step, Sup, List) :-
  Inf =< Sup, 
  list_from_to_step(Inf,Step, Sup, List).

% e)
primes(1, []).
primes(N, List) :-
  N >= 2,
  \+ isPrime(N),
  NewN is N - 1,
  primes(NewN, List).
primes(N, List) :- 
  N >= 2,
  isPrime(N),
  NewN is N - 1,
  primes(NewN, Front),
  append(Front, [N], List).

% f)
fibs(0, [0]).
fibs(1, [0,1]).
fibs(N, List) :-
  (N > 0),
  NextN is N - 1, 
  fibs(NextN, NewList), 
  fibonacci(N, FibN),
  append(NewList, [FibN], List).

% 9)
% a)
removeLetter([], [], _, CurrentOccur, CurrentOccur).
removeLetter([Letter | Rest1], NewRest, Letter, CurrentOccur, Occur) :-
  NextCurrentOccur is CurrentOccur + 1,
  removeLetter(Rest1, NewRest, Letter, NextCurrentOccur, Occur).
removeLetter([Let | Rest1], [Let | NewRest], Letter, CurrentOccur, Occur) :-
  removeLetter(Rest1, NewRest, Letter, CurrentOccur, Occur).

rle([], []).
rle([Letter | Rest1], [Letter-Reps | Rest2]) :-
  removeLetter([Letter | Rest1], RemList, Letter, 0, Reps), % remove letter from the original list, count the number of occurences and return that same number on 'Reps'
  rle(RemList, Rest2).

% b)
un_rle([], []).
un_rle([_Letter-0 | Rest1], List2) :-
  un_rle(Rest1, List2).
un_rle([Letter-Reps | Rest1], [Letter | Rest2]) :-
  DecReps is Reps - 1,
  un_rle([Letter-DecReps | Rest1], Rest2).

% 10)
% a)
is_ordered([]).
is_ordered([Num | Rest]) :-
  is_ordered([Num | Rest], Num).

is_ordered([], _).
is_ordered([Num1 | Rest], BigNum) :-
  (Num >= BigNum),
  NewBigNum is Num, 
  is_ordered(Rest, NewBigNum).

% b)
insert_ordered(Value, [], [Value]).
insert_ordered(Value, [Num | Rest1], [Value, Num | Rest1]) :-
  (Value =< Num).

insert_ordered(Value, [Num | Rest1], [Num | Rest2]) :-
  (Value >= Num), 
  insert_ordered(Value, Rest1, Rest2).

% c)
insert_sort([], []).
insert_sort([Num | Rest], OrderedList) :-
  insert_sort(Rest, OrderedTail), 
  insert_ordered(Num, OrderedTail, OrderedList).

% 11)
nCr(_N, 0, 1).
nCr(_N, _N, 1).
nCr(N, R, Result) :- 
  N > R,
  R > 0,
  NewN is N-1,
  NewR is R-1,
  nCr(NewN, R, Res1),
  nCr(NewN, NewR, Res2),
  Result is Res1 + Res2.

pascalLine(N, Pos, []) :- Pos is N + 1.
pascalLine(N, Pos, [H | T]) :- 
  Pos =< N,
  nCr(N, Pos, H),
  NewPos is Pos + 1,
  pascalLine(N, NewPos, T).

pascal(N, NLine, []) :- NLine is N + 1.
pascal(N, NLine, [Line | T]) :- 
  NLine =< N,
  pascalLine(NLine, 0, Line),
  NewNLine is NLine + 1,
  pascal(N, NewNLine, T).
pascal(N, Lines) :- pascal(N, 0, Lines).

