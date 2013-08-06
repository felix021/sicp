#lang racket

(provide 
    quicksort
    merge-lst
    mergesort
    )

(define (quicksort lst cmp)
    (if (<= (length lst) 1)
        lst
        (let*
            ((x (car lst))
             (rest (cdr lst))
             (smaller (filter (lambda (t) (cmp t x)) rest))
             (larger (filter (lambda (t) (not (cmp t x))) rest)))
            (append
                (sort smaller cmp)
                (list x)
                (sort larger cmp)))))

;(quicksort '(1 9 8 2 0 7 3 6 4 5) <)

(define (merge-lst s1 s2 cmp)
    (cond
        ((null? s1) s2)
        ((null? s2) s1)
        (else (let ((x (car s1)) (y (car s2)))
            (cond
                ((cmp x y) (cons x (merge-lst (cdr s1) s2 cmp)))
                ((not (cmp x y)) (cons y (merge-lst s1 (cdr s2) cmp)))
                (else (cons x (merge-lst (cdr s1) (cdr s2) cmp))))))))

;(merge-lst '(1 2 3 5 7 9 10) '(1 2 4 6 8 10) <)

(define (mergesort lst cmp)
    (if (<= (length lst) 1)
        lst
        (letrec
            ((n (length lst))
             (left-size (quotient n 2))
             (left (take lst left-size))
             (right (drop lst left-size)))
            (merge-lst
                (mergesort left cmp)
                (mergesort right cmp)
                cmp))))

;(mergesort '(1 9 8 2 0 7 3 6 4 5) >)
