#lang racket

(require "huffman.scm")

(define sample-tree
    (make-code-tree
        (make-leaf 'A 4)
        (make-code-tree
            (make-leaf 'B 2)
            (make-code-tree
                (make-leaf 'D 1)
                (make-leaf 'C 1)))))
sample-tree
; 0: A 0
; 1
;   0: B 10
;   1
;     0: D 110
;     1: C 111

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))
                        ;A     D A   B   B C     A
(decode sample-message sample-tree)
