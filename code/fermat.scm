#lang racket

(define (square a) (* a a))

(define (expmod a m n)
    (cond ((= m 0) 1)
          ((even? m) (remainder 
                        (square (expmod a (/ m 2) n))
                        n))
          (else (remainder 
                    (* a (expmod a (- m 1) n))
                    n))))

(define (fermat-test n)
    (define a (+ 1 (random (- n 1))))
    (= (expmod a n n) a))

(define (fast-prime? n ntime)
    (cond ((= ntime 0) #t)
          ((fermat-test n) (fast-prime? n (- ntime 1)))
          (else #f)))

;(fermat-test 65537)
(fast-prime? 65537 10)
(fast-prime? 99400891 10) ;9973*9967
(fast-prime? 193707721 10)
