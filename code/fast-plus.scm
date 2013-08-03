#lang racket

(define (half x) (/ x 2))
(define (double x) (* x 2))

(define (fast-multi a b)
    (define (iter s t c)
        (if (= c 0)
            s
            (if (even? c)
                (iter s (double t) (half c))
                (iter (+ s t) t (- c 1)))))
    (iter 0 a b))
(fast-multi 15 17)
(fast-multi 12 18)
