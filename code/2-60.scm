#lang racket

(define (element-of-set? x set)
    (cond
        ((null? set) #f)
        ((= x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

(element-of-set? 3 '(1 2 3 4 5))
(element-of-set? 3 '(1 2 4 5))
            
(define (adjoin-set x set)
    (cons x set))

(adjoin-set 3 '(1 2 3 4 5))
(adjoin-set 3 '(1 2 4 5))

(define (intersection-set s1 s2)
    (cond
        ((or (null? s1) (null? s2)) '())
        ((element-of-set? (car s1) s2)
            (cons (car s1) (intersection-set (cdr s1) s2)))
        (else (intersection-set (cdr s1) s2))))

(intersection-set '(1 2 3 4 5 6 7) '(1 3 5 7))

(define (union-set s1 s2)
    (append s1 s2))

(union-set '(1 2 3 4 5 6 7) '(1 3 5 7))
