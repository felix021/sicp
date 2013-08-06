#lang racket

(require "felix.scm")

(define (safe? solution)
    ;(display solution) (newline)
    (let ((p (car solution)))
        (define (conflict? q i)
            (or
                (= p q)
                (= p (+ q i))
                (= p (- q i))))
        (define (check rest i)
            (cond 
                ((null? rest) #t)
                ((conflict? (car rest) i) #f)
                (else (check (cdr rest) (inc i)))))
        (check (cdr solution) 1)))

(define (n-queen n)
    (let ((n-cols (range 1 n 1)))
        (define (queen-cols k)
            (if (= k 0)
                (list '())
                (filter
                    (lambda (solution) (safe? solution))
                    (let ((sub-solutions (queen-cols (dec k))))
                        (flatmap
                            (lambda (new-queen)
                                (map 
                                    (lambda (solution)
                                        (cons new-queen solution))
                                    sub-solutions))
                            n-cols)))))
        (queen-cols n)))

(length (n-queen 11))
