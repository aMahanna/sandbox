(* Preface: Some OCaml code that you may need in some of your answers
   below. (Some questions will refer to code in the preface, and you
   can find that code here.) *)

let inc x = x+1
let square y = y*y
let add x y = x+y
let mult x y = x*y
let double s = s ^ s
let uppercase s = String.uppercase_ascii s
let concat s1 s2 = s1 ^ s2
let add_to_ends s s' = s' ^ s ^ s'

type 'a tree = | Leaf of 'a
               | Node of 'a tree * 'a tree

let rec map (f:'a -> 'b) (xs: 'a list) : 'b list =
  match xs with
  | [] -> []
  | hd::tl -> (f hd) :: (map f tl)

module type STACK = 
  sig
    type 'a stack
    val empty : unit -> 'a stack
    val push  : 'a -> 'a stack -> 'a stack
    val is_empty : 'a stack -> bool
    val pop : 'a stack -> 'a stack * 'a option
  end

module ListStack : STACK = 
  struct
    type 'a stack = 'a list
    let empty() : 'a stack = []
    let push (x:'a)(s:'a stack) : 'a stack = x::s
    let is_empty(s:'a stack) = 
	   match s with
     | [] -> true
     | _::_ -> false
    let pop (s:'a stack) : 'a stack * 'a option =
      match s with 
       | [] -> ([],None)
       | h::tl -> (tl,Some h)
end

type 'a mlist = 
  Nil | Cons of 'a * ('a mlist ref)

(* Question A  Types in OCaml *)

(* For all parts of Question A, uncomment and fill in the expressions
   below to satisfy the types and follow any other instructions that
   are given.  As in Assignment 2, for option, list, and function
   types, you must provide a nontrivial answer. For a list that means
   a non-empty one, for an option type that means a Some construction,
   and for a function, that means using all its arguments to generate
   the return value.  *)

let a1 : int list = 3::4 :: [1;2;3]

let a2 : (string * bool) list list = [[("hi", true); ("hello", false)]; [("HI", false); ("HELLO", true)]]

let a3 : (string -> string -> string) list = [(fun s y -> s ^ y); (fun s y -> y ^ s)]

(* (a4) Define a function a4 that has type int -> int -> int tree. *)

let f (i : int) (j : int) : int tree = Node(Leaf i, Leaf j);;

(* (a5) Using the 'a tree data type defined in the preface, represent
   the following tree.  You may define auxiliary functions and
   variables to help build the tree step-by-step, but this is not
   required. *)

(*
           /\
          /  \
         /    \
        /     "rain"
       /\
      /  \
     /    \
"snow"    "sun"
 *)



let a5 : string tree = Node(Node(Leaf "snow", Leaf "sun"), Leaf "rain");;

(* Question B  Options *)

(* Write a function that takes two int option arguments and returns a
   float option. The function should divide the first argument by the
   second if both arguments are present and the second is not 0.
   Convert values of type int to float when necessary. Otherwise, the
   function must return None. Name your function "div_option" *)

let div_option (a : int option) (b : int option) : float option = 
  match (a, b) with
  | (None, None) -> None
  | (None, Some y) -> None
  | (Some x, None) -> None 
  | (Some x, Some 0) -> None
  | (Some x, Some y) -> Some ((float_of_int x) /. (float_of_int y))


(* Question C  Programming with Data Types *)

type newtype =
  | Con1 of string
  | Con2 of string * int

(* Write a function that takes a string and a list of elements of
   newtype and counts the number of times that the string appears in
   the elements of the list. For example, the function should return 2
   if the input string is "yes" and the input list is:
   [Con1 "yes"; Con2 ("no", 3); Con2 ("yes", 4)]

   Your function should be called count_occurrences and have type
   string -> newtype list -> int.
*)

let rec count_occurrences (s : string) (l : newtype list) : int = 
   match l with 
   | [] -> 0
   | Con1 a :: tl when a = s -> 1 + count_occurrences s tl
   | Con2 (a, b) :: tl when a = s -> 1 + count_occurrences s tl
   | hd :: tl -> count_occurrences s tl


(* Question D Higher-Order and Polymorphic Programming *)

(* Use the map function included in the preface to implement a
   function transform_newtype that takes a string s and a list of
   elements of newtype and returns a new list where the string
   component of every element of the list is replaced by s.


*)

let transform_newtypes (s:string) (xs:newtype list) : newtype list =
  let aux (newString : string) (c : newtype)  : newtype = 
    match c with
    | Con1 t -> Con1 newString
    | Con2 (t, i) -> Con2 (newString, i)
  in map (aux s) xs


(* Question E Modules and Abstract Data Types *)

(* The interface and structure for the polymorphic immutable stack
   datatype given in the code in the preface is very similar to the
   code in the course notes.  The only difference is that there is no
   "top" operation and the "pop" operation returns a tuple containing
   both the new stack and the top element.  Replace all of the
   occurrences of ?? in the bodies of teststack1 and teststack2 so
   that when they are called they return true. *)

let teststack1 () =
   let emp = ListStack.empty() in
   let s0 = ListStack.push "x" emp in
   let s1 = ListStack.push "y" s0 in
   let s2 = ListStack.push "z" s1 in
   let (s3,a) = ListStack.pop s2 in
   let (s4,b) = ListStack.pop s3 in
   let (s5,c) = ListStack.pop s4 in
   (a = Some "z" && b = Some "y" && c = Some "x" && ListStack.is_empty s5)

let teststack2 () =
   let emp = ListStack.empty() in
   let s0 = ListStack.push "a" emp in
   let s1 = ListStack.push "b" emp in
   let (s2,a) = ListStack.pop s0 in
   (a = Some "a" && ListStack.is_empty s2)


(* Question F Mutable Types *)

(* Question F1  *)
(* The code in the preface includes the 'a mlist data type for fully
   mutable lists studied in class. *)
(* Below is an example mutable list. *)
let ml_example : char mlist = Cons('z', ref (Cons('a', ref (Cons('m', ref Nil)))))

(* Consider a new alternative representation of mutable lists as a
   list of references, where each reference is a pointer to some
   value. *)

type 'a new_mlist = 'a ref list

(* Build a new version of ml_example using this new representation.
   The new list should have the same elements occurring in the same
   order. 

*)

let rl : char new_mlist = [ref 'z'; ref 'a'; ref 'm'];;

(* Question F2 *)
(* Describe briefly what the following function does. *)

let mlist_example (x:'a) (xsr:'a mlist ref) (ys:'a mlist): unit =
  match !xsr with
    Nil -> xsr := Cons(x,ref ys)
  | Cons(y,t) -> t:=ys


let description = "This function modifies the xsr 'a mlist argument that is passed as a reference.

                    If the contents of xsr is Nil, then xsr now holds the x argument as its first element,
                      followed by the entire content of the ys 'a mlist (as a reference).

                    If the contents of xsr is not Nil (thus it is a Cons contaning an 'a value and the rest 
                      of its list), then we simply replace the remainder of xsr (which is t) with the entire ys 'a mlist 
                        (of course always as a reference)." 






