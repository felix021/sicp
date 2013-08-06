#lang racket

(require "felix.scm")
(require "set-tree.scm")

(define (element-of-key-set? x key set)
    ;(display set) (newline)
    (cond
        ((null? set) #f)
        (else 
            (let ((v (key (entry set))))
                (cond
                    ((= x v) #t)
                    ((< x v) (element-of-key-set? x key (left-branch set)))
                    ((> x v) (element-of-key-set? x key (right-branch set))))))))

(element-of-key-set? 3 id '())
(element-of-key-set? 3 id '(3 2 4))
(element-of-key-set? 3 id '(2 1 3))
(element-of-key-set? 3 id '(6 (2 1 3) 7))
(element-of-key-set? 3 id '(6 (2 1 4) 8))

