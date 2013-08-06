#lang racket

(require scheme/mpair)

(define cons mcons)
(define car mcar)
(define cdr mcdr)
(define set-car! set-mcar!)
(define set-cdr! set-mcdr!)
(define list mlist)
(define assoc massoc)

(define (make-table) (list '*table*))

(define (lookup key table)
    (let ((record (assoc key (cdr table))))
        (if record
            (cdr record)
            #f)))

(define (insert! key value table)
    (let ((record (assoc key (cdr table))))
        (if record
            (set-cdr! record value)
            (set-cdr! table
                (cons (cons key value) (cdr table))))))

#|
(define t (make-table))

(lookup 'a t)

(insert! 'a 1 t)
(insert! 'b 1 t)
(insert! 'a 2 t)

(lookup 'a t)
(lookup 'b t)
|#
