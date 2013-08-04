#lang racket

(require "felix.scm")

(define (flatmap p s)
    (accumulate append '() (map p s)))

(define (remove x s)
    (filter (lambda (i) (not (= x i))) s))

(define (permutation s)
    (if (null? s)
        '(())
        (flatmap 
            (lambda (x)
                (map
                    (lambda (p) (cons x p))
                    (permutation (remove x s))))
            s)))

(permutation '(1 2 3))
                

