#lang racket

(define (product term a next b)
    (if (> a b)
        1
        (* (term a) (product term (next a) next b))))

(define (product-iter term a next b)
    (define (iter ans a)
        (if (> a b)
            ans
            (iter (* (term a) ans) (next a))))
    (iter 1 a))

(define (id x) x)
(define (cube x) (* x x x))
(define (inc x) (+ x 1))

(product id 1 inc 10)

(define (calc-pi n)
    (define (inc2 x) (+ x 2))
    (define (square x) (* x x))
    (* 4.0 
       (/ (* (+ n 1) (product-iter square 2 inc2 (* n 2)))
          (product-iter square 3 inc2 (+ 1 (* n 2))))))

(calc-pi 10000)
