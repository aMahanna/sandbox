(* An employee is a tuple of name, age, and boolean indicating marriage status *)
type employee = string * int * bool
                                 
(* 1. Write a function that takes an employee, and prints out the information in some readable form. *)

let print_employee_info (t : employee) = 
	let (n, a, s) = t in 
		(Printf.printf "\nName: %s \nAge: %d \nMarital Status: %b\n" n a s);;

(* example: 

	let e = ("anthony", 20, false);;
	print_employee_info e;;

 *)

(* 2. Reimplement the OCaml standard functions List.length and List.rev.
   This question is optional, but is good practice for the next one. *)


let length (l:'a list) : int = getLength l 0;; 

let rec getLength (l:'a list) (c : int) : int = 
	match l with
	| [] -> c
	| h :: t -> getLength t (c + 1);;

(* example: 

	length [1;2;3;4;5];;

 *)

let rec rev (l:'a list) : 'a list = 
	match l with
	| [] -> []
	| h :: t -> rev t @ [h];;


(* example: 

	rev [1;2;3;4;5];;
	
 *)

(* 3. Remove the kth element from a list. Assume indexing from 0 *)
(* example: rmk 2 ["to" ; "be" ; "or" ; "not" ; "to" ; "be"] 
 * results in: [["to" ; "be" ; "not" ; "to" ; "be"] *)

let rec rmk (k:int) (l:'a list) : 'a list =
	match l with
	| [] -> []
	| h :: t -> if k = 0 then t else h :: rmk (k - 1) t;;


(* 
	example:

	rmk 2 ["to" ; "be" ; "or" ; "not" ; "to" ; "be"] 
*)


(* 4. Write a function that returns the final element of a list, 
   if it exists, and None otherwise *)

let rec final (l: 'a list) : 'a option = 
	match l with
	| [] -> None
	| [f] -> Some f
	| h :: t -> final t;;

(* 
	example:

	final [1;2;3;4;5]
*)


(* 5. Write a function to return the smaller of two int options, or None
 * if both are None. If exactly one argument is None, return the other. Do 
 * the same for the larger of two int options.*)


let min_option (x: int option) (y: int option) : int option = 
	if Option.is_none x then y
	else if Option.is_none y then x
	else if x <= y then x
	else y;;

(* 
	example:

	min_option (Some 2) (Some 3)
*)

let max_option (x: int option) (y: int option) : int option = 
	if Option.is_none x then y
	else if Option.is_none y then x
	else if x >= y then x
	else y;;

(* 
	example:

	max_option (Some 2) (Some 3)
*)


(* 6. Write a function that returns the integer buried in the argument
 * or None otherwise *)  
 

let get_option (x: int option option option option) : int option = 
	match x with
	| None -> None
	| Some (Some (Some  x)) -> x;;


(* 
	example:

	get_option (Some (Some (Some (Some 4))));;
*)


(* 7. Write a function to return the boolean AND/OR of two bool options,
 * or None if both are None. If exactly one is None, return the other. *)

let and_option (x:bool option) (y: bool option) : bool option = 
	match (x, y) with
	| (None, None) -> None
	| (Some a, None) -> x
	| (None, Some b) -> y
	| (Some a, Some b) -> Some (a && b);;


(* 
	examples:

	and_option (Some true) (Some true)

	and_option (Some true) (Some false)
*)


let or_option (x:bool option) (y: bool option) : bool option = 
	match (x, y) with
	| (None, None) -> None
	| (Some a, None) -> x
	| (None, Some b) -> y
	| (Some a, Some b) -> Some (a || b);;

(* 
	examples:

	or_option (Some true) (Some false)

	or_option (Some false) (Some false)
*)

(* What's the pattern? How can we factor out similar code? *)
	(* Answer: we can create two separate helper functions (OR & AND), and pass one of these functions
	 as an argument to a main function that we can create. For example: getBooleanValue or_helper (Some true) (Some false) 
	*)

(* 8. Optional (but important for preparation for next week's lab):
 * Write a higher-order function for binary operations on options.
 * If both arguments are present, then apply the operation.
 * If both arguments are None, return None.  If one argument is (Some x)
 * and the other argument is None, function should return (Some x) *)
(* What is the type of the calc_option function? *)

(* Answer: calc_option is of type ('a -> 'a -> 'a) -> 'a option -> 'a option -> 'a option) *)

let calc_option (f: 'a->'a->'a) (x: 'a option) (y: 'a option) : 'a option =  
	match (x, y) with
	| (None, None) -> None
	| (Some a, None) -> x
	| (None, Some b) -> y
	| (Some a, Some b) -> Some (f a b);;

(* 9. Optional (but important for preparation for next week's lab):
 * Now rewrite the following functions using the above higher-order function
 * Write a function to return the smaller of two int options, or None
 * if both are None. If exactly one argument is None, return the other.
 * Do the same for the larger of two int options. *)


(* PLEASE NOTE: 
	
	The "f" parameter of calc_option (which is a function) 
	does NOT take any options as parameters. F is of type
	a' -> a' -> a' (it does not return an option either). 

	As a result, I have modified min_option2 and max_option2 
	FROM int option -> int option -> int option 
	TO int -> int -> int.

	This makes more sense in this context because we want to pass
	min_option2 and max_option2 as parameters in calc_option. 
*)

let min_option2 (x: int) (y: int) : int = 
	if x <= y then x
	else y;;

(* EXAMPLE:

	calc_option min_option2 (Some 5) (Some 7)

	OUTPUT: - : int option = Some 5

*)

let max_option2 (x: int) (y: int) : int = 
	if x >= y then x
	else y;;

(* EXAMPLE:

	calc_option max_option2 (Some 5) (Some 7)

	OUTPUT: - : int option = Some 7
*)


let rec reduce (f:'a -> 'b -> 'b) (u:'b) (xs:'a list) : 'b =
  match xs with
  | [] -> u
  | hd::tl -> f hd (reduce f u tl);;

(* 6. Write a new version of and_list and or_list from Question 1,
   but this time, use reduce as defined above. *)

          
let and_list' (lst: bool list) : bool = reduce (fun x y -> x && y) true lst
           
let or_list' (lst: bool list) : bool = reduce (fun x y -> x || y) false lst

let test_and_list = and_list' [true; true; true];;

let test_or_list = or_list' [false; false; true];;


(* 7. Implement length in terms of reduce.  length lst returns the
   length of lst. length [] = 0. *)

          
let length (lst: int list) : int = reduce (fun x y -> 1 + y) 0 lst

let test_length = length [1; 2; 3];;

  
(* 8. Redo Question 3 using reduce.  I.e., write a function that
   returns the max of a list, or None if the list is empty. *)


let max_of_list' (lst:int list) : int option = 
	if lst = [] then None else Some(reduce (fun x y -> if x > y then x else y) min_int lst)
 
let test_max_of_list = max_of_list' [1; 2; 3; 4; 5];;

(* 9. Write a function that returns both the min and max of a list, or
   None if the list is empty. You can use reduce, but you don't have
   to. *)


let bounds (lst:int list) : (int option * int option)  = 
	if lst = [] then (None, None) 
	else
		(Some (reduce (fun x y -> if x < y then x else y) max_int lst), 
			Some (reduce (fun x y -> if x > y then x else y) min_int lst))

let test_bounds = bounds [1; 2; 3; 4; 5];;


