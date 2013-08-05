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
    (define (queen-cols k)
        (if (= k 0)
            (list '())
            (filter
                (lambda (solution) (safe? solution))
                (flatmap
                    (lambda (solution)
                        (map 
                            (lambda (new-queen)
                                (cons new-queen solution))
                            (range 1 n 1)))
                    (queen-cols (dec k))))))
    (queen-cols n))

(length (n-queen 11))
