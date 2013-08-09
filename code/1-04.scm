#lang racket

(define (a-plus-abs-b a b)
    ((if (> b 0) + -)
     a
     b))

(a-plus-abs-b 1 3)
(a-plus-abs-b 1 -3)
