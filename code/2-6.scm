#lang racket

(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
    (lambda (f) (lambda (x) (f ((n f) x)))))

(define one 
    (lambda (f) (lambda (x) (f x))))
(define two 
    (lambda (f) (lambda (x) (f (f x)))))

;(= one (add-1 zero))
;(= two (add-1 one))

(define (val num)
    (define f (lambda (x) (+ x 1)))
    ((num f) 0))


(val zero)
(val one)
(val two)

(define add
    (lambda (m n)
        (lambda (f)
            (lambda (x)
                ((m f) ((n f) x))))))

(val (add one two))
