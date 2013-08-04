#lang racket

(provide 
    accumulate
    enumerate-tree
    )

(define (accumulate op init lst)
    (if (null? lst)
        init
        (accumulate op (op init (car lst)) (cdr lst))))

;(accumulate + 0 '(1 2 3 4 5))

(define (enumerate-tree tree)
    (cond
        ((null? tree) '())
        ((not (pair? tree)) (list tree))
        (else 
            (append (enumerate-tree (car tree))
                    (enumerate-tree (cdr tree))))))


(require "felix.scm")
(accumulate + 0
    (map square
        (filter odd?
            (enumerate-tree '(1 (2 3) (4 5 (6 7 8) 9 (10 11)) 12)))))

(define (range start stop)
    (define (iter answer i)
        (if (= i stop)
            answer
            (iter (append answer (list i)) (inc i))))
    (iter '() start))

(require "fast-fibo.scm")
(filter even?
    (map fast-fibo
        (range 0 20)))
