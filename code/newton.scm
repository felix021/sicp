#lang racket

;(define ns (make-base-namespace))
;(load "fixed-point.scm")

(define (fixed-point f x)
    (define tolerance 0.000001)
    (define (close-enough? x y) (< (abs (- x y)) tolerance))
    (define (try t)
        (define v (f t))
        (if (close-enough? t v)
            t
            (try v)))
    (try x))


(define dx 0.00001)

(define (deriv g)
    (lambda (x)
        (/ (- (g (+ x dx)) (g x)) dx)))

(define (newton-transform g)
    (lambda (x) (- x (/ (g x) ((deriv g) x)))))
    
(define (newton-method g guess)
    (fixed-point (newton-transform g) guess))

(newton-method (lambda (x) (+ (* x x x) 2)) 1.0)

(define (cubic a b c)
    (lambda (x)
        (+ (* x x x) (* a x x) (* b x) c)))

(define g (cubic 3 2 5))
(g 0)
(g (newton-method g 1.0))
