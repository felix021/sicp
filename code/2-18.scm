#lang racket

(define (reverse-list L)
    (define (iter result remain)
        (if (null? remain)
            result
            (iter (cons (car remain) result) (cdr remain))))
    (iter '() L))

(reverse-list '(1 2 3 4 5))
(reverse '(1 2 3 4 5))
