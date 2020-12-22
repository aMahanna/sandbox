(define (oneTime liste)
  (if (or (null? liste) (null? (cdr liste)))
   liste ; Return original liste instead of an empty list in  base case
   (let ((lcdr (oneTime (cdr liste))))
     (if (equal? (car liste) (car lcdr))
     lcdr
     (cons (car liste) lcdr)))))