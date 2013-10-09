(include "3.5.5.scm")

(define rand-max 2147483648.0)

(define float-random-numbers
    (stream-map (lambda (x) (/ x rand-max)) random-numbers))

(define (estimate-integral p? x1 x2 y1 y2)
    (monte-carlo
        (map-successive-pairs 
            (lambda (x y)
                (let ((xx (+ (* x (- x2 x1)) x1))
                      (yy (+ (* y (- y2 y1)) y1)))
                    (p? xx yy)))
            float-random-numbers)
        0 0))

(define radius 0.5)
    
(define (in-circle-test x y)
  (<
    (+ (square (- x radius))
       (square (- y radius)))
    (square radius)))

(define pi-stream
    (stream-map
        (lambda (x) (/ x (square radius)))
        (estimate-integral in-circle-test 0.0 1.0 0.0 1.0)))

(display (stream-ref pi-stream 10000))
