#lang racket

(require "felix.scm")

(define (horner-eval x coeff-seq)
    (accumulate 
        (lambda (a ans)
            (+ (* ans x) a))
        0
        coeff-seq))

(horner-eval 3 '(1 3 2)) ;f(x) = 2x^2+3x+1, f(3) = 28

(horner-eval 2 '(1 3 0 5 0 1)) ; 79
