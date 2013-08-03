#lang racket

(define (fibo-iter a b p q n)
    (cond ((= n 0) b)
          ((even? n)
            (fibo-iter 
                a
                b 
                (+ (* p p) (* q q))   ;p'
                (+ (* 2 p q) (* q q)) ;q'
                (/ n 2)))
          (else 
            (fibo-iter 
                (+ (* a (+ p q)) (* b q)) 
                (+ (* a q) (* b p))
                p
                q
                (- n 1)))))

(define (fibo-fast n)
    (fibo-iter 1 0 0 1 n))

(define (fibo n)
    (define (iter i a b) (if (= i 0) a (iter (- i 1) b (+ a b))))
    (iter n 0 1))

(fibo 1)
(fibo 2)
(fibo 3)
(fibo 4)
(fibo 5)
(fibo 1024)
(fibo-fast 1024)
;(fibo-fast 300000)
