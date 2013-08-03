#lang racket

(define (fringe-once lst)
    (define (append-lst l r) (append l (if (pair? r) r (list r))))
    (define (iter result remain)
        (if (null? remain)
            result
            (iter (append-lst result (car remain)) (cdr remain))))
    (iter '() lst))

(define (fringe lst)
    (cond 
        ((null? lst) '())
        ((not (pair? lst)) (list lst))
        (else (append (fringe (car lst)) (fringe (cdr lst))))))

(fringe '(1 (2 (3 4) (5 6)) (7 8 (9 10 (11 12)))))
