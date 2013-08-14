(load "3-set.scm")

(define (count-pairs x)
    (define s (make-new-set))
    (define (count t)
        ;(display "t = ") (display t) (display ", s = ") (display s) (newline)
        (cond
            ((not (pair? t)) 0)
            ((in-set? t s) 0)
            (else
                (set! s (adjoint t s))
                (+  1
                    (count (car t))
                    (count (cdr t))))))
    (count x)
    (length s))

(define z1 (cons 'a 'b))
(define z2 (cons z1 z1))
(define z3 '(a b c))
(define z4 (cons 'a z2))
(define z7 (cons z2 z2))
(display (count-pairs z3)) (newline)
(display (count-pairs z4)) (newline)
(display (count-pairs z7)) (newline)

(define c (list 'c))
(define b (cons 'b c))
(define a (cons 'a b))
(set-cdr! c a)
(display (count-pairs a)) (newline)
