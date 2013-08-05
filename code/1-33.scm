#lang racket

(define (filtered-acc pred combiner null-value term a next b)
    (define (iter a)
        (cond ((> a b) null-value)
              ((pred (term a)) 
                (combiner (term a) (iter (next a))))
              (else (iter (next a)))))
    (iter a))

(define (accumulate combiner null-value term a next b)
    (define (always-true x) #t)
    (filtered-acc always-true combiner null-value term a next b))

(define (id x) x)
(define (inc x) (+ x 1))

(define (filtered-sum pred term a next b) (filtered-acc pred + 0 term a next b))
(define (filtered-sum-int pred a b) (filtered-sum pred id a inc b))

(require "prime.scm")
(filtered-sum-int prime? 1 10)

