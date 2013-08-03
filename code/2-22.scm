#lang racket

(define square (lambda (x) (* x x)))

(define (square-list items)
    (define (iter answer remain)
        (if (null? remain)
            answer
            (iter (append answer (list (square (car remain))))
                  (cdr remain))))
    (iter (list) items))

(square-list '(1 2 3 4 5))
