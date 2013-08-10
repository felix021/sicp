#lang racket

(define (make-rat x y)
    (define g (gcd x y))
    (let ((x (/ x g))
          (y (/ y g)))
        (if (< y 0)
            (cons (- x) (- y))
            (cons x y))))

(make-rat 1 2)
(make-rat -1 2)
(make-rat 1 -2)
(make-rat -1 -2)
