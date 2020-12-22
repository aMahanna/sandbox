adj(a,b).
adj(a,g).
adj(b,c).
adj(b,i).
adj(c,d).
adj(d,e).
adj(d,j).
adj(e,l).
adj(f,g).
adj(g,h).
adj(h,i).
adj(i,j).
adj(j,k).
adj(k,l).
adj(l,m).

color(red).
color(yellow).
color(blue).

 % returns true if there are no more windows to look at

colorset([], []) :- !.


% take a list of windows, and generate a list of possible colour combinations

colorset([ _ | L], [X | C]) :- color(X),  colorset(L, C).

% returns true if window and colour lists are empty

diffadjcolor(_, _, [], []) :- !.

% fails if window and colour list are not the same size at the end.

diffadjcolor(_, _, [_], []) :- !, fail.
diffadjcolor(_, _, [], [_]) :- !, fail.

% if LET is adjacent to NLET (the next letter in the array), then make sure
% they do not share the same colour, then proceed to look at the next colour
% and window in line.

diffadjcolor(LET, COL, [NLET | LL], [CURRCOL | CL]) :- 
	adjacent(LET, NLET), COL \= CURRCOL, diffadjcolor(LET, COL, LL, CL), !.

% if LET is not adjacent to NLET (the next letter in the array), then make sure
% then proceed to look at the next colour and window in line.

diffadjcolor(LET, COL, [NLET | LL], [_ | CL]) :- 
	\+adjacent(LET, NLET), diffadjcolor(LET, COL, LL, CL).


% this allows us to know that if adj(b,c), then adj(c,b), even
% if it is not explicitly implied in the data.

adjacent(A, Y) :- adj(Y, A).
adjacent(A, Y) :- adj(A, Y).


% generate all valid colour combinations for a list of windows
genere(Gs, Cs) :- colorset(Gs, Cs), valid(Gs, Cs). 

% two empty lists are considered valid
valid([], []).

% take the first window W from WindowList (WL) and the first colour C from
% ColourList (CL), then make sure this combination is not adjacent to another
% combination of the same colour. Proceed to call valid() again for the remaining
% of the list WL and CL.

valid([W|WL], [C | CL]) :- diffadjcolor(W, C, WL, CL), valid(WL, CL).



