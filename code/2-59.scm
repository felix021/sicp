#lang racket

(require "set.scm")

(define (union-set s1 s2)
    (if (null? s1) 
        s2
        (adjoin-set (car s1) (union-set (cdr s1) s2))))

(union-set '(1 2 3 5 7 9) '(1 2 4 6 8 9))
