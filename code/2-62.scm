#lang racket

(define (union-set s1 s2)
    (cond
        ((null? s1) s2)
        ((null? s2) s1)
        (else (let ((x (car s1)) (y (car s2)))
            (cond
                ((= x y) (cons x (union-set (cdr s1) (cdr s2))))
                ((< x y) (cons x (union-set (cdr s1) s2)))
                ((> x y) (cons y (union-set s1 (cdr s2)))))))))

(union-set '() '())
(union-set '(1 2 3) '())
(union-set '() '(1 2 3))
(union-set '(1 2 3 4 5) '(1 2 3 4 5))
(union-set '(1 3 5 7 9) '(0 2 4 6 8))
(union-set '(5 6 7 8) '(1 2 3 4))
(union-set '(1 3 5 7 9) '(1 2 4 6 8 9))
