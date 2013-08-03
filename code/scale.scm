#lang racket

(define (scale L factor)
    (if (null? L)
        (list)
        (cons (* (car L) factor) (scale (cdr L) factor))))

(scale (list 1 2 3 4 5) 3)

(define (my-map proc items)
    (if (null? items)
        (list)
        (cons (proc (car items)) (my-map proc (cdr items)))))

(my-map (lambda (x) (* x 10)) (list 1 2 3 4 5))
(map + (list 1 2 3 4 5) (list 2 4 6 8 10))
