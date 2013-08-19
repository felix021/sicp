

(define (assoc key records)
    (cond
        ((null? records) #f)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

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
                (cons (cons key value) (cdr table)))))
    'ok)

(define (make-table) (list '*table*))

;; tests
#|
(define t (make-table))

(insert! 'a 1 t)
(insert! 'b 2 t)
(insert! 'c 3 t)

(display t) (newline)
(display (assoc 'b (cdr t))) (newline)
(display (lookup 'b t)) (newline)
;|#

(define (lookup2 key-1 key-2 table)
    (let ((subtable (assoc key-1 (cdr table))))
        (if subtable
            (lookup key-2 subtable)
            #f)))

(define (insert2! key-1 key-2 value table)
    (let ((subtable (assoc key-1 (cdr table))))
        (if subtable
            (insert! key-2 value subtable)
            (set-cdr! table
                (cons
                    (list key-1 (cons key-2 value))
                    (cdr table)))))
    'ok)

;; tests
#|
(define t (make-table))
(insert2! 'a 'p 1 t)
(insert2! 'a 'q 2 t)
(insert2! 'b 'p 3 t)
(insert2! 'b 'q 4 t)
(display t) (newline)
(display (lookup2 'b 'p t)) (newline)
(display (lookup2 'b 'r t)) (newline)
;|#

(define (make-table-x)
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
                                (cons
                                    (cons key-2 value)
                                    (cdr subtable)))))
                    (set-cdr! local-table
                        (cons
                            (list key-1
                                (cons key-2 value))
                            (cdr local-table))))))
        (define (print)
            (display local-table)
            (newline))
        (define (dispatch m)
            (cond
                ((eq? m 'lookup-proc) lookup)
                ((eq? m 'insert-proc!) insert!)
                ((eq? m 'print) (print))
                (else (error "Unknown operation -- TABLE" m))))

        dispatch))

;; tests
#|
(define t (make-table-x))
((t 'insert-proc!) 'a 'p 1)
((t 'insert-proc!) 'a 'q 2)
((t 'insert-proc!) 'b 'p 3)
((t 'insert-proc!) 'b 'q 4)
(t 'print)
(display ((t 'lookup-proc) 'b 'p)) (newline)
(display ((t 'lookup-proc) 'b 'r)) (newline)
;|#

(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))
