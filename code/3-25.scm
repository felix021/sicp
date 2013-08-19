
(define (make-table) (list '*table*))

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
            (begin
                (set-cdr! record value)
                record)
            (begin
                (set-cdr! table
                    (cons
                        (cons key value)
                        (cdr table)))
                (cadr table)))))

#|
(define t (make-table))
(display (insert! 'a 1 t)) (newline)
(display (insert! 'b 1 t)) (newline)
(display (insert! 'a 1 t)) (newline)
(display t) (newline)
(display (lookup 'a t)) (newline)
|#

(define (lookup-rec keys table)
    (let* ((key (car keys))
           (remain (cdr keys))
           (record (assoc key (cdr table))))
        (cond
            ((not record) #f)
            ((null? remain) (cdr record))
            ((list? record) (lookup-rec remain record))
            (else #f))))

(define (insert-rec! keys value table)
    (let* ((key (car keys))
           (remain (cdr keys))
           (record (lookup key table)))
        (if record
            (if (null? remain)
                (set-cdr! record value)
                (insert-rec! remain value record))
            (if (null? remain)
                (set-cdr! table
                    (cons
                        (cons key value)
                        (cdr table)))
                (begin
                    (set-cdr! table
                        (cons
                            (list key)
                            (cdr table)))
                    (insert-rec! remain value (cadr table)))))))

(define (D x) (display x) (newline))

;; tests
(define t (make-table))
(D t)
(insert-rec! '(a) 1 t)
(insert-rec! '(b a) 2 t)
(insert-rec! '(b b) 3 t)
(insert-rec! '(c a) 4 t)
(insert-rec! '(c b a) 5 t)
(insert-rec! '(c b b) 6 t)
(D t)
(D (lookup-rec '(a) t))
(D (lookup-rec '(a b) t))

(D (lookup-rec '(b) t))
(D (lookup-rec '(b a) t))
(D (lookup-rec '(b b) t))
(D (lookup-rec '(b c) t))

(D (lookup-rec '(c) t))
(D (lookup-rec '(c a) t))
(D (lookup-rec '(c b) t))
(D (lookup-rec '(c b a) t))
(D (lookup-rec '(c b b) t))
(D (lookup-rec '(c b c) t))
