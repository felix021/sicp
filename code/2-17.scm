#lang racket

(define (last-elem L)
    (define (iter ans R)
        (if (null? R)
            ans
            (iter (car R) (cdr R))))
    (iter (car L) (cdr L)))

(last-elem '(1 2 3 4 5))

(define (last-pair L)
    (cond ((null? L) (error "empty list"))
          ((null? (cdr L)) L)
          (else (last-pair (cdr L)))))

(last-pair '(1 2 3 4 5))
        
