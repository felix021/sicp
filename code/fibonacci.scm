#lang racket
(define (fibonacci n)
    (if (< n 2)
        1
        (+ (fibonacci (- n 1)) (fibonacci (- n 2)))))
(fibonacci 10)

(define (fibo n)
    (define (fibo-inter i a b)
        (if (= i n) 
            b
            (fibo-inter (+ 1 i) b (+ a b))))
    (fibo-inter 1 1 1))
(fibo 10)
