#lang scheme
(define (changeList L) 
  (cond
    ((null? L) '()) ; return empty list if list is null
    (else
     ; first, apply filter (return a list with no numbers in between -1 and 1)
     ; second apply map (return list with modified values)
     (map helper (filter (lambda(x) (> (abs x) 1)) L)))
   )
)

(define (helper x)
  (cond
    ((> x 1) (* 10 x)) ; Multiply x by 10 if bigger than 1
    ((< x -1) (/ 1 (* x -1))) ; If x < -1, return 1/(-x)  
    (else x) ; Else, return x (this never happens because of our lambda filter function)
  )
)
