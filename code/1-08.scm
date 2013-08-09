#lang racket

(define tolerance 0.000001)
(define (diff a b) (abs (- a b)))

(define (cubr x)
    (define (good-enough? g)
        (< (diff (* g g g) x) tolerance))

    (define (improve g)
        (/
            (+ (/ x (* g g)) (* 2 g))
            3))

    (define (iter guess)
        (if (good-enough? guess)
            guess
            (iter (improve guess))))

    (iter 1.0))

(cubr 0.001)
(cubr 8)
(cubr 27)
(cubr 64)
