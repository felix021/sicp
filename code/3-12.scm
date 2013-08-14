; racket don't provide set-car!/set-cdr! directly:
; therefore from now on, I'll switch to guile.

(define (append x y)
    (if (null? x)
        y
        (cons (car x) (append (cdr x) y))))

#| 
; this function is provided by Guile
(define (last-pair x)
    (if (null? (cdr x))
        x
        (last-pair (cdr x))))
|#

(define (append! x y)
    (set-cdr! (last-pair x) y)
    x)

(define x '(a b))
(define y '(c d))

(define z (append x y))
(display z) (newline) ;; (a b c d)
(display (cdr x)) (newline) ; (b)

(define w (append! x y))
(display z) (newline) ;; (a b c d)
(display (cdr x)) (newline) ;; (b c d)
