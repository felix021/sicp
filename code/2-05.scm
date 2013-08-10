#lang racket

(define (cons a b) (* (expt 2 a) (expt 3 b)))

(define (exp-of e p)
    (define (iter x ans)
        (if (= (remainder x e) 0)
            (iter (/ x e) (+ ans 1))
            ans))
    (iter p 0))

(define (car p) (exp-of 2 p))
(define (cdr p) (exp-of 3 p))

(define p (cons 4 6))
p
(car p)
(cdr p)
