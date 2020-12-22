(* The type "marks" is a tuple of 6 floating point numbers.  The first
   3 are marks for 3 assignments.  The next 2 are marks for two term
   tests.  The last one is the mark for the final exam. *)
type marks = float * float * float * float * float * float

(* The type "mark_triple" is a tuple of 3 floating point numbers.  The
   first is the assignment mark for the course.  The second is the
   term test mark for the course.  The third is the mark for the final
   exam. *)
type mark_triple = float * float * float

(* The type "final_grade" is the student's final mark represented as a
   percentage. *)
type final_grade = float

(* The type "letter_grade" represents the student's final mark as it
   will appear on their transcript (A+, A, ...) *)
type letter_grade = string

(* The calculations will involve a student_id and 3 kinds of tuples
   representing 3 different forms of student records. *)
type student_id = int
type st_record1 = student_id * marks
type st_record2 = student_id * mark_triple
type st_record3 = student_id * final_grade * letter_grade

(* Assignment 1 is worth a total of 60 marks, Assignment 2 is worth
   75, and Assignment 3 is worth 40.  Each term test is worth 50 and
   the final exam is marked out of 100. *)
let total_a1 : float = 60.
let total_a2 : float = 75.
let total_a3 : float = 40.
let total_t1 : float = 50.
let total_t2 : float = 50.
let total_exam : float = 100.
let perfect_score : marks = (total_a1,total_a2,total_a3,total_t1,total_t2,total_exam)

(* The marking scheme for the course is that the assignments are worth
   33%, the term tests are worth 33% and the final exam is worth 34%. *)
let assign_percent1 = 33.
let test_percent1 = 33.
let exam_percent1 = 34.

(* The following function may be useful for tranforming a mark to a
   percentage. *)
let out_of_100 (max_marks:float) (actual_marks:float) : float =
  (actual_marks *. 100.) /. max_marks


(* PART A *)
let modify_exam_component (s:st_record1) =
	match s with
	| (sid, (a1,a2,a3,t1,t2,exam)) ->  let modified_score = out_of_100 95. exam in (sid, (a1,a2,a3,t1,t2,modified_score))

(* PART B *)
let map_record_1 (f : float->float->float) (a1,a2,a3,t1,t2,exam) = 
	(f total_a1 a1 +. f total_a2 a2 +. f total_a3 a3, f total_t1 t1 +. f total_t2 t2, f total_exam exam)

let transform_to_record2 (s:st_record1) =
	match s with
	| (sid, (a1,a2,a3,t1,t2,exam)) -> (sid, (a1 +. a2+. a3, t1 +. t2, exam))

(* PART C *)
let map_record_2 (f : float->float->float) (a, t, e) = 
	(f (total_a1 +. total_a2 +. total_a3) a, f (total_t1 +. total_t2) t, f total_exam e) 

let transform_to_percentage (s:st_record2) = 
  match s with
  | (sid, (a, t, e)) -> (sid, map_record_2 out_of_100 (a, t, e))

(* PART D *)
let transform_to_mark (s : st_record2) =
	match s with
  	| (sid, (a, t, e)) -> (sid, (assign_percent1 *. a/.100., test_percent1 *. t/.100., exam_percent1 *. e/.100.))

(* PART E *)
let transform_to_record3 (s:st_record2) = 
	match s with
	| (sid, (a, t, e)) -> let letter_grade = match a +. t +. e with 
											| f when f >= 90. -> "A+"
											| f when f >= 85. -> "A"
											| f when f >= 80. -> "A-"
											| f when f >= 75. -> "B+"
											| f when f >= 70. -> "B"
											| f when f >= 65. -> "C+"
											| f when f >= 60. -> "C"
											| f when f >= 55. -> "D+"
											| f when f >= 50. -> "D"
											| f when f >= 40. -> "E"
											| f when f < 40. -> "F"
							in (sid, a +. t +. e, letter_grade)


let compute_grade (x : st_record1) : st_record3 =
  x |> modify_exam_component
  	|> transform_to_record2
  	|> transform_to_percentage
	|> transform_to_mark
	|> transform_to_record3

(* QUESTION 1.  Define an OCaml function that takes a st_record1, and
   uses a pipeline to do the following operations:

(a) First modify the exam component of each student record.  In the
   input record, each student's mark is out of 100 points.  The
   professor has decided to mark it out of 95 points.  So, if a
   student got 95 on the exam, their mark will be converted to 100.
   If the student got 96, their mark will be converted to 101.05.  If
   the student got 94, their mark will be converted to 98.95, etc.

(b) Next, transform each st_record1 to a st_record2 by calculating
   the total number of marks the student got on the assignment portion
   of the course, the term test component, and the final exam
   component.

(c) Next, modify each of the 3 mark components of st_record2 by
   transforming them to a percentage.

(d) Next, modify each one again by transforming it to the appropriate
   portion allowed by the marking scheme.  For example, if the student
   got 100% on the assignment portion of the course, the 100 in the
   assignment position of the tuple of type student_record2 should be
   replaced by 33, because the assignment portion of the course is
   worth 33% of the total mark.  If the student got 50% on the
   assignment portion, this value should be replaced by half of 33,
   which is 16.5, etc.

(e) Transform the st_record2 that is obtained from step (d) to a
   st_record3, by summing the 3 mark components of the st_record2 and
   using the result to calculate the letter grade using the University
   of Ottawa grading scheme. *)


(* QUESTION 2 *)
(* Define a version of the "display" function on page 18 of the course
   notes on pipelines that works with the data in this lab.  The type
   of the input argument to your version of "display" will be
   "st_record1 list", and you will use your solution to Question 1
   instead of "compute_score".  You will also need to define a new
   version of "compare_score" and "stringify".*)
  
let compare_grade (_,final_grade1,_) (_,final_grade2,_) =
  if final_grade1 < final_grade2 then 1 else if final_grade1 > final_grade2 then -1 else 0

let stringify (s : st_record3) = 
  match s with
  | (sid, g, l) -> string_of_int sid ^ ": " ^ l ^ " (" ^ string_of_float g ^ ")\n"
                   

let display (ss : st_record1 list) : unit =
  ss |> List.map compute_grade
  |> List.sort compare_grade
  |> List.map stringify
  |> List.iter print_string


let t1 : st_record1 = (1001, (60.,75.,40.,50.,50.,95.));;
let t2 : st_record1 = (1002, (60.,75.,40.,50.,50.,96.));;
let t3 : st_record1 = (1003, (60.,75.,40.,50.,50.,94.));;

let _ = display [t1;t2;t3]



