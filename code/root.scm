#lang racket

(define (root f a b)
    (let ((x (/ (+ a b) 2.0)))
        (cond ((< (- b a) 0.001) x)
              ((< (* (f x) (f a)) 0) (root f a x))
              (else (root f x b)))))

(define (f x) (- (* x x) 10))


(f (root f 0 100.0))
(root sin 2.0 4.0)
(root (lambda (x) (- (* x x x) (* 2 x) 3)) 1.0 2.0)

