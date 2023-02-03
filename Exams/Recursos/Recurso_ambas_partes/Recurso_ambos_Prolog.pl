:- use_module(library(lists)).

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

% get_pilot_races(PilotName, Acc, PilotRaces) :-
%     participant(RaceID, PilotName, _Laps), 
%     format('RaceID: ~p\n', [RaceID]),
%     format('Acc: ~p\n', [Acc]), 
%     \+ member(RaceID, Acc), !, 
%     append([RaceID], Acc, NewAcc), 
%     get_pilot_races(PilotName, NewAcc, PilotName).
% get_pilot_races(_, Acc, Acc).

% 9)
raced_in_city(PilotName, City) :-
    race(RaceID, City, _Laps), 
    participant(RaceID, PilotName, _Laps).

% 10)
sum_pilot_times([], Acc, Acc).
sum_pilot_times([Time | Rest], Acc, TotalTime) :-
    NewAcc is Acc + Time, 
    sum_pilot_times(Rest, NewAcc, TotalTime).

total_time(RaceID, PilotName, TotalTime) :-
    participant(RaceID, PilotName, Times), 
    sum_pilot_times(Times, 0, TotalTime).

% 11)
check_player_laps(RaceID, PilotName) :-
    race(RaceID, _City, RaceLaps), 
    participant(RaceID, PilotName, Laps), 
    length(Laps, PlayerLaps), 
    NewPlayerLaps is PlayerLaps + 1,
    (NewPlayerLaps =< RaceLaps).

register_lap(RaceID, PilotName, LapTime) :-
    check_player_laps(RaceID, PilotName), 
    participant(_, PilotName, _), 
    retract(participant(RaceID, PilotName, Laps)),
    append(Laps, [LapTime], NewLaps), 
    assert(participant(RaceID, PilotName, NewLaps)).

% 12)
print_race(RaceID) :-
    participant(RaceID, PilotName, Laps), !, 
    sum_pilot_times(Laps, 0, PilotTime), 
    length(Laps, NumLaps), 
    format('~p - ~p (~p)\n', [PilotName, PilotTime, NumLaps]), 
    fail.

% 13)
sum_my_list([], 0).
sum_my_list([Elem | Rest], Sum) :-
    sum_list(Rest, RestSum), 
    Sum is RestSum + Elem.

pilot_completed_race(RaceID, Pilot, Sum) :-
    race(RaceID, City, NumberOfLaps), 
    participant(RaceID, Pilot, Laps), 
    length(Laps, NLaps), 
    (NLaps == NumberOfLaps), % pilot completed the race ?
    sum_my_list(Laps, Sum).

final_rank(RaceID, Pilots) :-
    race(RaceID, _City, NumRaceLaps), 
    setof(PilotTime-PilotName, pilot_completed_race(RaceID, PilotName, PilotTime), Pilots).

% 14) O predicado predX/3 transforma cada elemento da lista [H|T] em uma nova estrutura usando 
%     o argumento A como o primeiro argumento da nova estrutura, preservando os demais argumentos 
%     da estrutura original.

% 15)  ????
