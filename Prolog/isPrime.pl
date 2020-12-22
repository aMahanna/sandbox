% the "prime(X)" example in the assignment
% considered 1 as the first prime number,
% so we will assume that in this case, 1 is prime.
isPrime(1).

% calls checkModulo() to check if X has a multiple in between 2 and sqrt(X)
isPrime(X):- X >= 2, S is floor(sqrt(X)), checkModulo(X, 2, S, _), !.

% stop and return true if we have passed sqrt(X)
checkModulo(_, Y, S, _) :- Y > S, !.

% checks if Y is between 2 and sqrt(X)
% checks if X mod Y is not equal to 0 (if it is, predicate is false and so X is not prime).
% increments Y to move on to the next number to check
% calls checkModulo() again
checkModulo(X, Y, S, M) :- between(2,S,Y), M is X mod Y, M \= 0, W is Y + 1, checkModulo(X, W, S, _).

% generates the next prime number until user ends program with a "."
prime(X) :- between(1, infinite, X), isPrime(X).


  