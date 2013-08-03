#lang racket

(define (is-prime? x)
    (define m (floor (sqrt x)))
    (define (iter t)
        (cond ((= t m) #t)
              ((= (remainder x t) 0) #f)
              (else (iter (+ t 1) ))))
    (iter 2))

;(is-prime? 65537)
