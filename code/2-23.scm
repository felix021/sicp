#lang racket

(define (foreach proc item)
    (cond ((not (null? item))
        (begin (proc (car item)) (foreach proc (cdr item))))))

(foreach (lambda (x) (display x) (newline)) '(1 2 3 4 5))
(for-each (lambda (x) (display x) (newline)) '(1 2 3 4 5))
