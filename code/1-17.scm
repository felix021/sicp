#lang racket

(define (* a b)
    (if (= b 0)
        0
        (+ a (* a (- b 1)))))

(* 3 5)

(define (even? a) (= (remainder a 2) 0))
(define (double a) (+ a a))
(define (half a) (floor (/ a 2)))

(define (fast* x n)
    (cond ((= n 0) 0)
          ((even? n) (double (fast* x (half n))))
          (else (+ x (double (fast* x (half (- n 1))))))))
    
(fast* 3 5)

(define (*iter a n)
    (define (iter a b n)
        (cond ((= n 0) a)
              ((even? n) (iter a (double b) (half n)))
              (else (iter (+ a b) b (- n 1)))))
    (iter 0 a n))
(*iter 3 5)
