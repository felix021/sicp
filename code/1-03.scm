#lang racket

(define (max3 a b c)
    (cond
        ((and (< a b) (< a c)) (+ b c))
        ((and (< b a) (< b c)) (+ a c))
        (else (+ a b))))

(max3 1 2 3) ;5
(max3 2 1 3) ;5
(max3 2 3 1) ;5
(max3 2 2 2) ;4
(max3 2 2 3) ;5
