#lang racket

(provide 
    add
    sub
    mul
    div)

(require "getput.scm")
(require "apply-generic.scm")

(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))

