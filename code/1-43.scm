#lang racket

(define (repeated f n)
    (define (iter i ans)
        (if (= i 0)
            ans
            (iter (- i 1) (lambda (x) (f (ans x))))))
    (iter (- n 1) f))


((repeated (lambda (x) (+ x 1)) 3) 5)
