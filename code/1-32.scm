#lang racket

(define (accumulate combiner null-value term a next b)
    (define (iter a)
        (if (> a b)
            null-value
            (combiner (term a) (iter (next a)))))
    (iter a))

(define (accumulate-iter combiner null-value term a next b)
    (define (iter ans a)
        (if (> a b)
            ans
            (iter (combiner (term a) ans) (next a))))
    (iter null-value a))

(define (id x) x)
(define (inc x) (+ x 1))

(define (sum term a next b) (accumulate-iter + 0 term a next b))
(define (sum-int a b) (sum id a inc b))

(define (product term a next b) (accumulate-iter * 1 term a next b))
(define (product-int a b) (product id a inc b))

(sum-int 1 10)
(product-int 1 10)
