:- use_module(library(lists)).

:- dynamic male/1.
:- dynamic female/1.
:- dynamic parent/2.

% 1)
female('Grace').
male('Frank').
female('DeDe').
male('Jay').
female('Gloria').
male('Javier').
male('Barb').
female('Merle').
male('Phil').
female('Claire').
male('Mitchell').
female('Cameron').
female('Pameron').
male('Bo').
male('Joe').
male('Manny').
male('Dylan').
female('Haley').
female('Alex').
male('Luke').
female('Lily').
male('Rexford').
male('Calhoun').
male('George').
female('Poppy').


/* 1ª linhagem */
parent('Grace','Phil').
parent('Frank','Phil').
parent('DeDe', 'Claire').
parent('Jay', 'Claire').
parent('DeDe', 'Mitchell').
parent('Jay', 'Mitchell').
parent('Jay', 'Joe').
parent('Gloria', 'Joe').
parent('Gloria', 'Manny').
parent('Javier', 'Manny').
parent('Barb', 'Cameron').
parent('Merle', 'Cameron').
parent('Barb', 'Pameron').
parent('Merle', 'Pameron').

/* 2ª linhagem */
parent('Phil', 'Haley').
parent('Claire', 'Haley').
parent('Phil', 'Alex').
parent('Claire', 'Alex').
parent('Phil', 'Luke').
parent('Claire', 'Luke').
parent('Mitchell', 'Lily').
parent('Cameron', 'Lily').
parent('Mitchell', 'Rexford').
parent('Cameron', 'Rexford').
parent('Pameron', 'Calhoun').
parent('Bo', 'Calhoun').

/* 3ª linhagem */
parent('Dylan', 'George').
parent('Haley', 'George').
parent('Dylan', 'Poppy').
parent('Haley', 'Poppy').

% a)
add_person :-
    write('Name: '), 
    read(Name), 
    write('Male (m) or Female(f): '), 
    read(Gender), 
    (Gender == 'm'), 
    assert(male(Name)).

add_person :-
    assert(female(Name)).

% b)
ask_for_parent(Person) :-
    write('What\'s the name of your progenitor: '), 
    read(Name), 
    write('Male (m) or Female(f): '), 
    read(Gender), 
    (Gender == 'm'), 
    assert(male(Name)), 
    assert(parent(Name, Person)).

ask_for_parent(Person) :-
    assert(female(Name)), 
    assert(parent(Name, Person)).

add_parents(Person) :-
    ask_for_parent(Person), 
    ask_for_parent(Person).

% c)
remove_person :-
    write('What\'s the name of the person you want to remove: '), 
    read(Person),
    retractall(parent(_, Person)), 
    retractall(parent(Person, _)).

% 2)
%flight(origin, destination, company, code, hour, duration)
flight(porto, lisbon, tap, tp1949, 1615, 60).
flight(lisbon, madrid, tap, tp1018, 1805, 75).
flight(lisbon, paris, tap, tp440, 1810, 150).
flight(lisbon, london, tap, tp1366, 1955, 165).
flight(london, lisbon, tap, tp1361, 1630, 160).
flight(porto, madrid, iberia, ib3095, 1640, 80).
flight(madrid, porto, iberia, ib3094, 1545, 80).
flight(madrid, lisbon, iberia, ib3106, 1945, 80).
flight(madrid, paris, iberia, ib3444, 1640, 125).
flight(madrid, london, iberia, ib3166, 1550, 145).
flight(london, madrid, iberia, ib3163, 1030, 140).
flight(porto, lisbon, lufthansa, lh1177, 1230, 165).

% a)
get_all_nodes(ListOfAirports) :- 
    setof(Airport, (Or,Dest,Comp,Code,Hour,Dur)^(flight(Or, Dest, Comp, Code, Hour, Dur), (Or=Airport; Dest=Airport)), ListOfAirports).

% b)
score(Company, Score) :- 
    setof(Destination, (Or, Code, Hour, Dur)^flight(Or, Destination, Company, Code, Hour, Dur), Destinations),
    length(Destinations, Score).

most_diversified([Company], Company).
most_diversified([Company | T], Company) :- 
    most_diversified(T, NextBest),
    score(Company, BestScore),
    score(NextBest, NextBestScore),
    BestScore >= NextBestScore.
most_diversified([Competitor | T], Company) :- 
    score(Competitor, CompScore),
    score(Company, BestScore),
    BestScore >= CompScore,
    most_diversified(T, Company).

most_diversified(Company) :- 
    setof(Company, (Or,Dest,Code,Hour,Dur)^flight(Or, Dest, Company, Code, Hour, Dur), Companies),
    most_diversified(Companies, Company).

% c)
% find_flights(Origin, Destination, Flights) :-
%     findall(Code, ((Comp, Hour, Dur)^flight(Or, Dest, Comp, Code, Hour, Dur), (Or = Origin , Dest = Destination)), Flights).

already_visited(Location, [Code | T]) :- 
    flight(_, Location, _, Code, _, _);
    flight(Location, _, _, Code, _, _);
    already_visited(Location, T).

find_flights(Origin, Origin, Acc, Acc).
find_flights(Origin, Destination, Acc, Flights) :- 
    flight(Origin, Intermediate, _, FirstFlight, _, _),
    \+ already_visited(Intermediate, Acc),
    find_flights(Intermediate, Destination, [FirstFlight | Acc], Flights).


find_flights(Origin, Destination, Flights) :- 
    find_flights(Origin, Destination, [], Path),
    reverse(Path, Flights).