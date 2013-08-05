#lang racket

(define (sum term a next b)
    (if (> a b) 
        0
        (+ (term a) (sum term (next a) next b))))

(define (sum-iter term a next b)
    (define (iter ans a)
        (if (> a b)
            ans
            (iter (+ ans (term a)) (next a))))
    (iter 0 a))

(define (id x) x)
(define (inc x) (+ x 1))
(define (cube x) (* x x x))
(define (sum-int a b) (sum id a inc b))

(define (integral f a b n)
    (define h (/ (- b a) 1.0 n))
    (define (y k) (f (+ a (* k h))))
    (define (inc2 x) (+ x 2))
    (* (/ h 3)
       (+ (f a)
          (* 4 (sum-iter y 1 inc2 (- n 1)))
          (* 2 (sum-iter y 2 inc2 (- n 2)))
          (f b))))

(integral cube 0 1 100)
(integral cube 0 1 1000)
