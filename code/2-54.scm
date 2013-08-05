#lang racket

(require "felix.scm")

(define (equal? x y)
    (cond 
        ((eq? x y) #t)
        ((and (pair? x) (pair? y))
            (and 
                (eq? (car x) (car y))
                (equal? (cdr x) (cdr y))))
        (else #f)))

(equal? '(1 2 3) '(1 2 3))
(equal? '(1 2 3) '(1 2 3 4))
(equal? '(this is a list) '(this is a list))
(equal? '(this is a list) '(this (is a) list))
