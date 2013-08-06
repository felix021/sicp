#lang racket

(provide 
    make-tree
    entry
    fake-node
    left-branch
    right-branch
    element-of-set?
    adjoin-set)

(define (make-tree entry left right)
    (list entry left right))

(define (entry tree) (car tree))

(define (fake-node x)
    (if (number? x) (make-tree x '() '()) x))

(define (left-branch tree) (fake-node (cadr tree)))

(define (right-branch tree) (fake-node (caddr tree)))

(define (element-of-set? x set)
    ;(display set) (newline)
    (cond
        ((null? set) #f)
        (else 
            (let ((v (entry set)))
                (cond
                    ((= x v) #t)
                    ((< x v) (element-of-set? x (left-branch set)))
                    ((> x v) (element-of-set? x (right-branch set))))))))

;(element-of-set? 3 '())
;(element-of-set? 3 '(3 2 4))
;(element-of-set? 3 '(2 1 3))
;(element-of-set? 3 '(6 (2 1 3) 7))
;(element-of-set? 3 '(6 (2 1 4) 8))

(define (adjoin-set x set)
    (if (null? set) 
        (fake-node x)
        (let ((v (entry set))
              (left (left-branch set))
              (right (right-branch set)))
            (cond
                ((= x v) set)
                ((< x v)
                    (make-tree v (adjoin-set x left) right))
                ((> x v)
                    (make-tree v left (adjoin-set x right)))))))

;(adjoin-set 3 '())
;(adjoin-set 3 '(3 2 4))
;(adjoin-set 3 '(2 1 3))
;(adjoin-set 3 '(6 (2 1 3) 7))
;(adjoin-set 7 '(6 (2 1 4) 8))
