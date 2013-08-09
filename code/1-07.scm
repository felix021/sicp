#lang racket

(define (diff a b) (abs (- a b)))

(define tolerance 0.0000001)

(define (good-enough? previous guess)
    (< (/ (diff previous guess) previous) tolerance))

(define (improve guess x)
    (/ (+ guess (/ x guess)) 2))

(define (sqrt-iter guess x)
    (if (good-enough? guess (improve guess x))
        guess
        (sqrt-iter (improve guess x) x)))

(sqrt-iter 1.0 9999999999999999)
(sqrt-iter 1.0 0.00000000009999)
