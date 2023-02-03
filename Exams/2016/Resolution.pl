:- use_module(library(lists)).


%participant(id,Age,Performance)
participant(1234, 17, 'Pé coxinho').
participant(3423, 21, 'Programar com os pés').
participant(3788, 20, 'Sing a Bit').
participant(4865, 22, 'Pontes de esparguete'). 
participant(8937, 19, 'Pontes de pen-drives').
participant(2564, 20, 'Moodle hack').

%performance(id, Times)
performance(1234,[120,120,120,120]). 
performance(3423,[32,120,45,120]). 
performance(3788,[110,2,6,431]).
performance(4865,[120,120,110,120]).
performance(8937,[97,101,105,110]).


% 1)
madeItThrough(Participant) :-
    performance(Participant, Presses), 
    member(120, Presses). % If there is at least an element '120' that means that that juri didn't press the button (maximum_performance_time = 120)

% 2)
juriTimes([], _, [], 0).
juriTimes([Participant | Rest1], JuriMember, [Time | Rest2], Total) :-
    performance(Participant, Presses), 
    findPress(Presses, 0, JuriMember, Time),
    juriTimes(Rest1, JuriMember, Rest2, Total1), 
    Total is Total1 + Time.

findPress([Time | Rest], JuriMember, JuriMember, Time).
findPress([Press | Rest], CurrentPress, JuriMember, Time) :-
    NextCurrentPress is CurrentPress + 1,
    findPress(Rest, NextCurrentPress, JuriMember, Time).

% 3)
patientJuri(N) :-
    JuriMember is N - 1, 
    findPatientJuri(JuriMember, 0).

findPatientJuri(JuriMember, Counter) :-
    performance(Participant1, Presses1), 
    performance(Participant2, Presses2), 
    (Participant1 \= Participant2), 
    findPress(Presses1, 0, JuriMember, Time), 
    findPress(Presses2, 0, JuriMember, Time), 
    (Time == 120).

% 4)
participantTime(Participant, [], 0).
participantTime(Participant, [Time | Rest], Total) :-
    participantTime(Participant, Rest, Total1), 
    Total is Total1 + Time.

bestParticipant(P1, P2, P) :-
    performance(P1, Presses1), 
    performance(P2, Presses2), 
    participantTime(P1, Presses1, T1), 
    participantTime(P2, Presses2, T2), 
    (T1 > T2 ->
        P = P1
        ;
        (T1 < T2 ->
            P = P2
            ;
            fail
        )
    ).

% 5)
allPerfs :-
    participant(Participant, _Age, NamePerf),
    performance(Participant, Presses), 
    write(Participant), write(';'), write(NamePerf), write(';'), write(Presses), nl, 
    fail.

% 6)
countNJuriNotPresses([], 0).
countNJuriNotPresses([Time | Rest], Times) :-
    countNJuriNotPresses(Rest, Times1), 
    (Time == 120), 
    Times is Times1 + 1.

countNJuriNotPresses([Time | Rest], Times) :-
    countNJuriNotPresses(Rest, Times).

participantSuccessful(Participant) :-
    performance(Participant, Presses), 
    countNJuriNotPresses(Presses, Times), 
    length(Presses, Times).

nSuccessfulParticipants(T) :-
    findall(Participant, participantSuccessful(Participant), SuccessfulPart), 
    length(SuccessfulPart, T).

% 7)
findJuriFans(P, Juris) :-
    performance(P, Times), 
    findall(Juri, (nth0(Juri1, Times, Time) , (Time == 120), Juri is Juri1 + 1) , Juris).

juriFans(JuriFansList) :-
    findall(Participant-Juris, findJuriFans(Participant, Juris), JuriFansList).

% 8)
eligibleOutcome(Id, Perf, TT) :-
    performance(Id, Times), 
    madeItThrough(Id), 
    participant(Id, _, Perf),
    sumlist(Times, TT).

nextPhase(N, Participants) :-
    nextPhaseAux(N, Participants, []).

nextPhaseAux(0, [], _).
nextPhaseAux(N, Participants, List) :-
    eligibleOutcome(Id1, Perf1, TT1), 
    \+ member(Id1, List), 
    \+ (eligibleOutcome(Id2, Perf2, TT2), \+ member(Id2, List), Id1 \= Id2, TT2 > TT1),
    NextN is N - 1, 
    append([Id1], List, List2), 
    nextPhaseAux(NextN, Participants2, List2), 
    append([TT1-Id1-Perf1], Participants2, Participants).

% 9) O predicado predX coloca numa lista as pontuações de todos os participantes cuja idade é menor ou igual a Q.
%    O cut apresentado é verde, visto que a sua existência não altera as soluções encontradas.

% 10) O predicado produz uma lista L que contém dois valores X, onde entre eles existe Mid (lista com X valores não instanciados).

% 11) (????)
% langford(N, L) :-

% 12) (We didn't learn this!)

% 13) (We didn't learn this!)

