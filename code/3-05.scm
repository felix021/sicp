#lang racket

(require "felix.scm")

(define (estimate-integral p? x1 x2 y1 y2 trials)
    (*
        (*  (- x1 x2)
            (- y1 y2))
        (monte-carlo
            trials
            (lambda ()
                (p?
                    (random-in-range x2 x1)
                    (random-in-range y2 y1))))))

(define radius 0.5)

(define (in-circle-test x y)
  (<
    (+ (square (- x radius))
       (square (- y radius)))
    (square radius)))

(define (estimate-pi trials)
    (/
        (estimate-integral in-circle-test 1.0 0.0 1.0 0.0 trials)
        (square radius)))

(estimate-pi 1000)
(estimate-pi 10000)
(estimate-pi 100000)
(estimate-pi 1000000)
