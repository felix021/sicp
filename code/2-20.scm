#lang racket

(define (f x y . z)
    (display x)
    (display ", ")
    (display y)
    (display ", ")
    (display z)
    (newline))

(f 1 2 3 4 5 6)

(define (g . w)
    (display w) (newline))

(g 1 2 3 4 5 6)

(define (filter op args)
    (cond
        ((null? args) '())
        ((op (car args)) (cons (car args) (filter op (cdr args))))
        (else (filter op (cdr args)))))

(define (same-parity? x . args)
    (cons x (filter (if (even? x) even? odd?) args)))

(same-parity? 1 2 3 4 5 6 7)
(same-parity? 2 3 4 5 6 7)

(define x (lambda args (display args) (newline)))

(x 1 2 3 4 5 6)
