#lang racket

(define (deep-reverse L)
    (if (pair? L)
        (reverse (map deep-reverse L))
        L))

(deep-reverse '((1 2) (3 4) ((5 6) ((7 8 9) (10 11 12 13)))))
