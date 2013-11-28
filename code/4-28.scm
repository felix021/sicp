(define (f x) (lambda (t) (+ x t)))
(define (g f) (lambda (t) (f t)))
(display
 (((g f) 3) 4)
 )

; (g f) =>
;   (lambda (t) (
;       (list 'thunk (lambda (t) (+ x t)) env)
;       t))
