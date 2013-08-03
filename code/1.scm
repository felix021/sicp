#lang racket
(define eps 1e-10)
(define (diff x y) (abs (- x y)))
(define (cubic x) (* x x x))
(define (improve y x) (/ (+ (/ x (* y y)) (* 2 y)) 3))
(define (sqrt3-iter y pre x)
    (if (< (diff y pre) eps)
        y
        (sqrt3-iter (improve y x) y x)
    )
)
(define (sqrt3 x) (sqrt3-iter 1.0 0 x))
(sqrt3 27)


