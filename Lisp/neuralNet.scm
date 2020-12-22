#lang scheme

(define (sigmoid v)
  (/ 1 (+ 1 (exp (* v -1))))
)

; neuralNodeHelper function to calculate node value
; If size of x is 2, then proceed to create a node that belongs in the Hidden Layer: Z = sigmoid(a0 + x1 * a1 + x2 * a2)
; If size of x is 3, then proceed to create the node that belongs in the Output Layer: T = sigmoid(b0 + z1 * b1 + z2 * b2 + z3 * b3)
(define (neuralNodeHelper L F)
  (lambda (x)
    (cond
      ; X size 2 (size of Input Layer), Call function F (sigmoid) passing (a0 + x1 * a1 + x2 * a2) as a paremeter
      ((equal? (length x) 2)
       (F (+ (car L) (* (cadr L) (car x)) (* (caddr L) (cadr x))))) 

      ; X size 3 (size of Hidden Layer), Call function F (sigmoid) passing (b0 + z1 * b1 + z2 * b2 + z3 * b3) as a paremeter
      ((equal? (length x) 3)
       (F (+ (car L) (* (cadr L) (car x)) (* (caddr L) (cadr x)) (* (cadddr L) (caddr x))))) 
     )
   )
)

; Creates 1 neural node
; Relies on neuralNodeHelper function
; Throws an error if F is not 'sigmoid' (no other function to use) 
(define (neuralNode L F)
  (cond
    ((not (equal? F sigmoid)) (display "error, activation function must only be 'sigmoid'"))
    (else (neuralNodeHelper L F))) 
)


; Create a layer of nodes
; Depending on the size of x, the layer will either only contain 1 node (Output Layer) or have 3 nodes (Hidden Layer)
; WL stands for Weight List 
(define (neuralLayer WL)
  (lambda (x)
    (cond
      ((equal? (length  x) 2) ; x is size 2 (size of Input Layer), proceed to create the Hidden Layer (3 different nodes)
       (cons ((neuralNode (car WL) sigmoid) x) (cons ((neuralNode (cadr WL) sigmoid)x) (list ((neuralNode (caddr WL) sigmoid)x)))))
      ((equal? (length x) 3) ; x is size 3 (size of Hidden Layer), proceed to create the Output Layer (only 1 node)
       ((neuralNode WL sigmoid) x))
    )
  )
)

(define (neuralNet XL)
  (let* ((HL ((neuralLayer '((0.1 0.3 0.4)(0.5 0.8 0.3)(0.7 0.6 0.6))) XL))    ; XL (Input Layer) looks like '(0.5 0.5)
        (OL ((neuralLayer '(0.5 0.3 0.7 0.1)) HL)))                            ; HL (Hidden Layer) looks like '(0.610639233949222 0.740774899182154 0.7858349830425586)
    OL) ; Return OL (Output Layer) 
)

; Main applyNet function
; Relies on recursive helper function to repeat "neuralNet" N times
; Passes N, k = 0, and an empty list as parameters
(define (applyNet N)
  (applyNetHelper N 0 '()))

; Recursive helper function for applyNet
; k is used to compute X1 and X2
; L is the final result
(define (applyNetHelper N k L)
  (cond
    ; If k has reached N, then simply return the list
    ((equal? N k) L)

    ; Else, initialize X1 and X2 using the current k
    ; Construct a list using:
    ; A) the neuralNet value obtained with the current x1 and x2
    ; B) the next recursive call of applyNetHelper with updated parameters (k++)
    (else (let ((x1 (sin (/ (* 2 pi k) N)))
                (x2 (cos (/ (* 2 pi k) N))))
       (cons (neuralNet (cons x1 (list x2))) (applyNetHelper N (+ 1 k) L))))
  )
)