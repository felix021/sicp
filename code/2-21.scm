#lang racket

(define square (lambda (x) (* x x)))
(define (square-list items)
    (if (null? items)
        (list)
        (cons (square (car items)) (square-list (cdr items)))))

(square-list '(1 2 3 4 5))

(define (square-list-map items)
    (map square items))
(square-list-map '(1 2 3 4 5))
