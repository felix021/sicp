#lang racket

(define (double f) (lambda (x) (f (f x))))

(((double (double double)) (lambda (x) (+ x 1))) 5)
