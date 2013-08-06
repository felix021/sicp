#lang racket

(require "felix.scm")
(require "sort.scm")

(define input
    '((8 a) (3 b) (1 c) (1 d) (1 e) (1 f) (1 g) (1 h)))

(define key (lambda (x) (car x)))
(define cmp (lambda (x y) (< (key x) (key y))))

(define (make-tree val left right)
    (list val left right))

(define (my-huffman input)
    (define (iter answer)
        (if (<= (length answer) 1)
            answer
            (let ((a (car answer))
                  (b (cadr answer))
                  (rest (cddr answer)))
                (iter
                    (quicksort
                        (cons
                            (make-tree
                                (+ (key a) (key b))
                                a
                                b)
                            rest)
                        cmp)))))
    (iter (quicksort input cmp)))

(my-huffman input)
