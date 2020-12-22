% weekends(Month, Year, WeekEndTemperature, Normals) 

weekends(mars,2020, [-4,-1, 6, 4,-2,-4, 0, 7, 8], [-1, 0, 0, 2, 2, 4, 4, 6 ,6]).

% difference([-4,-1, 6, 4,-2,-4, 0, 7, 8], [-1, 0, 0, 2, 2, 4, 4, 6 ,6], D).


difference(A, X, D) :- length(A, N), length(X, N), differenceAux(A, X, [], DF), reverse(DF, D).


% Prédicat differenceAux
% Retourne D si les listes sont vides 
% Sinon, fait appel à lui même avec des nouveau paramètres:

% A = Le prmier élément de la première liste
% B = Le restant de la première liste

% X = Le prmier élément de la deuxième liste
% Y = Le restant de la deuxième liste

% [D1 | TMP] = La nIÈME difference est ajouté à la liste temporaire TMP, D1 étant la difference entre A et X
% D = Le résultat final de differenceAux

differenceAux([], [], D, D). 
differenceAux([A | B], [X | Y], TMP, D) :- differenceAux(B, Y, [D1 | TMP], D), D1 is A - X.

% positive([-3, -1, 6, 2, -4, -4, 1, 2], N).

% Prédicat positive
% Cas de base: N is 0 si la liste est vide
% Cas 1: H est positif, appel récursif en ajoutant 1 à notre N 
% Cas 2: H est negatif (ou 0), continue à traverser la liste avec un autre appel récursif.
positive([], 0).
positive([H | T], N) :- H > 0, !, positive(T, N1), N is 1 + N1.
positive([H | T], N) :- H =< 0, positive(T, N). 

% Prédicat niceMonth
% 1) Cherche les variables WeekEndTemperature et Normals de notre fait de base 
% 2) Calcul la difference (D) entre ces deux listes 
% 3) Calcul le nombre de valeurs positives N dans la liste D
% 4) Cherche la taille L de la liste D
% 5) Compare N à la moitié de L pour voir si N est supérieur ou égale. Si oui, niceMonth() retournera TRUE    
niceMonth(Month, Year) :- weekends(Month, Year, WeekEndTemperature, Normals), 
							difference(WeekEndTemperature, Normals, D), 
								positive(D, N), 
									length(D, L),
										N >= L / 2.
 
