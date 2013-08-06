#lang racket

(require "set-tree.scm")

(provide tree->list)

(define tree1 '(7 (3 1 5) (9 () 11)))
(define tree2 '(3 1 (7 5 (9 () 11))))
(define tree3 '(5 (3 1 ()) (9 7 11)))

(define (tree->list-1 tree)
    (if (null? tree)
        '()
        (append 
            (tree->list-1 (left-branch tree))
            (cons (entry tree)
                (tree->list-1 (right-branch tree))))))

;(tree->list-1 tree1); 1 3 5 7 9 11
;(tree->list-1 tree2); 1 3 5 7 9 11
;(tree->list-1 tree3); 1 3 5 7 9 11

(define (tree->list-2 tree)
    (define (copy-to-list tree result-list)
        (if (null? tree)
            result-list
            (copy-to-list
                (left-branch tree)
                (cons (entry tree) 
                      (copy-to-list (right-branch tree) result-list)))))
    (copy-to-list tree '()))

(define tree->list tree->list-2)

;(tree->list-2 tree1); 1 3 5 7 9 11
;(tree->list-2 tree2); 1 3 5 7 9 11
;(tree->list-2 tree3); 1 3 5 7 9 11

;answer a: same. (1 3 5 7 9 11)
;answer b: tree->list-1 is slower, due to the extra copy operation in append
