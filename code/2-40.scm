#lang racket

(require "felix.scm")
(require "primes.scm")

(provide uniq-pairs)

(define (uniq-pairs n)
    (flatmap 
        (lambda (i)
            (map (lambda (j) (list i j))
                (range 1 (- i 1) 1)))
        (range 1 n 1)))

;(uniq-pairs 6)

(define (prime-pair? p) (is-prime? (+ (car p) (cadr p))))

(define (make-ans p) (list (car p) (cadr p) (accumulate + 0 p)))

(define prime-sum-pair
    (lambda (n)
        (map make-ans
            (filter prime-pair?
                (uniq-pairs n)))))

;(prime-sum-pair 6)
