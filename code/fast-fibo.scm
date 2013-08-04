#lang racket

(define (fast-fibo n)
    (define (iter a b p q cnt)
        (cond 
            ((= cnt 0) b)
            ((even? cnt) (iter 
                            a
                            b
                            (+ (* p p) (* q q))
                            (+ (* 2 p q) (* q q))
                            (/ cnt 2)))
            (else (iter 
                    (+ (* b q) (* a q) (* a p))
                    (+ (* b p) (* a q))
                    p
                    q
                    (- cnt 1)))))
    (iter 1 0 0 1 n))

;(fast-fibo 300000)
(provide fast-fibo)
