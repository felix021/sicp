#lang racket

(define (point x y) (lambda (i) (if (= i 0) x y)))
(define (print-point x) (display "(") (display (x 0)) (display ", ") (display (x 1)) (display ")"))

(define (make-seg p q)
    (point p q))

(define (start-seg x) (x 0))
(define (end-seg x) (x 1))

(define (mid-point x)
    (define (avg x y) (/ (+ x y) 2))
    (point 
         (avg ((start-seg x) 0) ((end-seg x) 0)) 
         (avg ((start-seg x) 1) ((end-seg x) 1)) ))

(define (print-seg x)
    (print-point (start-seg x)) 
    (display ", ") 
    (print-point (end-seg x))
    (newline))

(define seg (make-seg (point 1 2) (point 3 4)))
(print-seg seg)
(print-point (mid-point seg))
