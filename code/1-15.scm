#lang racket

(define (cubic x) (* x x x))

(define (sin x)
    (if (< (abs x) 0.001)
        x
        (- (* 3 (sin (/ x 3))) (* 4 (cubic (sin (/ x 3)))))))

(sin 0.5)
(sin 1.2)
(sin 3.141592653)
