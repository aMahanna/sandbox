% Anthony Mahanna
% 300059693
% amaha100@uottawa.ca

choice(marie, [peru,greece,vietnam]).
choice(jean, [greece,peru,vietnam]).
choice(sasha, [vietnam,peru,greece]).
choice(helena,[peru,vietnam,greece]).
choice(emma, [greece,peru,vietnam]).

% 1) find the total country rank of each possible choice
% 2) find the max ranked country out of the 3 possible choices
% 3) list the country associated with that max ranking
% *SPECIAL CASE* : if more than one country has the MAXPOINTS, 
% both solutions will be presented.
where(L, C) :- totalCountryRank(L, peru, R1), 
						totalCountryRank(L, greece, R2), 
						totalCountryRank(L, vietnam, R3),
						returnMax(R1, R2, Y), returnMax(R3, Y, MAXPOINTS), 
						totalCountryRank(L, C, MAXPOINTS).

% returns 0 if there are no more people to look at
totalCountryRank([], _, 0).

% sums up all of the indiviidual rankings of the list
totalCountryRank([N|L], C, R) :- findIndividualRank(N, C, Y), totalCountryRank(L, C, R1), R is Y + R1.

% returns 3 points if the choice C is the first head of the array
findIndividualRank(N, C, 3) :- choice(N, [C|_]).

% returns 2 points if the choice C is the second head of the array
findIndividualRank(N, C, 2) :- choice(N, [_|[ C | _]]).

% returns 1 point if the choice C is the third head of the array
findIndividualRank(N, C, 1) :- choice(N, [_ | [_ | [C |_]]]).

% safety net; returns 0 if the choice is not in the array at all
findIndividualRank(N, C, 0) :- choice(N, X), not(member(C, X)).


% returns the maximum out of two values
% returns X if X is equal to Y.
returnMax(X, Y, X) :- X >= Y, !. 
returnMax(X, Y, Y) :- Y > X, !.



 