#lang racket

(require "set-tree.scm")
(require "2-63.scm")
(require "2-64.scm")

(define (union-set s1 s2)
    (cond
        ((null? s1) s2)
        ((null? s2) s1)
        (else (let ((x (car s1)) (y (car s2)))
            (cond
                ((= x y) (cons x (union-set (cdr s1) (cdr s2))))
                ((< x y) (cons x (union-set (cdr s1) s2)))
                ((> x y) (cons y (union-set s1 (cdr s2)))))))))

(define (union-tree set1 set2)
    (letrec
         ((s1 (tree->list set1))
          (s2 (tree->list set2)))
        (list->tree (union-set s1 s2))))

(define tree1 (list->tree '(0 1 3 5 7 9 10)))
(define tree2 (list->tree '(0 1 2 4 6 8 10)))

(union-tree tree1 tree2)

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

(define (intersection-tree set1 set2)
    (letrec
         ((s1 (tree->list set1))
          (s2 (tree->list set2)))
        (list->tree (intersection-set s1 s2))))

(intersection-tree tree1 tree2)

; 是否可以直接在tree上面实现交和并，且保证结果仍是平衡树？
