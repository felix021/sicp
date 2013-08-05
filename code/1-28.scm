#lang racket

(define (even? n) (= (remainder n 2) 0))

(define (!= x y) (not (= x y)))

(define (expmod x n m)
    (define (square x) (* x x))
    (cond ((= n 0) 1)
          ((and (!= x 1) (!= x (- m 1)) (= (remainder (* x x) m) 1)) 0)
          ((even? n) (remainder (square (expmod x (/ n 2) m)) m))
          (else (remainder (* x (expmod x (- n 1) m)) m))))

(define (miller-test n)
    (define (do-test a) (= (expmod a (- n 1) n) 1))
    (do-test (+ 1 (random (- n 1)))))

(define (prime? n times)
    (cond ((= times 0) #t)
          ((not (miller-test n)) #f)
          (else (prime? n (- times 1)))))

(miller-test 561)
(prime? 103 5)
