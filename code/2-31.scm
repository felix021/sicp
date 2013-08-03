#lang racket

(define square (lambda (x) (* x x)))

(define (tree-map proc tree)
    (if (not (pair? tree))
        (proc tree)
        (map (lambda (x) (tree-map proc x)) tree)))

(define square-tree (lambda (tree) (tree-map square tree)))
(square-tree '(1 2 (3 4 (5 6))))

