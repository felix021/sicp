#lang racket

(require "fermat.scm")

(define (fermat-test-all n)
    (define (iter i)
        (cond
            ((= i n) #t)
            ((= (expmod i n n) i) (iter (+ i 1)))
            (else (display n) (display " fails at: ") (display i) (newline) #f)))
    (iter 2))


(fermat-test-all 65537)
(fermat-test-all 99400891) ;9973*9967
(fermat-test-all 561)
(fermat-test-all 1105)
(fermat-test-all 1729)
(fermat-test-all 2465)
(fermat-test-all 2821)
(fermat-test-all 6601)
