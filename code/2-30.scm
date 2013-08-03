#lang racket

(define (square x) (* x x))

(define (square-tree1 tree)
    (cond 
        ((null? tree) '())
        ((not (pair? tree)) (square tree))
        (else 
            (cons 
                (square-tree1 (car tree))
                (square-tree1 (cdr tree))))))

(square-tree1 '(1 2 (3 4 (5 6))))

(define (square-tree2 tree)
    (if (not (pair? tree))
        (square tree)
        (map square-tree2 tree)))
(square-tree2 '(1 2 (3 4 (5 6))))

(define (square-tree3 tree)
    (map
        (lambda (x)
            (if (not (pair? x))
                (square x)
                (square-tree3 x)))
        tree))
(square-tree3 '(1 2 (3 4 (5 6))))
