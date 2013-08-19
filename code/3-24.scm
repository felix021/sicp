(define (make-table same-key?)
    (let ((local-table (list '*table*)))
        (define (assoc key records)
            (cond
                ((null? records) #f)
                ((same-key? key (caar records)) (car records))
                (else (assoc key (cdr records)))))

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
;#|

(define (same-key? a b)
    (if (and (number? a) (number? b))
        (< (abs (- a b)) 0.0001)
        (equal? a b)))

(define t (make-table same-key?))
((t 'insert-proc!) 'a 1.0 1)
((t 'insert-proc!) 'a 1.00001 2)
(t 'print)
((t 'insert-proc!) 'b 2.0 3)
((t 'insert-proc!) 'b 3.0 4)
(t 'print)
(display ((t 'lookup-proc) 'a 1.0)) (newline)
(display ((t 'lookup-proc) 'a 1.001)) (newline)
(display ((t 'lookup-proc) 'b 2.0)) (newline)
(display ((t 'lookup-proc) 'b 2.00001)) (newline)
;|#
