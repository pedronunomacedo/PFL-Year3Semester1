%1a

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


%1b
/*

i)  female('Haley').
    yes
ii) male('Gil').
    no
iii) parent('Frank','Phil').
     yes
iv) parent(X,'Claire'),write(X),nl,fail.
    DeDe
    Jay
    no
v)  parent('Gloria',X),write(X),nl,fail.
    Joe
    Manny
    no
vi) parent('Jay',X),parent(X,Y),write(Y),nl,fail.
    Haley
    Alex
    Luke
    Lily
    Rexford
    no
vii) parent(X,Y),parent(Y,'Lily'),write(X),nl,fail.
     DeDe
     Jay
     Barb
     Merle
     no
viii) parent('Alex',X),write(X),fail.
      no
ix) parent('Jay',X),\+parent('Gloria',X),write(X),nl,fail.
    Claire
    Mitchell
    no

*/

%1c

father(X,Y) :-
    male(X), 
    parent(X,Y).

grandparent(X,Y) :-
    parent(X,Z),parent(Z,Y).

grandmother(X,Y) :-
    female(X), 
    grandparent(X,Y).

siblings(X,Y) :-
    parent(P1,X),
    parent(P2,X),
    parent(P1,Y),
    parent(P2,Y),
    (X \= Y),
    % (X @< Y), 
    (P1 \= P2).

halfSiblings(X,Y) :- 
    parent(P,X),
    parent(P,Y),
    X \= Y,
    \+siblings(X,Y).

cousins(X,Y) :- 
    parent(PX, X),
    parent(PY, Y), 
    siblings(PX, PY), 
    (X \= Y), 
    (PX \= PY).

uncle(X,Y) :-
    parent(PY, Y), 
    siblings(X, PY), 
    male(X).

%1d

% | ?- cousins('Haley','Lily').
% yes

% | ?- father(X, 'Luke'), write(X), nl, fail.
% Phil
% no

% | ?- uncle(X, 'Lily'), write(X), nl, fail.
% no

% | ?- grandparent(X, 'Lily'), write(X), nl, fail.
% DeDe
% Jay
% Barb
% Merle
% no

