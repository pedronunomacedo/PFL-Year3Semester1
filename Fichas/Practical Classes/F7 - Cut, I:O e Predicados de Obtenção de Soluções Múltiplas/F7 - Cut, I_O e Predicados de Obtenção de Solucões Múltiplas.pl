:- use_module(library(lists)).

% 1)
s(1).
s(2):- !.
s(3).

% a) | ?- s(X).
%    X = 1 ? n.
%    X = 2 ? n.
%    no

% b) | ?- s(X), s(Y).
%    X = 1,
%    Y = 1 ? n.
%    X = 1,
%    Y = 2 ? n.
%    X = 2,
%    Y = 1 ? n.
%    X = 2,
%    Y = 2 ? n.
%    no

% c) | ?- s(X), !, s(Y).
%    X = 1,
%    Y = 1 ? n.
%    X = 1,
%    Y = 2 ? n.
%    no

% 2)
data(one).
data(two).
data(three).
cut_test_a(X):- data(X).
cut_test_a('five').
cut_test_b(X):- data(X), !.
cut_test_b('five').
cut_test_c(X, Y):- data(X), !, data(Y).
cut_test_c('five', 'five').

% a) | ?- cut_test_a(X), write(X), nl, fail.
%    one
%    two
%    three
%    five
%    no

% b) | ?- cut_test_b(X), write(X), nl, fail.
%    one
%    no

% c) | ?- cut_test_c(X, Y), write(X-Y), nl, fail.
%    one-one
%    one-two
%    one-three
%    no

% 3)
% EXPLANATION : In Prolog, a "green" cut and a "red" cut are used to improve the efficiency of Prolog programs by preventing the backtracking of certain predicates. The main difference between the two is the scope of the cut.
% A "green" cut, represented by the "!" symbol, is used to indicate that once a certain rule is satisfied, the program should not backtrack to consider any other possibilities for that predicate, but the program can still backtrack to other predicates.
% A "red" cut, represented by the "!", symbol, is used to indicate that once a certain rule is satisfied, the program should not backtrack to consider any other possibilities for that predicate, and it also prevents the program from backtracking to other predicates.
% In other words, a green cut stops the backtracking within the current predicate but allows it to backtrack to other predicates, while a red cut stops the backtracking within the current predicate and also prevents backtracking to other predicates.
% In general, green cuts are used to improve the efficiency of the program by avoiding unnecessary backtracking, while red cuts are used to guarantee that certain predicates are true, and to prevent errors that can be caused by backtracking.

immature(X) :- adult(X), !, fail.
% This cut in the line of code is a green cut, it is checking if the person(X) is true, and if it is, it will check the age(X, N) and N >= 18. Once it finds a match, it will not backtrack to check for other possibilities of the person(X) but it will allow backtracking for other predicates.
adult(X) :- person(X), !, age(X, N), N >=18.
% This cut in the line of code is a red cut, it is checking if the person(X) is true, and if it is, it will check the age(X, N) and N >= 18. Once it finds a match, it will not backtrack to check for other possibilities of the person(X) and it will not allow backtracking for other predicates.
adult(X) :- turtle(X), !, age(X, N), N >=50.
% This cut in the line of code is a red cut, it is checking if the turtle(X) is true, and if it is, it will check the age(X, N) and N >= 50. Once it finds a match, it will not backtrack to check for other possibilities of the turtle(X) and it will not allow backtracking for other predicates.
adult(X) :- spider(X), !, age(X, N), N>=1.
% This cut in the line of code is a red cut, it is checking if the spider(X) is true, and if it is, it will check the age(X, N) and N >= 1. Once it finds a match, it will not backtrack to check for other possibilities of the spider(X) and it will not allow backtracking for other predicates.
adult(X) :- bat(X), !, age(X, N), N >=5.
% This cut in the line of code is a red cut, it is checking if the bat(X) is true, and if it is, it will check the age(X, N) and N >= 5. Once it finds a match, it will not backtrack to check for other possibilities of the bat(X) and it will not allow backtracking for other predicates.

% 4)
% a)
print_n(S, 0).
print_n(S, N) :-
    write(S),
    NextN is N - 1,
    print_n(S, NextN).

% b)
print_text(String, S, N) :-
    write(S), 
    print_n(' ', N), 
    write(String), 
    print_n(' ', N), 
    write(S).

% c)
print_edge(Symbol, Padding, TextLength) :-
    UpperBottomLineLength is 1 + Padding + TextLength + Padding + 1, 
    print_n(Symbol, UpperBottomLineLength).

print_empty_line(Symbol, Padding, TextLength) :-
    EmptyLineLength is Padding + TextLength + Padding, 
    write(Symbol), print_n(' ', EmptyLineLength), write(Symbol).

print_banner(Text, Symbol, Padding) :-
    atom_chars(Text, ListText), 
    length(ListText, TextLength),

    print_edge(Symbol, Padding, TextLength), nl, 
    print_empty_line('*', Padding, TextLength), nl, 
    print_text(Text, Symbol, Padding), nl, 
    print_empty_line('*', Padding, TextLength), nl, 
    print_edge(Symbol, Padding, TextLength).

% d)
read_number(X, X) :- peek_code(10), !.
read_number(Acc, X) :-
    \+ peek_code(10), 
    get_code(Code), 
    char_code('0', Zero), 
    Digit is Code - Zero, 
    Digit >= 0, 
    Digit =< 10, 
    NewAcc is Acc * 10 + Digit, 
    read_number(NewAcc, X).
read_number(X) :-
    read_number(0, X), 
    get_code(10).

% e)
read_until_between(Min, Max, Value) :- 
    repeat,
        read_number(Value),
        Value >= Min,
        Value =< Max,
        !. % leave 'repeat' cycle

% f)
read_string("") :- % puts an empty string ("") when it reads the end of the line (ascci('\n') = 10)
    peek_code(10), !, 
    get_code(_). % discard the '\n'
read_string([Char | Rest]) :-
    get_code(Char), 
    read_string(Rest).

% g) (ERRADO)
print_string("").
print_string([Code | T]) :-
    char_code(Char, Code),
    write(Char),
    print_string(T).

banner :-
    % Ask for Text
    print_string("Text = "),
    read_string(Text), nl,
    % Ask for Symbol
    print_string("Symbol = "),
    get_char(Symbol), get_char(_), nl,
    % Ask for Padding
    print_string("Padding = "),
    read_number(Padding), nl,
    % Print the output of print_banner
    print_string("Here comes your banner!"), nl, nl,
    print_banner(Text, Symbol, Padding).

% 5)

% gender
female(grace).
female(dede).
female(gloria).
female(barb).
female(claire).
female(pameron).
female(haley).
female(alex).
female(lily).
female(poppy).

male(frank).
male(jay).
male(javier).
male(merle).
male(phil).
male(mitchell).
male(joe).
male(manny).
male(cameron).
male(bo).
male(dylan).
male(luke).
male(rexford).
male(calhoun).
male(george).

% family
parent(grace, phil).
parent(frank, phil).

parent(dede, claire).
parent(jay, claire).

parent(dede, mitchell).
parent(jay, mitchell).

parent(jay, joe).
parent(gloria, joe).

parent(javier, manny).
parent(gloria, manny).

parent(barb, cameron).
parent(merle, cameron).

parent(barb, pameron).
parent(merle, pameron).

parent(george, haley).
parent(claire, haley). 

parent(phil, alex).
parent(claire, alex).

parent(phil, luke).
parent(claire, luke).

parent(mitchell, lily).
parent(cameron, lily).

parent(mitchell, rexford).
parent(cameron, rexford).

parent(pameron, calhoun).
parent(bo, calhoun).

parent(dylan, george).
parent(haley, george).

parent(dylan, poppy).
parent(haley, poppy).

% a)
children(Person, Children) :-
    findall(Child, parent(Person, Child), Children).

% b)
children_of([], []).
children_of([Person | Rest1], [Person-Children | Rest2]) :-
    children(Person, Children), 
    children_of(Rest1, Rest2).

% c)
connected(Person1, Person2) :-
    (parent(Person, Person2) ; parent(Person2, Person1)).

family(F) :-
    setof(Person, Relative^connected(Relative, Person), F).

% d)
couple(P1-P2) :-
    parent(P1, Child), 
    parent(P2, Child), 
    P1 \= P2.

% e)
couples(L) :-
    setof(Couple, Person2^couple(Couple), L).

% f)
spouse_children(Person, Spouse/Children) :-
    couple(Person-Spouse), 
    children(Person, Children).

% g)
findCoupleKids(Person, Spouse, Children) :-
    children(Person, Kids1), 
    children(Spouse, Kids2), 
    findall(Kid, (member(Kid, Kids1) , member(Kid, Kids2)) , Children).

findSpouseChildren(_, [], []).
findSpouseChildren(Person, [Spouse | Rest1], [Spouse/Children | Rest2]) :-
    findCoupleKids(Person, Spouse, Children),
    findSpouseChildren(Person, Rest1, Rest2).

immediate_family(Person, Parents-SC) :- 
    findall(Parent, parent(Parent, Person), Parents),
    setof(Spouse, couple(Person-Spouse), Spouses), 
    findSpouseChildren(Person, Spouses, SC).

% h)
two_or_more_kids(Person) :-
    setof(Kid, parent(Person, Kid), Children), 
    length(Children, NumChildren), 
    (NumChildren >= 2).

parents_of_two(Parents) :-
    setof(Person, two_or_more_kids(Person), Parents).