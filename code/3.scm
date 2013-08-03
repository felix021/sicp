#lang racket
(define (factorial n) (if (= n 1) 1 (* n (factorial (- n 1)))))
(define (fact1 n)
  (define (fact-iter n x product) 
    (if (> x n) product (fact-iter n (+ x 1) (* product x))))
  (fact-iter n 1 1))

(factorial 3)
(factorial 6)
(factorial 7)
(fact1 3)
(fact1 6)
(fact1 7)
