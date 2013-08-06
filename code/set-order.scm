#lang racket

(define (element-of-set? x set)
    (cond
        ((null? set) #f)
        ((= x (car set)) #t)
        ((< x (car set)) #f)
        (else (element-of-set? x (cdr set)))))

(element-of-set? 3 '(1 2 3 4 5))
(element-of-set? 3 '(1 2 4 5))

(define (adjoin-set x set)
    (if (null? set)
        (list x)
        (let ((p (car set)))
            (cond
                ((= x p) set)
                ((< x p) (cons x set))
                ((> x p) (cons p (adjoin-set x (cdr set))))))))

(adjoin-set 3 '(1 2 3 4 5))
(adjoin-set 3 '(1 2 4 5))
(adjoin-set 0 '(1 2 3 4 5))
(adjoin-set 6 '(1 2 3 4 5))

(define (intersection-set s1 s2)
    (if (or (null? s1) (null? s2))
        '()
        (let
            ((x (car s1))
             (y (car s2)))
            (cond
                ((= x y) (cons x (intersection-set (cdr s1) (cdr s2))))
                ((< x y) (intersection-set (cdr s1) s2))
                ((> x y) (intersection-set s1 (cdr s2)))))))

(intersection-set '(1 3 5 6 7 8) '(1 3 4 5 6 7))
(intersection-set '(2 4 6 8) '(1 3 5 7))

(define (union-set s1 s2)
    (cond
        ((null? s1) s2)
        ((null? s2) s1)
        (else (let ((x (car s1)) (y (car s2)))
            (cond
                ((= x y) (cons x (union-set (cdr s1) (cdr s2))))
                ((< x y) (cons x (union-set (cdr s1) s2)))
                ((> x y) (cons y (union-set s1 (cdr s2)))))))))

(union-set '(1 3 5 7 9) '(1 2 4 6 8 9))
