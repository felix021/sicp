#lang racket

(require "felix.scm")
(require "primes.scm")

(filter (lambda (x) (is-prime? (+ (car x) (cadr x))))
    (accumulate 
        append
        '()
        (map
            (lambda (i)
                (map (lambda (j) (list i j))
                     (range 1 (- i 1) 1)))
            (range 1 6 1))))
