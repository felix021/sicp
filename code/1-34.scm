#lang racket

(define (square x) (* x x))

(define (f g) (g 2))

(f square)
; (square 2)

(f (lambda (z) (* z (+ z 1))))
; ((lambda (z) (* z (+ z 1))) 2)
; (* 2 (+ 2 1))
; 6

(f f)
; (f 2)
; (2 2)
; --> error[expected procedure, given: 2]
