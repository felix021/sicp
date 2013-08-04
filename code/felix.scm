#lang racket

(define (reduce proc z)
    (define (iter answer remain)
        (if (null? remain)
            answer
            (iter (proc answer (car remain)) (cdr remain))))
    (iter (car z) (cdr z)))

(define (square x) (* x x))

(define (id x) x)

(define (inc x) (+ x 1))
(define (dec x) (- x 1))

(define (avg . z) (avg-list z))

(define (avg-list z)
    (/ (reduce + z) (length z)))

(define (diff x y) (abs (- x y)))

(define (fixed-point f x)
    (define tolerance 0.000001)
    (define (close-enough? x y) (< (diff x y) tolerance))
    (define (try t)
        (define v (f t))
        (if (close-enough? t v)
            t
            (try v)))
    (try x))

(define (deriv g dx)
    (lambda (x)
        (/ (- (g (+ x dx)) (g x)) dx)))

(define (newton-transform g dx)
    (lambda (x) (- x (/ (g x) ((deriv g dx) x)))))
    
(define (newton-method g guess dx)
    (fixed-point (newton-transform g dx) guess))

(define (accumulate op init lst)
    (if (null? lst)
        init
        (op (car lst)
            (accumulate op init (cdr lst)))))

(define (zip sequences)
    (if (null? (car sequences))
        '()
        (cons (map car sequences) (zip (map cdr sequences)))))

(define (append-one lst item) (append lst (list item)))

(define (range start stop step)
    (if (> start stop)
        '()
        (cons start (range (+ start step) stop step))))

(provide
    reduce
    square
    id
    inc
    dec
    avg
    diff
    fixed-point
    deriv
    newton-transform
    newton-method
    accumulate
    zip
    append-one
    range
    )
