(load "gfelix.scm")

(define (sum-primes a b)
    (define (iter count accum)
        (cond
            ((> count b) accum)
            ((prime? count) (iter (+ count 1) (+ count accum)))
            (else (iter (+ count 1) accum))))
    (iter a 0))

(display (sum-primes 2 19)) (newline)

(define (sum-primes-acc a b)
    (accumulate 
        + 0 (filter prime? (range a b 1))))

(display (sum-primes-acc 2 19)) (newline)
