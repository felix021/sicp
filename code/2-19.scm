#lang racket

;;   cc(amount, [a, b, c, d, e])
;; = cc(amount, [b, c, d, e])
;; + cc(amount - a, [a, b, c, d, e])

(define us-coins '(50 25 10 5 1))
(define uk-coins '(100 50 20 10 5 2 1 0.5))

(define (no-more? coin-values) (null? coin-values))
(define (first-denomination coin-values) (car coin-values))
(define (except-first-denomination coin-values) (cdr coin-values))

(define (cc amount coin-values)
    (cond
        ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
            (+
                (cc amount (except-first-denomination coin-values))
                (cc (- amount (first-denomination coin-values)) coin-values)))))

(cc 100 us-coins)
(cc 100 '(1 5 10 25 50))
(cc 100 uk-coins)
