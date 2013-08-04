#lang racket

(require "felix.scm")
(require "2-40.scm")

(define (valid-lst lst s) (= (accumulate + 0 lst) s))

(define (uniq-triple n)
    (flatmap
        (lambda (i)
            (map (lambda (jk) (cons i jk)) (uniq-pairs (dec i))))
        (range 1 n 1)))

(uniq-triple 6)
                        
(filter (lambda (p) (valid-lst p 8)) (uniq-triple 6))
