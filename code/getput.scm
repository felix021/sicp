#lang racket

(require scheme/mpair)

(provide
    make-table
    operation-table
    get
    put
    coercion-table
    get-coercion
    put-coercion
    )

(define cons mcons)
(define car mcar)
(define cdr mcdr)
(define set-car! set-mcar!)
(define set-cdr! set-mcdr!)
(define list mlist)
(define assoc massoc)

(define (make-table)
    (let ((local-table (list '*table*)))
        (define (lookup key-1 key-2)
            (let ((subtable (assoc key-1 (cdr local-table))))
                (if subtable
                    (let ((record (assoc key-2 (cdr subtable))))
                        (if record
                            (cdr record)
                            #f))
                    #f)))
        (define (insert! key-1 key-2 value)
            (let ((subtable (assoc key-1 (cdr local-table))))
                (if subtable
                    (let ((record (assoc key-2 (cdr subtable))))
                        (if record
                            (set-cdr! record value)
                            (set-cdr! subtable
                                (cons (cons key-2 value) (cdr subtable)))))
                    (set-cdr! local-table
                        (cons
                            (list key-1 (cons key-2 value))
                            (cdr local-table)))))
            'ok)
        (define (dispatch m)
            (cond
                ((eq? m 'lookup-proc) lookup)
                ((eq? m 'insert-proc!) insert!)
                (else (error "unknown operation -- TABLE: " m))))
        dispatch))

(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

(define coercion-table (make-table))
(define get-coercion (coercion-table 'lookup-proc))
(define put-coercion (coercion-table 'insert-proc!))
                    
#|
(put 'a 'b 1)
(put 'a 'c 2)
(put 'b 'd 3)
(put 'a 'b 4)

;operation-table

(get 'a 'b)
(get 'b 'c)
|#
