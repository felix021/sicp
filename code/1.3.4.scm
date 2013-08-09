#lang racket

(define (fixed-point f x)
    (define tolerance 0.000001)
    (define (close-enough? x y) (< (abs (- x y)) tolerance))
    (define (try t)
        (define v (f t))
        (if (close-enough? t v)
            t
            (try v)))
    (try x))

(define (average x y) (/ (+ x y) 2.0))

(define (average-damp f) (lambda (x) (average x (f x))))

(define (sqrt-new x)
    (fixed-point (average-damp (lambda (y) (/ x y))) 1.0))

;(sqrt-new 5.0)

(define (cube-root x)
    (fixed-point (average-damp (lambda (y) (/ x (* y y)))) 1.0))

;(cube-root 8.0)
