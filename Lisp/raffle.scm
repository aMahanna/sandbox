#lang scheme

(define names '("marie" "jean" "claude" "emma" "sam" "tom" "eve" "bob"))

; Fonction InsertAt
; Prend comme paramètre l'élément à insérer, la liste L, ainsi que l'index 
(define (insertAt Elem L Index)
  (cond
    ((null? L) (cons Elem '()))                        ; Si L est nulle, construit une list avec seulement l'élément
    ((>= Index (length L)) (append L (list Elem)))     ; Si l'index est supérieur ou égal à la taille de la liste (ex Index = 20), simplement insérer à la fin
    (else (insertAtAux Elem L Index '()))              ; Sinon, appele à sa fonction auxiliaire 
  )
)

; Fonction insertAtAux
; Prend comme paramètre l'élément à insérer, la liste L, l'index ainsi qu'une liste temporaire TL
(define (insertAtAux Elem L Index TL)       
  (cond
    ((equal? 0 Index) (append TL (cons Elem L)))      ; Si l'index est 0, alors simplement append la liste temporaire avec l'élément en premier et le restant de la liste initiale
    (else (insertAtAux Elem (cdr L) (- Index 1) (append TL (list (car L))))) ; Sinon, appelle récursive avec des nouvelles paramètres. La liste temporaire contient maintenant le (car) de la liste L
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ATTENTION!: Puisqu'on fait (random (- (length L)), le dernier élément ne sera jamais déplacé. 
; Si on veut que "bob" se déplace, on doit utiliser (random (length names) aulieu lorsqu'on appelle insertAt.
; Vous pouvez tester ceci on essayant (shuffle names 20) plein de fois
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Fonction shuffle
(define (shuffle L n)
  (cond
    ((equal? 0 n) L)    ; Si n est 0, on retourne la liste
    ; Sinon, on appelle shuffle mais en insérant le premier élément dans la liste avec un index aléatoire.
    (else (shuffle (insertAt (car L) (cdr L) (random (- (length L) 1))) (- n 1))) 
  )
)

; Fonction first
(define (first n L)
  (cond
    ((null? L) '())       ; L est null
    ((>= n (length L)) L) ; Retourne L si n est plus grand ou égal à la taille de la liste
    (else (firstAux n L '())) ; Sinon, appelle sa fonction auxiliaire
  )
)

; Fonction FirstAux
; FL = "First List" (les éléments qu'on veut)
(define (firstAux n L FL)
  (cond
    ((equal? n 0) FL) ; n est 0, retourne FL
    (else (firstAux (- n 1) (cdr L) (append FL (list (car L))))) ; Sinon, appelle récursive en ajoutant le premier élément de la liste L à notre liste FL
  )
)

; Fonction winner
(define (winner lst n)
 (first n (shuffle lst 20)))



