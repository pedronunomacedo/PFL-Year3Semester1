% 1)
% a)
double(X, Y) :-
    Y is X * 2.

map(_, [], []).
map(Term, [Elem1 | Rest1], [Elem2 | Rest2]) :-
    Goal =.. [Term, Elem1, Elem2], % unify the term with the parameters. The leftmost element of the list 'Term' is the predicate that we want to call, the rest of the elements are the arguments of 'Term', placed in order.
    Goal, % Equal calling 'Term(Elem1, Elem2)'.
    map(Term, Rest1, Rest2).

% b)
sum(A, B, S):- S is A+B.

fold(_, Result, [], Result).
fold(Pred, StartValue, [Num | Rest], FinalValue) :-
    G=.. [Pred, StartValue, Num, IntermediateValue], 
    G, 
    fold(Pred, IntermediateValue, Rest, FinalValue).

% c)
even(X):- 0 =:= X mod 2.

separate([], _, [], []).
separate([Num | Rest], Pred, [Num | Yes], No) :-
    G=.. [Pred, Num], 
    G, !, % Check if Num is an even number
    separate(Rest, Pred, Yes, No).

separate([Num | Rest], Pred, Yes, [Num | No]) :-
    % Num is an odd number
    separate(Rest, Pred, Yes, No).

% d)
ask_execute :-
    write('Input the command you would like to execute: '), 
    read(Command), nl, 
    write('Command is being execute...'), nl, 
    call(Command).

% 2)
% a)
my_arg(ArgIndex, TermArgs, Value) :-
    Term =.. [_ | Args], 
    nth1(N, Args, Value).

my_functor(Func, Term, Arity) :-
    Func =.. [Term | Args], 
    length(Args, Arity).

% b)
univ(Term, Args) :-
    my_functor(Term, _, N), 
    univ(Term, Args, N).

univ(_, [], 0).
univ(Term, [Arg | Rest], N) :-
    NewN is N - 1, 
    my_arg(N, Term, Arg), 
    univ(Term, Rest, NewN).

% c)
:- op(400, xfx, univ). % 'xfx' indicates the operator is 'infixo'

Term univ List :-
    my_functor(Term, _, N),
    univ(N, Term, List).

% 3)
:- op(500, xfx, na).
:- op(500, yfx, la).
:- op(500, xfy, ra).

% a) a ra b na c

%       na
%        |
%        c
%       /
%      ra
%     /  \
%    a    b

% b) a la b na c
%      na
%       |
%       c
%       /
%      la
%     /  \
%    a    b

% c) a na b la c
%      na
%     /  \
%    a    la
%        /  \
%       b    c

% d) a na b ra c
%      na
%     /  \
%    a    ra
%        /  \
%       b    c

% e) a na b na c
%      na
%     /  \
%    na   c
%   /  \
%  a    b

% f) a la b la c
%      la
%     /  \
%    la   c
%   /  \
%  a    b

% g) a ra b ra c
%      ra
%     /  \
%    ra   c
%   /  \
%  a    b