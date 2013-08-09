#lang racket

(define (double x) (+ x x))
(define (half x) (/ x 2))

(define (mul a b)
    (cond
        ((= b 0) 0)
        ((even? b) (double (mul a (half b))))
        ((odd? b) (+ a (mul a (- b 1))))))

(mul 3 5)
(mul 21 12)

(define (fast-mul a b)
    (define (iter ans t x)
        (cond
            ((= x 0) ans)
            ((odd? x)
                (iter (+ ans t) t (- x 1)))
            ((even? x)
                (iter ans (+ t t) (half x)))))
    (iter 0 a b))

(fast-mul 3 5)
(fast-mul 21 12)
        
