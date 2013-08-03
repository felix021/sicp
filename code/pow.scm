#lang racket

(define (square x) (* x x))

(define (pow x n)
    (if (= n 0)
        1
        (if (even? n)
            (square (pow x (/ n 2)))
            (* x (pow x (- n 1))))))

(define (pow-iter x n)
    (define (iter s t m)
        (if (= m 0)
            s
            (if (even? m)
                (iter s (* t t) (/ m 2))
                (iter (* s t) t (- m 1)))))
    (iter 1 x n))

(pow-iter 3 5)
(pow-iter 11 12)
(pow-iter 13 15)
