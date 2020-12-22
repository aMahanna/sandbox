#lang scheme
; Main function
(define (sameNum L)
  (cond
    ((null? L) '()) ; return empty list if L is null
    ((null? (cdr L)) L) ; return L if (cdr L) is null
    (else
     (helper L '())) ; Call helper function
   )
)

; This function returns the longest sub-list that contains only reoccuring numbers (rL)
(define (helper L rL)
  (cond
    ; return rL if (cdr rL) is null (this is the first way to we get our answer)
    ((equal? (cdr L) '()) rL)
    
    ; If first element not equal to second element in List, move on
    ((not(equal? (car L) (cadr L))) (helper (cdr L) rL))
    
    ; First = Second, rL is empty, construct new rL and call helper again to move on
    ((equal? '() rL) (helper (cdr L) (cons (car L) (list (cadr L)))))
    
    ; rL NOT empty, First = Second = (car rL), increase rL by the same element
    ((equal? (car L) (car rL)) (helper (cdr L) (cons (car L) rL)))
    
    ; First = Second, length of rL is BIGGER than the max number of reoccuring numbers in list L, return rL
    ((> (length rL) (maxRepetion 1 L 1)) rL)

    ; There is still a larger set of reoccuring numbers in L, call helper again and reset rL to '()
    (else (helper L '())) 
   )
)

; This function returns the length of the max possible sub-list containing only reoccuring numbers
(define (maxRepetion n L mN)
  (cond
    ((> n mN) (maxRepetion n L n)) ; if n is bigger than maxN (mN), replace and call function again
    ((null? (cdr L)) mN) ; if (cdr L) is empty, return maxN (mN)
    ((equal? (car L) (cadr L)) (maxRepetion (+ n 1) (cdr L) mN)) ; If First element = second element of list, call function and increment n 
    (else (maxRepetion 1 (cdr L) mN))) ; First element != second element, reset n to 1, but keep mN the same
)