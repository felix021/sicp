#lang racket

(provide 
    element-of-set?
    adjoin-set
    intersection-set)

(define (element-of-set? x set)
    (cond
        ((null? set) #f)
        ((= x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

;(element-of-set? 3 '(1 2 3 4 5))
;(element-of-set? 3 '(1 2 4 5))
            
(define (adjoin-set x set)
    (if (element-of-set? x set)
        set
        (cons x set)))

;(adjoin-set 3 '(1 2 3 4 5))
;(adjoin-set 3 '(1 2 4 5))

(define (intersection-set s1 s2)
    (if (or (null? s1) (null? s2))
        '()
        (if (element-of-set? (car s1) s2)
            (cons (car s1) 
                (intersection-set (cdr s1) s2))
            (intersection-set (cdr s1) s2))))

;(intersection-set '(1 2 3 4 5 6 7) '(1 3 5 7))

;(define (union-set s1 s2)
;    (if (null? s1) 
;        s2
;        (adjoin-set (car s1) (union-set (cdr s1) s2))))
;
;(union-set '(1 2 3 5 7 9) '(1 2 4 6 8 9))
