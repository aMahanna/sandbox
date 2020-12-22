# Prolog

A few practice files of common problems implemented in Prolog. 

### `3-coloration.pl`
* Given three colours (red, blue, yellow), find all possible solutions to the 3-colorisation problem for any given number of windows. 

#### Example 
```
?- genere([b,c,d,i,j],C).
C = [red, yellow, red, yellow, blue];
C = [red, yellow, red, blue, yellow];
(...)
```

### `vacationRank.pl`
* Given a list of vacation preferences for a list of friends, display the vacation locations in order of overall preferability. 

#### Example 
```
?- where([marie,jean,sasha,helena,emma],Country).
```

### `isPrime.pl`
* Determines if a number is prime or generates  prime numbers on a line-by-line request basis. 

#### Example 
```
?- isprime(27). 
false.
?- isprime(29). 
true.
?- prime(X). 
X=1; 
X=2; 
X=3; 
X=5;
(...)
```
