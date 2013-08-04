#lang racket

(require "2-38.scm")


(define (reverse1 lst)
    (fold-left (lambda (x y) (cons y x)) '() lst))

(define (reverse2 lst)
    (fold-right (lambda (x y) (append y (list x))) '() lst))

(reverse1 '(1 2 3 4 5))
(reverse2 '(1 2 3 4 5))
