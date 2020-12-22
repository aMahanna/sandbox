#lang scheme
(define choices '(("marie" ("peru" "greece" "vietnam"))
 ("jean" ("greece" "peru" "vietnam"))
 ("sasha" ("vietnam" "peru" "greece"))
 ("helena" ("peru" "vietnam" "greece"))
 ("emma" ("greece" "peru" "vietnam"))
 ("jane" ("greece" "vietnam" "peru"))))


; Main function, turns "choices" list into a list of countries by using map and lambda (we remove the names)
; We then pass that new country list to the handler 
; Example of what the country list would look like:
; (("peru" "greece" "vietnam") ("greece" "vietnam" "peru") ("vietnam" "greece" "peru") ("vietnam" "peru" "greece") ("greece" "vietnam" "peru"))
(define (destination L)
  (cond
    ((null? L) L)
   (else (handler (map (lambda(x) (cadr x)) L)))
  )
)

; handler function, calls helper function (findDestinations)  with new parameters
; Passes CL (Country List), FC (getFirstCountry), SC (getSecondCountry), TC (getThirdCountry)
(define (handler CL) 
  (findDestinations CL (getFirstCountry CL 1) (getSecondCountry CL 1) (getThirdCountry CL 1))
)

; Helper Function
; Evaluates the 7 Possible cases:
; 1) FC Has Most Points
; 2) SC Has Most Points
; 3) TC Has Most Points
; 4) FC = SC = TC
; 5) (FC = SC) > TC
; 6) (SC = TC) > FC
; 7) (FC = TC) > SC
; Returns a constructed list with the country name and the number of points the country received
(define (findDestinations CL FC SC TC)
  
  (let ((f (run CL FC)) ; f = number of points for country FC
        (s (run CL SC)) ; s = number of points for country SC
        (t (run CL TC))); t = number of points for country TC
    (cond
      ((and (> f s) (> f t)) (cons FC f)) ; FC Has Most Points
      ((and (> s f) (> s t)) (cons SC s)) ; SC Has Most Points
      ((and (> t f) (> t s)) (cons TC t)) ; TC Has Most Points
      ((and (equal? f s) (equal? s t)) (cons (cons FC f) (cons (cons SC s) (list (cons TC t))))) ; FC = SC = TC
      ((equal? f s) (cons (cons FC f) (list (cons SC s)))) ; (FC = SC) > TC
      ((equal? s t) (cons (cons SC s) (list (cons TC t)))) ; (SC = TC) > FC
      ((equal? f t) (cons (cons FC f) (list (cons TC t)))) ; (FC = TC) > SC
    )
   )

    
)
  

; run Function calls count function and passes new integers as parameters (number/points and iterator (i))
(define (run L c)
  (count L c 0 1)
)

; count function returns the number of points (n) associated to country c
(define (count L c n i )
  (cond
    ((equal? (+ 1 (length L)) i) n) ; End of recursion (we scanned through the entire 'choices' list), return n (points)
    ((equal? (getFirstCountry L i) c) (count L c (+ 3 n) (+ 1 i))) ; Add 3 points if country c is first place in preference list
    ((equal? (getSecondCountry L i) c) (count L c (+ 2 n) (+ 1 i))) ; Add 2 points if country c is second place in preference list
    ((equal? (getThirdCountry L i) c) (count L c (+ 1 n) (+ 1 i))) ; Add 1 points if country c is third place in preference list
   )
)

; Returns the first country of the sub-list i of parent-list L
; Ex:
; If L = (("a" "b" "c") ("d" "e" "f") ("g" "h" "i") ("j" "k" "l") ("m" "n" "o")), then
; (getFirstCountry L 3) returns "g"
(define (getFirstCountry L i)
  (car (getNth L i))
)

; Returns the second country of the sub-list i of parent-list L
; Ex:
; If L = (("a" "b" "c") ("d" "e" "f") ("g" "h" "i") ("j" "k" "l") ("m" "n" "o")), then
; (getSecondCountry L 3) returns "h"
(define (getSecondCountry L i) 
  (cadr (getNth L i))
)

; Returns the third country of the sub-list i of parent-list L
; Ex:
; If L = (("a" "b" "c") ("d" "e" "f") ("g" "h" "i") ("j" "k" "l") ("m" "n" "o")), then
; (getThirdCountry L 3) returns "i"
(define (getThirdCountry L i)
  (caddr (getNth L i))
)

; Returns the iTH sub-list
; Ex:
; If L = (("a" "b" "c") ("d" "e" "f") ("g" "h" "i") ("j" "k" "l") ("m" "n" "o"))
; (getNth L 4) returns ("j" "k" "l")
(define (getNth L i)
  (cond
    ((equal? 1 i) (car L))
    (else (getNth (cdr L) (- i 1)))
  )
)
