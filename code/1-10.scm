#lang racket
(define (A x y)
    (cond ((= y 0) 0)
          ((= x 0) (* 2 y))
          ((= y 1) 2)
          (else (A (- x 1) (A x (- y 1))))))

(A 1 10)
(A 2 4)
(A 3 3)

;(f n) = (A 0 n) = (* 2 n)
(define (f n) (A 0 n))
(f 2)
(f 4)
(f 10)

;(g n) = (A 1 n) = 2^n
(define (g n) (A 1 n))
(g 10)
(g 8)
(g 4)

;(h n) = (A 2 n) = (A 1 (A 2 (- n 1))) = 2^(h (- n 1))
(define (h n) (A 2 n))
(h 3)
(h 4)
