#lang racket

(require "felix.scm")

(define empty-board '())

(define (safe? solution)

    (let ((p (car solution)))
        (define (conflict? q i)
            (or
                (= p q)
                (= p (+ q i))
                (= p (- q i))))
        (define (check-all rest i)
            (cond 
                ((null? rest) #t)
                ((conflict? (car rest) i) #f)
                (else (check-all (cdr rest) (inc i)))))
        (check-all (cdr solution) 1)))

(define (n-queen n)
    (define n-cols (range 1 n 1))
    (define (queen-cols k)
        (if (= k 0)
            (list empty-board)
            (filter
                (lambda (solution) (safe? solution))
                (let ((sub-solutions (queen-cols (dec k))))
                    (flatmap
                        (lambda (col)
                            (map
                                (lambda (sub-solution)
                                    (cons col sub-solution))
                                sub-solutions)) 
                        n-cols)))))
    (queen-cols n))

(length (n-queen 11))
