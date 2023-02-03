:- use_module(library(lists)).
:- use_module(library(pairs)).

% Information
:- dynamic(participant/3).

% participant(RaceID, PilotName, Laps)
participant(1, asdrubal, [4,5,3,2,1]).
participant(1, bruno,    [1,2,3]).
participant(1, cathy,    [4,5,3,2,6]).
participant(1, dennis,   [5,5,1,1,1]).

participant(2, bruno,    [4,3,2,1]).

% race(RaceID, City, NumberOfLaps)
race(1, porto,  5).
race(2, napoli, 4).
race(3, lyon,   5).

% 1)
raced_in_city(PilotName, City) :-
    participant(RaceID, PilotName, _Laps),
    race(RaceID, City, _NumberOfLaps).

% 2)
beat_this_time(RaceID, PilotName, MaxTime) :-
    participant(RaceID, PilotName, Laps), 
    beat_this_time(Laps, MaxTime).

beat_this_time([Lap | Rest], MaxTime) :-
    (Lap >= MaxTime), 
    beat_this_time(Rest, MaxTime).
beat_this_time([Lap | Rest], MaxTime) :-
    (Lap < MaxTime).

% 3)
sum_list([], 0).
sum_list([Lap | Rest], Sum) :-
    sum_list(Rest, NewSum),
    Sum is NewSum + Lap.

total_time(RaceID, PilotName, TotalTime) :-
    participant(RaceID, PilotName, Laps), 
    sum_list(Laps, TotalTime).

% 4)
register_lap(RaceID, PilotName, LapTime) :-
    race(RaceID, _City, NumLaps),
    participant(RaceID, PilotName, Laps), 
    length(Laps, NumCompletedLaps), 
    NumCompletedLaps < NumLaps, 
    append(Laps, [LapTime], NewLaps), 
    retract(participant(RaceID, PilotName, Laps)), 
    asserta(participant(RaceID, PilotName, NewLaps)).

% 5)
count_racers(RaceID, NRacers) :-
    findall(Laps, Laps^participant(RaceID, PilotName, Laps), Racers), 
    length(Racers, NRacers).
    
% 6)
get_element_of_pair(0, Target-Second, Target).
get_element_of_pair(1, First-Target, Target).

most_laps_aux([], _MaxNumLaps, Winner, Winner, WinnerLaps, WinnerLaps).
most_laps_aux([City-NLaps | Rest], MaxNumLaps, CurrWinner, Winner, CurrNumLaps, WinnerLaps) :-
    (NLaps > MaxNumLaps), 
    most_laps_aux(Rest, NLaps, City, Winner, NLaps, WinnerLaps).

most_laps_aux([City-NLaps | Rest], MaxNumLaps, CurrWinner, Winner, CurrNumLaps, WinnerLaps) :-
    (NLaps =< MaxNumLaps), 
    most_laps_aux(Rest, MaxNumLaps, CurrWinner, Winner, CurrNumLaps, WinnerLaps).

most_laps(City, NLaps) :-
    findall(Cit-NumberOfLaps, race(_RaceID, Cit, NumberOfLaps), Cities), 
    head(Cities, CurrentPair), 
    get_element_of_pair(0, CurrentPair, CurrWinner), 
    most_laps_aux(Cities, -1, CurrWinner, Winner, -1, NLaps), 
    (City = Winner).


% 7)
print_race(RaceID) :-
    participant(RaceID, PilotName, Laps), 
    length(Laps, NLaps), 
    total_time(RaceID, PilotName, TotalTime), 
    format('~p - ~p (~p)\n', [PilotName, TotalTime, NLaps]), 
    fail.

% 8)
cities_raced(PilotName, Cities) :-
    (raced_in_city(PilotName, _) ->  
        findall(City, (participant(RaceID, PilotName, _),race(RaceID, City, _)), Cities)
        ;   
        false
    ).

% 9)
pilot_completed_race(RaceID, Pilot, Sum) :-
    race(RaceID, City, NumberOfLaps), 
    participant(RaceID, Pilot, Laps), 
    length(Laps, NLaps), 
    (NLaps = NumberOfLaps), % pilot completed the race ?
    sum_list(Laps, Sum).

final_rank(RaceID, Pilots) :-
    setof(Pilot-Sum, pilot_completed_race(RaceID, Pilot, Sum), Pilots).

% 10) O predicado predX/3 transforma cada elemento da lista [H|T] em uma nova estrutura usando 
%     o argumento A como o primeiro argumento da nova estrutura, preservando os demais argumentos 
%     da estrutura original.

% 11)
predX([], _, []).
predX([H|T], A, [H1|T1]):-
    H =.. [_|B],
    H1 =.. [A|B],
    predX(T, A, T1).

% Information

% task(Project, Activity, Time)
task(1, a, 1).
task(1, b, 2).

task(2, a, 2).
task(2, b, 2).
task(2, c, 3).
task(2, d, 1).
task(2, e, 4).
task(2, f, 5).

% O projeto 1 de exemplo não tem precedências

% precedence(Project, ActivityA, ActivityB), que indica que, no projeto Project, a tarefa 
% ActivityB só pode ser executada depois da tarefa ActivityA terminar.
precedence(2, a, b).
precedence(2, a, c).
precedence(2, b, d).
precedence(2, c, d).
precedence(2, d, e).
precedence(2, d, f).

% General predicates
get_project_activities(Project, ProjActivities) :-
    findall(Activity, task(Project, Activity, _Time), ProjActivities).

reverse_list(List, Reverse) :- reverse_list(List, [], Reverse).
reverse_list([], Acc, Acc).
reverse_list([Head|Tail], Acc, Reverse) :- reverse_list(Tail, [Head|Acc], Reverse).

get_proj_activity_precedences(Project, Activity, Precedences) :-
    findall(Act, precedence(Project, Act, Activity), Precedences).

% 16)
insert_task(Project, ListOfTasks, Task, NewListOfTasks) :-
    get_project_activities(Project, ProjActivities), format('ProjActivities: ~p\n', [ProjActivities]), 
    member(Task, ProjActivities), % Check if task belongs to the project
    \+ member(Task, ListOfTasks), % check if Task is already in ListOfTasks
    member(Task, ProjActivities), 
    findall(Precedence, precedence(Project, Precedence, Task), Precedences), % list with all vertexes that goes from Task to another vertex - precedences of Task
    insert_after_precedences(Precedences, ListOfTasks, Task, NewListOfTasks). % Insert task after precedences

insert_after_precedences([], ListOfTasks, Task, [Task | ListOfTasks]).
insert_after_precedences([Precedence | Rest], ListOfTasks, Task, NewListOfTasks) :-
    nth0(PrefIndex, ListOfTasks, Precedence),
    length(Before, PrefIndex),  % Create a list contain the nodes before Precedence, and the Precedence node
    append(Before, [Precedence | After], ListOfTasks),
    insert_after_precedences(Rest, After, Task, AfterWithTask),
    append(Before, [Precedence | AfterWithTask], NewListOfTasks).


% 17)
check_order_contain_projactivities([], _).
check_order_contain_projactivities([OrderAct | Rest], ProjActivities) :-
    member(OrderAct, ProjActivities),
    check_order_contain_projactivities(Rest, ProjActivities).


check_activity_precedences_on_list([], _, []).
check_activity_precedences_on_list([PrecActivity | Rest], ActPrecedences, PrecedencesResult) :-
    member(PrecActivity, ActPrecedences), 
    check_activity_precedences_on_list(Rest, ActPrecedences, PrecedencesResult).
check_activity_precedences_on_list(_, ActPrecedences, ActPrecedences).



create_list_node_to_check_next([RestActivity | Rest], OldActPrecedences, Result) :-
    length(OldActPrecedences, LenOldActPrecedences),
    (LenOldActPrecedences =\= 0), 
    member(RestActivity, OldActPrecedences), 
    create_list_node_to_check_next(Rest, OldActPrecedences, Result).
create_list_node_to_check_next(Result, _, Result).

check_order_order(Project, []).
check_order_order(Project, [Activity | Rest]) :-
    format('-> Getting precedences of activity ~p\n', [Activity]), 
    get_proj_activity_precedences(Project, Activity, ActPrecedences), 
    check_activity_precedences_on_list(Rest, ActPrecedences, ActListPrecedences), 
    length(ActListPrecedences, LenActListPrecedences), 
    length(ActPrecedences, LenActPrecedences), 
    write('00\n'), 
    format('ActListPrecedences = ~p | ActPrecedences = ~p\n\n', [ActListPrecedences, ActPrecedences]), 
    format('LenActListPrecedences = ~p | LenActPrecedences = ~p\n\n', [LenActListPrecedences, LenActPrecedences]), 
    (LenActListPrecedences == LenActPrecedences), 
    write('11\n'), 
    % DEBUG
    format('Rest: ~p\n', [Rest]), format('ActPrecedences: ~p\n', [ActPrecedences]), 
    create_list_node_to_check_next(Rest, ActPrecedences, Result), 
    format('Result: ~p\n', [Result]),
    check_order_order(Project, Result).









generate_order(Project, Order) :-
    findall(Task, task(Project, Task, _), Tasks),
    generate_order(Project, [], Tasks, Order).

generate_order(_, Order, [], Order).
generate_order(Project, Acc, [Task|Tasks], Order) :-
    \+ precedes(Project, Task, Acc),
    generate_order(Project, [Task|Acc], Tasks, Order).
generate_order(Project, Acc, [_|Tasks], Order) :-
    generate_order(Project, Acc, Tasks, Order).

precedes(Project, TaskB, Tasks) :-
    task(Project, TaskA, _),
    precedence(Project, TaskA, TaskB),
    member(TaskA, Tasks).