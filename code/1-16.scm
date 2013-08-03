#lang racket

(define (expt x n) (if (= 0 n) 1 (* x (expt x (- n 1)))))

(define (expt-iter x n) 
    (define (iter i ans)
        (if (= i n) ans (iter (+ 1 i) (* x ans))))
    (iter 0 1))

(define (even? x) (= (remainder x 2) 0))
(define (square x) (* x x))

(define (expt-fast x n)
    (if (= n 0) 
        1
        (if (even? n)
            (square (expt-fast x (/ n 2)))
            (* x (square (expt-fast x (/ (- n 1) 2)))))))

(define (expt-fast-iter x n)
    (define (iter ans b n)
        (cond ((= n 0) ans)
              ((even? n) (iter ans (square b) (/ n 2)))
              (else      (iter (* ans b) b (- n 1)))))
    (iter 1 x n))
        

(expt 2 100)
(expt-iter 2 100)
(expt-fast 2 100)
(expt-fast-iter 2 100)

;(expt-fast 2 77)
;(expt-fast-iter 2 77)
