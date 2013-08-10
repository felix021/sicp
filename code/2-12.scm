#lang racket

(define (make-center-percent center percent)
    (cons center (/ percent 100.0)))

(define (lower-bound x)
    (let ((center (car x)) (percent (cdr x)))
        (- center (* (abs center) percent))))

(define (upper-bound x)
    (let ((center (car x)) (percent (cdr x)))
        (+ center (* (abs center) percent))))

(define x (make-center-percent 1 5))
x
(lower-bound x)
(upper-bound x)

(define y (make-center-percent -1 5))
y
(lower-bound y)
(upper-bound y)
