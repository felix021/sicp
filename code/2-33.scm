#lang racket

(require "felix.scm")

(define (map p sequence)
    (accumulate (lambda (x y) (cons(p x)  y)) '() sequence))

(map square '(1 2 3 4 5))

(define (my-append seq1 seq2)
    (accumulate cons seq2 seq1))

(my-append '(1 2 3) '(4 5 6))

(define (my-length sequence)
    (accumulate (lambda (x y) (inc y)) 0 sequence))

(my-length '(1 2 3 4 5))

