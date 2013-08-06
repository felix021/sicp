#lang racket

(require "huffman.scm")

(provide 
    generate-huffman-tree
)

(define (successive-merge forest)
    (if (= (length forest) 1)
        (car forest)
        (successive-merge
            (adjoin-set
                (make-code-tree
                    (car forest)
                    (cadr forest))
                (cddr forest)))))

(define (generate-huffman-tree pairs)
    (successive-merge (make-leaf-set pairs)))

(define sample-tree 
    (generate-huffman-tree 
        '((A 4) (B 2) (C 1) (D 1))))

;sample-tree

;(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))
                        ;A     D A   B   B C     A
;(decode sample-message sample-tree)
