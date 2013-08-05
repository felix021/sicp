#lang racket

(define (even? n) (= (remainder n 2) 0))

(define (mod-fast-iter x n m)
    (define (iter a b n)
        (cond ((= n 0) a)
              ((even? n) 
                (iter a (remainder (* b b) m) (/ n 2)))
              (else
                (iter (remainder (* a b) m) (* b b) (/ (- n 1) 2)))))
    (iter 1 x n))

(define (fermat-test n)
    (define (try a) (= (mod-fast-iter a n n) a))
    (try (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
    (cond ((= times 0) #t)
          ((not (fermat-test n)) #f)
          (else (fast-prime? n (- times 1)))))

(define (prime? x)
    (define (iter i)
        (cond ((= i 1) #t)
              ((= (remainder x i) 0) #f)
              (else (iter (- i 1)))))
    (iter (floor (sqrt x))))

(define (next-odd x)
    (if (= (remainder x 2) 0) (+ 1 x) (+ 2 x)))

(define (next-prime x)
    (define (iter i)
      (if (prime? i) i (iter (next-odd i))))
    (iter (next-odd x)))

(define (next-prime-fast x)
    (define (iter i)
      (if (fast-prime? i 5) i (iter (next-odd i))))
    (iter (next-odd x)))

(define (next-n-prime x n) 
    (define (iter x n)
        (cond ((= n 0) (display "are primes") (newline))
              (else 
                (display x) 
                (display " ") 
                (iter (next-prime x) (- n 1)))))
    (iter (next-prime x) n))

(time (next-n-prime 100000 3))
(time (next-n-prime 1000000 3))
(time (next-n-prime 10000000 3))
(time (next-n-prime 100000000 3))
