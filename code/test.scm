#lang racket

(define (sum . z)
    (define (iter ans L)
        (if (null? L)
            ans
            (iter (+ ans (car L)) (cdr L))))
    (iter 0 z))

(sum 1 2 3)

