#lang racket

(define (smallest-divisor x)
    (define (iter d)
        (if (= (remainder x d) 0)
            d
            (iter (+ 1 d))))
    (iter 2))

(smallest-divisor 199)
(smallest-divisor 1999)
(smallest-divisor 19999)
