(* We can represent expressions given by the grammar:

   e ::= num | e + e

   by using objects from a class called "expression".  We begin with
   an abstract class (using the keyword "virtual" in OCaml) called
   "expression".  Although this class has no instances, it lists the
   operations common to all the different kinds of expressions.  These
   operations include a predicate "is_atomic" indicating whether there
   are subexpressions or not, operations to retrieve the left and
   right subexpressions (if the expression is not atomic), and a
   method computing the value of the expression.
 *)

class virtual expression = object
  method virtual is_atomic : bool
  method virtual left_sub : expression option
  method virtual right_sub : expression option
  method virtual value : int
end

(* Because the grammar has two cases, we have two subclasses of
   "expression", one for numbers, and one for sums.
 *)

class number_exp (n:int) = object
  inherit expression as super
  val mutable number_val = n
  method is_atomic = true
  method left_sub = None
  method right_sub = None
  method value = number_val
end               

class sum_exp (e1:expression) (e2:expression) = object
  inherit expression as super
  val mutable left_exp = e1
  val mutable right_exp = e2
  method is_atomic = false
  method left_sub = Some left_exp
  method right_sub = Some right_exp
  method value = left_exp#value + right_exp#value
end

(* QUESTION 1. Product Class and Method Calls *)
(* 1(a). Extend this class hierarchy by writing a "prod_exp" class to
   represent product expressions of the form:

   e ::= ... | e * e
 *)

class prod_exp (e1:expression) (e2:expression) = object
  inherit expression as super
  val mutable left_exp = e1
  val mutable right_exp = e2
  method is_atomic = false
  method left_sub = Some left_exp
  method right_sub = Some right_exp
  method value = left_exp#value * right_exp#value
end

(* 1(b). Create objects representing the following expressions:
   - An expression "a" representing the number 3
   - An expression "b" representing the number 0
   - An expression "c" representing the number 5
   - An expression "d" representing the sum of "a" and "b"
   - An expression "e" representing the product of "d" and "c"
   Then send the message "value" to "e".
   Note that "e" represents the expression (3+0)*5.

 *)

(* An expression "a" representing the number 3 *)
 let a = new number_exp 3;;
(* An expression "b" representing the number 0 *)
 let b = new number_exp 0;;
(* An expression "c" representing the number 5 *)
 let c = new number_exp 5;;
(* An expression "d" representing the sum of "a" and "b" *)
 let d = new sum_exp a b;;
(* An expression "e" representing the product of "d" and "c" *)
 let e = new prod_exp d c;;
(* Then send the message "value" to "e". *)
let _ = e#value;; 
                                              
(* QUESTION 2. Unary Expressions *)
(* Extend the class hierarchy further by writing a "square_exp".
   The expression below written e^2 means "e squared":

   e ::= ... | e^2

   Changes will be required to the "expression" interface, so you will
   need to reimplement all the classes from above with these changes.
   Try to make as few changes as possible to the program.

    e ::= num | e + e | e * e | e^2 

*)

(* As confirmed by the TA, the operation e^2 only needs one leaf, since it is the same object multiplied by itself *)
class square_exp (e1:expression) = object
  inherit expression as super
  val mutable left_exp = e1 
  val mutable right_exp = None
  method is_atomic = false
  method left_sub = Some left_exp
  method right_sub = None
  method value = left_exp#value * left_exp#value
end

(* QUESTION 3. Ternary Expressions and More Method Calls *)
(* 3(a). Extend this class heirarchy by writing a "cond_exp" class to
   represent conditionals of the form

   e ::= ... | e?e:e

   In a conditional expression a?b:c, evaluate "a" and if the value is
   not 0, then return the value of "b".  If the value of "a" is 0,
   then return the value of "c".

   Again, try to make as few changes as possible to the program.  If
   necessary, redesign the class hierarchy you created for Question 2
   so that it handles both unary and ternary expressions.
 *)

class virtual expressionQ3 = object
  method virtual is_atomic : bool
  method virtual cond_sub : expressionQ3 option (* Added for Q3 A *) 
  method virtual left_sub : expressionQ3 option
  method virtual right_sub : expressionQ3 option
  method virtual value : int
end

class number_expQ3 (n:int) = object
  inherit expressionQ3 as super
  val mutable number_val = n
  method is_atomic = true
  method cond_sub = None (* Added for Q3 A *) 
  method left_sub = None
  method right_sub = None
  method value = number_val
end               

class sum_expQ3 (e1:expressionQ3) (e2:expressionQ3) = object
  inherit expressionQ3 as super
  val mutable left_exp = e1
  val mutable right_exp = e2
  method is_atomic = false
  method cond_sub = None (* Added for Q3 A *) 
  method left_sub = Some left_exp
  method right_sub = Some right_exp
  method value = left_exp#value + right_exp#value
end

class prod_expQ3 (e1:expressionQ3) (e2:expressionQ3) = object
  inherit expressionQ3 as super
  val mutable left_exp = e1
  val mutable right_exp = e2
  method is_atomic = false
  method cond_sub = None (* Added for Q3 A *) 
  method left_sub = Some left_exp
  method right_sub = Some right_exp
  method value = left_exp#value * right_exp#value
end

class square_expQ3 (e1:expressionQ3) = object
  inherit expressionQ3 as super
  val mutable left_exp = e1 (* The operation e^2 only needs one leaf, since it is the same object multiplied by itself *)
  val mutable right_exp = None
  method is_atomic = false
  method cond_sub = None (* Added for Q3 A *) 
  method left_sub = Some left_exp
  method right_sub = None
  method value = left_exp#value * left_exp#value
end

class cond_expQ3 (e1:expressionQ3) (e2:expressionQ3) (e3:expressionQ3) = object
  inherit expressionQ3 as super
  val mutable cond_exp = e1
  val mutable left_exp = e2
  val mutable right_exp = e3
  method is_atomic = false
  method cond_sub = Some cond_exp (* Added for Q3 A *) 
  method left_sub = Some left_exp
  method right_sub = Some right_exp
  method value = if cond_exp#value != 0 then left_exp#value else right_exp#value
end

(* 3(b). Re-create all the objects a,b,c,d,e above and create new
   objects:
   - An expression "f" representing the square of "c"
   - An expression "g" representing the conditional b?e:f
   Then send the message "value" to "g".
 *)

let a = new number_expQ3 3;;
let b = new number_expQ3 0;;
let c = new number_expQ3 5;;
let d = new sum_expQ3 a b;;     (*  3 *)
let e = new prod_expQ3 d c;;    (* 15 *)
let f = new square_expQ3 c;;    (* 25 *)
let g = new cond_expQ3 b e f;; 
let _ = g#value;;

(* 3(c) Enter the following expressions (for a,b,c,d,e,f,g) into OCaml
   so that you can see what is printed by the OCaml interpreter.  In
   each case, the type of the expression will be printed. Note that
   they are not all the same.

   Then enter the expression defining the value of "e_list".  Note
   that this is a list containing elements of type "expression", which
   is a different type than the ones printed out for a,b,c,d,e,f,g.
   Explain why these elements are all allowed to have more than one
   type in OCaml.

   To answer 3(c), uncomment this code and execute it.


  "Explain why these elements are all allowed to have more than one type in OCaml"s.
   
    --> By definition, sub-typing is considered as the following:
        
        "If an object a has all the functionality of an object b, then we may
          use a in any context where b is expected."

   --> Therefore, due to the concept of sub-typing, all of these objects can
        be caracterized as more than one type, and therefore can be
        stored in a list of type "expressionQ3 list".
*)

let _ = a
let _ = b
let _ = c
let _ = d
let _ = e
let _ = f
let _ = g
let e_list : expressionQ3 list = [a;b;c;d;e;f;g]

(* QUESTION 4. Redesign the entire hierarchy again, so that it
   includes a new operation that takes one argument (x:int) and
   modifies an expression object so that all of its leaves are
   incremented by the value of x.  (The leaves of an expression are
   all the subexpressions belonging to the "number_exp" class.)  This
   operation should not return a new instance of an "expression".  It
   should modify the instances that it is applied to.

   Re-create all the objects a,b,c,d,e,f,g again.  Then send the
   message "value" to "g".  Then apply the new operation with any
   argument value greater than 0.  Then send the message "value" to
   "g". The new value should be different than the original one.
   Verify that your implementation gives the expected new value.  *)

class virtual expressionQ4 = object
  method virtual is_atomic : bool
  method virtual cond_sub : expressionQ4 option (* Added for Q3 A *) 
  method virtual left_sub : expressionQ4 option
  method virtual right_sub : expressionQ4 option
  method virtual value : int
  method virtual applyX  : int -> unit
end

class number_expQ4 (n:int) = object
  inherit expressionQ4 as super
  val mutable number_val = n
  method is_atomic = true
  method cond_sub = None (* Added for Q3 A *) 
  method left_sub = None
  method right_sub = None
  method value = number_val
  method applyX x = number_val <- x + number_val (* Added for Q4 *)
end               

class sum_expQ4 (e1:expressionQ4) (e2:expressionQ4) = object
  inherit expressionQ4 as super
  val mutable left_exp = e1
  val mutable right_exp = e2
  method is_atomic = false
  method cond_sub = None (* Added for Q3 A *) 
  method left_sub = Some left_exp
  method right_sub = Some right_exp
  method value = left_exp#value + right_exp#value
  method applyX x = (left_exp#applyX x; right_exp#applyX x; ()) (* Added for Q4 *)
end

class prod_expQ4 (e1:expressionQ4) (e2:expressionQ4) = object
  inherit expressionQ4 as super
  val mutable left_exp = e1
  val mutable right_exp = e2
  method is_atomic = false
  method cond_sub = None (* Added for Q3 A *) 
  method left_sub = Some left_exp
  method right_sub = Some right_exp
  method value = left_exp#value * right_exp#value
  method applyX x = (left_exp#applyX x; right_exp#applyX x; ()) (* Added for Q4 *)
end

(* As confirmed by the TA, the operation e^2 only needs one leaf, since it is the same object multiplied by itself *)
class square_expQ4 (e1:expressionQ4) = object
  inherit expressionQ4 as super
  val mutable left_exp = e1 
  val mutable right_exp = None
  method is_atomic = false
  method cond_sub = None (* Added for Q3 A *) 
  method left_sub = Some left_exp
  method right_sub = None
  method value = left_exp#value * left_exp#value
  method applyX x = (left_exp#applyX x; ())           (* Added for Q4 *)
end

class cond_expQ4 (e1:expressionQ4) (e2:expressionQ4) (e3:expressionQ4) = object
  inherit expressionQ4 as super
  val mutable cond_exp = e1
  val mutable left_exp = e2
  val mutable right_exp = e3
  method is_atomic = false
  method cond_sub = Some cond_exp (* Added for Q3 A *) 
  method left_sub = Some left_exp
  method right_sub = Some right_exp
  method value = if cond_exp#value != 0 then left_exp#value else right_exp#value
  method applyX x = (cond_exp#applyX x; left_exp#applyX x; right_exp#applyX x; ()) (* Added for Q4 *)
end

let a = new number_expQ4 3;;
let b = new number_expQ4 0;;
let c = new number_expQ4 5;;
let d = new sum_expQ4 a b;;     (*  3 *)
let e = new prod_expQ4 d c;;    (* 15 *)
let f = new square_expQ4 c;;    (* 25 *)
let g = new cond_expQ4 b e f;; 
let _ = g#value;;               (* 25 *)
let _ = g#applyX 1          
let _ = g#value;;               (* 42 *)

