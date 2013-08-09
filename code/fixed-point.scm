#lang racket

(provide
    fixed-point)

(define (fixed-point f x)
    ;(define (next t v) v)
    (define (next t v) (/ (+ t v) 2.0))
    (define tolerance 0.0000001)
    (define (close-enough? p q) (< (abs (- p q)) tolerance))
    (define (try t)
        (define v (f t))
        (if (close-enough? t v)
            t
            (begin (display t) (newline) (try (next t v)))))
    (try x))

;(fixed-point cos 1.0)
;(fixed-point (lambda (y) (+ (sin y) (cos y))) 1.0)

(define (sqrt x)
    (fixed-point (lambda (y) (/ x y)) 1.0))

;(sqrt 5)

;(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)

;(fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0)
