#lang racket

(require "felix.scm")

(define (count-leaves tree)
    (accumulate + 0 (map (lambda (x)
                            (cond ((null? x) 0)
                                  ((not (pair? x)) 1)
                                  (else (count-leaves x)))) tree)))

(count-leaves '(1 2 (3 4) 5 (6 7 8 (9 10) 11) 12))
                     
