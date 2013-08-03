;#lang racket 
(define (sqrt x)
    (define (sqrt-inner y)
        (if (< (abs (- x (* y y))) 0.00000000001)
            y
            (sqrt-inner (/ (+ y (/ x y)) 2))))
    (sqrt-inner 1.0))

(display (sqrt 8))
