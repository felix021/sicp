#lang racket

(define (iterative-improve good-enough? improve)
    (define (iter x)
        (if (good-enough? x)
            x
            (iter (improve x))))
    iter)

(define (sqrt x)
    (define tolerance 0.000001)
    (define (good-enough? y)
        (< (abs (- x (* y y))) tolerance))
    (define (improve y)
        (/ (+ y (/ x y)) 2.0))
    ((iterative-improve good-enough? improve) 1.0))

(sqrt 5)

(define (fixed-point f guess)
    (define tolerance 0.000001)
    (define (diff a b) (abs (- a b)))
    (define (good-enough? x)
        (< (diff x (f x)) tolerance))
    (define (improve x) (f x))
    ((iterative-improve good-enough? improve) guess))

(fixed-point cos 1.0)
(fixed-point (lambda (x) (+ (sin x) (cos x))) 1.0)

(define (average-damp f) (lambda (x) (/ (+ x (f x)) 2.0)))

(define (sqrt1 x)
    (fixed-point (average-damp (lambda (y) (/ x y))) 1.0))
(sqrt1 5)
