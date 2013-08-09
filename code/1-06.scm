#lang racket

(define (new-if predicate then-clause else-clause)
    (cond (predicate then-clause)
          (else else-clause)))

(new-if (= 2 3) 0 5)
(new-if (= 1 1) 0 5)

(define (good-enough? guess x)
    (< (abs (- (* guess guess) x)) 0.00001))
    
(define (improve guess x)
    (/ (+ guess (/ x guess)) 2.0))

(define (sqrt-iter guess x)
    (new-if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)))

(sqrt-iter 1.0 5) ; this will loop forever
