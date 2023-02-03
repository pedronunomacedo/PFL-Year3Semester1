:- use_module(library(lists)).

% dish(Name, Price, IngredientGrams).
dish(pizza,         2200, [cheese-300, tomato-350]).
dish(garlic_bread,  1600, [cheese-50, garlic-200]).
dish(ratatouille,   2200, [tomato-70, eggplant-150, garlic-50]).

:- dynamic ingredient/2.

% ingredient(Name, CostPerGram).
ingredient(cheese,   4).
ingredient(tomato,   2).
ingredient(eggplant, 7).
ingredient(garlic,   6).

% 1)
count_ingredients(Dish, NumIngredients) :-
    dish(Dish, _Price, Ingredients), 
    length(Ingredients, NumIngredients).

% 2)
ingredient_amount_cost(Ingredient, Grams, TotalCost) :-
    ingredient(Ingredient, CostPerGram), 
    TotalCost is CostPerGram * Grams.

% 3)
dish_profit(Dish, Profit) :-
    dish(Dish, DishPrice, Ingredients), 
    get_dish_cost(Ingredients, DishCost), 
    Profit is DishPrice - DishCost.

get_dish_cost([], 0).
get_dish_cost([Ingredient-IngGrams | Rest], DishCost) :-
    get_dish_cost(Rest, RestdishCost), 
    ingredient(Ingredient, IngCost), 
    DishCost is RestdishCost + IngCost * IngGrams.

% 4)
update_unit_cost(Ingredient, NewUnitCost) :-
    retract(ingredient(Ingredient, _OldIngCost)), 
    assert(ingredient(Ingredient, NewUnitCost)).
update_unit_cost(Ingredient, NewUnitCost) :-
    assert(ingredient(Ingredient, NewUnitCost)).

% 5)
most_expensive_dish(Dish, Price) :-
    dish(Dish, Price, _), 
    \+ (dish(Dish2, Price2, _), Price2 > Price).

% 6)
consume_ingredient(IngredientStocks, Ingredient, Grams, NewIngredientStocks) :-
    create_new_ingredients_list(IngredientStocks, Ingredient, Grams, NewIngredientStocks).

create_new_ingredients_list([], _, _, []).
create_new_ingredients_list([Ingredient1-Stock1 | Rest1], Ingredient, Grams, NewIngredientStocks) :-
    create_new_ingredients_list(Rest1, Ingredient, Grams, RestNewIngredientStocks), 
    (Ingredient1 == Ingredient ->
        NewStock is Stock1 - Grams, 
        (NewStock >= 0 ->
            append([Ingredient1-NewStock], RestNewIngredientStocks, NewIngredientStocks)
            ;
            fail
        )
        ;
        append([Ingredient1-Stock1], RestNewIngredientStocks, NewIngredientStocks)
    ).


% 7)
count_dishes_with_ingredient(Ingredient, N) :-
    count_dishes_with_ingredient_aux(Ingredient, [], N).

count_dishes_with_ingredient_aux(Ingredient, DishesVisited, N) :-
    dish(Dish, _Price, DishIngredients), 
    \+ member(Dish, DishesVisited),
    member(Ingredient-_, DishIngredients), !, 
    count_dishes_with_ingredient_aux(Ingredient, [Dish | DishesVisited], RestN), 
    N is RestN + 1.
    
count_dishes_with_ingredient_aux(_, _, 0).

% 8)
list_dishes(DishIngredients) :-
    findall(Dish-Ingredients, (Price)^dish(Dish, Price, Ingredients), DishIngredients).

% 9)
remove_price(_-Dish, Dish).

invert_dishes(InvDishes, Dishes) :-
    reverse(InvDishes, TempDishes), 
    maplist(remove_price, TempDishes, Dishes).

most_lucrative_dishes(Dishes) :- % not totally correct
    setof(Profit-Dish, dish_profit(Dish, Profit), InvDishes), 
    invert_dishes(InvDishes, Dishes).

% 10)
% predX/3 receives as argument (in order) a [] and a [dish name] to return a new list of 
% [ingredient-quantity pair] after [using the ingredients in stock to produce the dish].
% predX/3 [fails if there aren't enough ingredients in stock].

% 11) True

% 12) 
% predZ:-
% 	read(X),
% 	X =.. [_|B],
% 	length(B, N),
% 	write(N), nl.

% Response: Asks the user to input a Term and its arguments, like "read(a,b,c,d)" and returns 
%           the ariety of the term.

% 13) A function is said to be tail recursive when the recursive call is the last function 
%     invoked in the evaluation of the body of the function.
%     Response: C) By using an extra argument, one can rewrite certain recursive predicates 
%                  so that they are tail-recursive.

% 14) A Difference list in Prolog is a normal list except the very end of it is a logic variable, 
%     paired with that variable. For example: 
%              [a,b,c|E]-E
%     A common example to explain why they are useful is: 
%              append(I-M, M-O, I-O).
% Given this clause one can query: 
%              ?- append([a,b,c|E]-E,  [x,y,z|W]-W,  O).
%              E = [x, y, z|W],
%              O = [a, b, c, x, y, z|W]-W.
% 
% Response: C)

% 15) A) :- op(570, fx, some).

% 16) B) :- op(580, xfy, and).

% 17) Falso

% 18) ????

% 19) B) 5

% 20) False

% Information

%G1
edge(g1, br, o).
edge(g1, br, ni).
edge(g1, o, ni).
edge(g1, o, c).
edge(g1, o, h).
edge(g1, h, c).
edge(g1, h, n).
edge(g1, n, he).
edge(g1, c, he).

% G2
edge(g2, br, h).
edge(g2, br, ni).
edge(g2, h, ni).
edge(g2, h, o).
edge(g2, h, c).
edge(g2, o, c).
edge(g2, o, n).
edge(g2, n, he).
edge(g2, c, he).
edge(g2, cl, he).

% 21) 
common_edges(G1, G2, L) :-
    findall(V1-V2, (edge(G1, V1, V2), (edge(G2, V1, V2) ; edge(G2, V2, V1))), L).

% 22) (ERROR) ????
% Find all subgraphs of a graph
subgraphs(Graph, Subgraphs) :-
    findall(Vertices, subgraph(Graph, Vertices), Subgraphs).
    
% Find a subgraph by finding a starting vertex and finding all vertices connected to it
subgraph(Graph, Vertices) :-
    edge(Graph, V, _),
    connected_vertices(Graph, V, [V], Vertices).
    
% Find all connected vertices of a starting vertex
connected_vertices(Graph, Vertex, Visited, Vertices) :-
    findall(V, (edge(Graph, Vertex, V), \+ member(V, Visited)), Next),
    (Next == [] -> 
        Vertices = Visited 
        ;
        append(Visited, Next, NewVisited),
        connected_vertices(Graph, Next, NewVisited, Vertices) % ERROR: Here Next can be a list and it should be a single node
    ).

% Determine the common subgraphs between two graphs
common_subgraphs(G1, G2, Subgraphs) :-
    subgraphs(G1, Subgraphs1),
    subgraphs(G2, Subgraphs2),
    findall(
        S, 
        (member(S, Subgraphs1), member(S, Subgraphs2), length(S, Length), member(Length, Subgraphs2)), 
        Subgraphs
    ).
