#lang racket

;(load "prime-test.scm")
(define (is-prime? x)
    (define m (floor (sqrt x)))
    (define (iter t)
        (cond ((= t m) #t)
              ((= (remainder x t) 0) #f)
              (else (iter (+ t 1) ))))
    (iter 2))

(define (find-n-primes x n)
    ;(display "now is ") (display x) (newline)
    (if (= n 0) 
        (display "are primes\n")
        (find-n-primes 
            (+ x 2)
            (cond ((is-prime? x) (display x) (newline) (- n 1))
                  (else n)))))

(define (search-primes n)
    (let ((start-time (runtime)))
         (find-n-primes n 3)
         (- (runtime) start-time)))


;(find-n-primes 1001 10)

(search-primes 1000)
(search-primes 10000)
(search-primes 100000)

