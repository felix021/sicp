#lang racket

(define (smallest-divisor x)
    (define (next d)
        (if (= d 2)
            3
            (+ d 2)))
    (define (iter d)
        (if (= (remainder x d) 0)
            d
            (iter (next d))))
    (iter 2))

(smallest-divisor 199)
(smallest-divisor 1999)
(smallest-divisor 19999)
