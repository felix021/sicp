#lang racket
(define (fibonacci n)
  (define (iter n a b)
    (if (= n 0) b (iter (- n 1) (+ a b) a)))
  (iter n 1 0)) 

(define (even? n) (= (remainder n 2) 0))
(define (fibo-fast n)
    (define (iter a b p q n)
        (cond ((= n 0) b)
              ((even? n)
                (iter 
                    a
                    b
                    (+ (* p p) (* q q))
                    (+ (* 2 p q) (* q q))
                    (/ n 2)))
              (else
                (iter
                    (+ (* a (+ p q)) (* b q))
                    (+ (* a q) (* b p))
                    p
                    q
                    (- n 1)))))
    (iter 1 0 0 1 n))

(fibonacci 300000)
;(fibo-fast 300000)
