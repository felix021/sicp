#lang racket

(define (list-n L n)
    (if (= n 0)
        (car L)
        (list-ref (cdr L) (- n 1))))

(list-n '(1 2 3 4 5) 3)
(list-ref '(1 2 3 4 5) 3)

(define (list-length L)
    (if (null? L)
        0
        (+ 1 (list-length (cdr L)))))

(list-length '(1 2 3 4 5))
(length '(1 2 3 4 5))

(define (append-list L R)
    (if (null? L)
        R
        (cons (car L) (append-list (cdr L) R))))

(append-list '(1 2 3) '(4 5))

