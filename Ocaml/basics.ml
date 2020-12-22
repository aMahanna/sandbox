
(* 1a. Make it so that that x equals 42, by adding 22 to 20 *)
let x = 22 + 20;;


(* 1b. Make it so that x1 equals 42.0, by casting x. *)
(* Hint: Look in the OCaml documentation in the Pervasives chapter:
   http://caml.inria.fr/pub/docs/manual-ocaml/libref/Pervasives.html
   and search for "float". *)
let x1 = float_of_int x;;

(* 1c. Write a function that takes a string, and appends
 * " is my favourite programming language." to the end of it. *)
let favourizer (arg:string)  = arg ^ " is my favourite programming language.";;

(* call your favourizer, creating a complete string *)
let myfavourite:string = favourizer "GoLang";;

(* 1d. Write a function that takes a number and returns
 * the difference between that number and 42.
 * Eg, if 'num' is 50, the result should be 8.
 * If 'num' is 30, the result should be -12 *)
let diff_42 num = num - 42;;


(* 1e. One more simple arithmetic example...
 * Write a function that returns the volume of a cylinder
 * with radius r, height h. (volume is pi * r^2 * h) *)
let pi = 4.0 *. atan 1.0;;
let volume_cylinder (r:float) (h:float) : float = pi *. h *. (r ** 2.0);;

(* 1f. Determine if an integer is even. Again use the Pervasives library. *)
let even (x: int) : bool = x mod 2 = 0;;

(* 1g. Write odd in terms of even *)
let odd (x: int) : bool = even x != true;;


(* 1h. In addition to the Pervasives, OCaml comes pre-packaged with a
   standard library, that includes a lot of other utility functions that
   you don't have to write yourself.
  * For instance, check out the String module *
   (http://caml.inria.fr/pub/docs/manual-ocaml/libref/String.html) * *
   Now... write a function that takes a String, and returns whether *
   or not that String is more than 10 characters long. *)

let gt_10_chars str : bool = String.length str > 10;; 


(* 2. Compare the following two boolean values.  Why the difference? *)
(* let why1 = (1.0 = 1.0) => This will be true*) 
(* let why2 = (1.0 == 1.0) => This will be false*)
let because = "The == operator tests the identity of its arguments (equality of memory representations), while the = operator tests semantic equality (equality of values)";;
(* Moral of the story : Don't use == unless you really know what
 * you're doing
 *)


(* 3. Compute the GCD for two integers using Euclid's recursion
 * https://en.wikipedia.org/wiki/Euclidean_algorithm *)
let rec gcd (x : int) (y : int) : int = 
  if y = 0 then x 
  else gcd y (x mod y)
;;


(* 4. Compute the McCarthy 91 function as shown in 
 * http://en.wikipedia.org/wiki/McCarthy_91_function
 *)
let rec mccarthy (x : int) : int = 
  if x > 100 then x - 10
  else mccarthy(mccarthy (x + 11))
;;


(* 5. Optional advanced: Compute the square root of x using Heron of Alexandria's
 * algorithm (circa 100 AD).  x must be greater than 1.0.

 * We start with an initial (poor) guess that the square root is 1.0.
 * Let's call our current guess g.  We'll maintain the invariant that
 * g^2 is less than x and therefore that g is less than the square root
 * of x.

 * Notice that if g is less than the square root of x then x/g is slightly
 * greater than the square root of x.  The real square root is then between
 * g and x/g.

 * To compute a slightly better guess than g, we can take the average of
 * g and x/g:

     g + x/g
     -------
        2

 * We can keep improving our guess by averaging again and again.  Stop
 * the process when you get pretty close.  For this function, when the
 * difference between g and x/g is less than 0.001, compute one final
 * average and return it

 *  More on this method here:

 * http://www.mathpages.com/home/kmath190.htm

 * More on Heron of Alexandria here:

*)
let squareRoot (x : float) : float = recSquareRoot x x/.2.0 ((x/.2.0) +. 1);;

let rec recSquareRoot (x : float) (g : float) (g2 : float) : float =
  if x > 1.0 then 
    if g != g2 then 
      
    else  
  else print_string "x must be greater than 1"
;;





