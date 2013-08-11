#lang racket

(define (make-accumulator start)
    (lambda (gain)
        (set! start (+ start gain))
        start))

(define A (make-accumulator 5))

(A 10) ;15

(A 10) ;25
