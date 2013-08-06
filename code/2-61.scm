#lang racket

(define (adjoin-set x set)
    (if (null? set)
        (list x)
        (let ((p (car set)))
            (cond
                ((= x p) set)
                ((< x p) (cons x set))
                ((> x p) (cons p (adjoin-set x (cdr set))))))))

(adjoin-set 3 '(1 2 3 4 5))
(adjoin-set 3 '(1 2 4 5))
(adjoin-set 0 '(1 2 3 4 5))
(adjoin-set 6 '(1 2 3 4 5))

