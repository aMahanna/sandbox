
module type RANGE =
sig
  type t
  type e
  val singleton : e -> t
  val range : e -> e -> t
  val sadd : t -> e -> t
  val smult : t -> e -> t
  val bridge : t -> t -> t
  val size : t -> int
  val contains : t -> e -> bool
  val rless : t -> t -> bool option
end

(* An implementation of the RANGE datatype with int as range type and
   pairs representing a range *)
module LoHiPairRange : RANGE with type e = int =
struct
  type e = int
  type t = e * e
  let singleton (i:e) : t = (i,i)
  let range (i:e) (j:e) : t = ((min i j), (max i j))
  let sadd (x:t) (i:e) : t = let (lo,hi) = x in (lo+i,hi+i)
  let smult (x:t) (i:e) : t =
    let (lo, hi) = x in
    if i >= 0 then (lo*i,hi*i)
    else (hi*i,lo*i)
  let bridge (x:t) (y:t) : t =
    let (lx, hx) = x in
    let (ly, hy) = y in
    ((min lx ly), (max hx hy))
  let size (x:t) : int =
    let (lo,hi) = x in
    hi - lo - (-1)
  let contains (x:t) (i:e) : bool =
    let (lo,hi) = x in
    (lo <= i) && (i <= hi)
  let rless (x:t) (y:t) : bool option =
    let (lx, hx) = x in
    let (ly, hy) = y in
    if hx < ly then Some true
    else if hy < lx then Some false
    else None
end

(* Exercise 1: Complete the new implementation of RANGE in the
     ListRange module below.  The part that is already implemented
     should give you enough information to implement the rest.  Add
     some test code to test your implementation. *)
    
(* An implementation of the RANGE datatype with int as range type and
   lists representing a range *)
module ListRange : RANGE with type e = int =
struct
  type e = int
  type t = e list

  (* auxiliary functions *)
  let minmax (l:t) : (e*e) option =
      let rec max (t:t) (e:e) : e =
          match t with
          | [] -> e
          | h::r -> max r h
      in
      match l with
      | [] -> None
      | h::r -> Some (h, (max r h))
  let rec build (i:e) (j:e) : e list =
    if i = j then [j]
    else i :: build (i+1) j
  
  let singleton (i:e) : t = [i]
  let range (i:e) (j:e) : t = build (min i j) (max i j)

  (* TODO Exercise 1: Replace all the code below with correct implementations of the operations. *)
  let sadd (x:t) (i:e) : t = 
    match minmax x with
    | None -> []
    | Some(xmin, xmax) -> build (xmin + i) (xmax + i)

  let smult (x:t) (i:e) : t = 
    match minmax x with
    | None -> []
    | Some(xmin, xmax) -> if (i >= 0) then build (xmin * i) (xmax * i) else build (xmax * i) (xmin * i)

  let bridge (x:t) (y:t) : t = 
    match (minmax x, minmax y) with 
    | (Some _, None) -> x
    | (None, Some _) -> y
    | (None, None) -> []
    | (Some(xmin, xmax), Some(ymin, ymax)) when xmin <= ymin && xmax <= ymax -> range xmin ymax
    | (Some(xmin, xmax), Some(ymin, ymax)) when ymin < xmin && ymax < xmax -> range ymin xmax 
    | (Some(xmin, xmax), Some(ymin, ymax)) when xmin <= ymin && xmax >= ymax -> x
    | (Some(xmin, xmax), Some(ymin, ymax)) when ymin < xmax && ymax > xmax -> y
  
  let size (x:t) : int = 
    match minmax x with
    | None -> 0
    | Some(xmin, xmax) -> xmax - xmin - (-1)

  let contains (x:t) (i:e) : bool = 
    match minmax x with
    | None -> false
    | Some(xmin, xmax) when i >= xmin && i <= xmax -> true
    | Some(xmin, xmax) -> false

  let rless (x:t) (y:t) : bool option = 
    match (minmax x, minmax y) with
    | (Some _, None) -> Some false
    | (None, Some _) -> Some false
    | (None, None) -> None
    | (Some(xmin, xmax), Some(ymin, ymax)) when ymin >= xmin && ymin < xmax  -> None 
    | (Some(xmin, xmax), Some(ymin, ymax)) -> Some (xmax < ymin)
end


(* TODO Exercise 1: Add some test code to test your new implementation. *)
let r = ListRange.range (-4) 6;;
let q = ListRange.sadd r 1;; (* [-3; -2; -1; 0; 1; 2; 3; 4; 5; 6; 7] *)


let p = ListRange.range 7 12;;
let c1 = ListRange.contains p 24;; (* false *)

let w = ListRange.smult r 2;; (* [14; 15; 16; 17; 18; 19; 20; 21; 22; 23; 24] *)
let c2 = ListRange.contains w 24;; (* true *)

let b1 = ListRange.rless r p;; (* true *)

let z = ListRange.range 9 16;;
let b2 = ListRange.rless p z;; (* None *)

let c3 = ListRange.contains q (-4);; (* false *)
let c4 = ListRange.contains q (-3);; (* true *)
let c5 = ListRange.contains q 7;; (* true *)
let c6 = ListRange.contains q 8;; (* false *)

let s = ListRange.size r (* 11 *)

let bridge = ListRange.bridge r z;;
let c7 = ListRange.contains r 8;; (* false *)
let c8 = ListRange.contains z 8;; (* false *)
let c9 = ListRange.contains bridge 8;; (* true *)


(* Exercise 2: Design an imperative version of RANGE.  Do so by
   copying range.mli here and changing the types as necessary.  And
   then copy the implementation of LoHiPairRange and modify the code
   as necessary.  All the operations should remain the same as in the
   functional version.  The singleton and range operations should each
   create a new range.  The sadd and smult operations should modify
   existing ranges. Consider the design choices and design your own
   version of bridge. *)

module type IMP_RANGE =
sig
  type t
  type e
  val singleton : e -> t
  val range : e -> e -> t
  val sadd : t -> e -> unit
  val smult : t -> e -> unit
  val bridge : t -> t -> t
  val size : t -> int
  val contains : t -> e -> bool
  val rless : t -> t -> bool option
end

module ImpLoHiPairRange : IMP_RANGE with type e = int =
struct
  type e = int
  type t = (e * e) ref
  let singleton (i:e) : t = ref (i,i)
  let range (i:e) (j:e) : t = ref ((min i j), (max i j))
  let sadd (x: t) (i:e) : unit = 
    let (lo,hi) = !x in x := (lo+i,hi+i)
  let smult (x:t) (i:e) : unit =  
    let (lo, hi) = !x in
    if i >= 0 then x := (lo*i,hi*i)
    else x := (hi*i,lo*i) 
  let bridge (x:t) (y:t) : t =
    let (lx, hx) = !x in
    let (ly, hy) = !y in
    ref((min lx ly), (max hx hy))
  let size (x:t) : int =
    let (lo,hi) = !x in
    hi - lo - (-1)
  let contains (x:t) (i:e) : bool =
    let (lo,hi) = !x in
    (lo <= i) && (i <= hi)
  let rless (x:t) (y:t) : bool option =
    let (lx, hx) = !x in
    let (ly, hy) = !y in
    if hx < ly then Some true
    else if hy < lx then Some false
    else None
end