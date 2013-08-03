#lang racket

(define (smooth f)
    (define dx 0.00001)
    (lambda (x)
        (/ (+ (f (- x dx)) (f x) (f (+ x dx))) 3.0)))
