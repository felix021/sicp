(define true #t)
(define false #f)

(define != (lambda (x y) (not (= x y))))
(define neq? (lambda (x y) (not (eq? x y))))
(define nequal? (lambda (x y) (not (equal? x y))))

(define (distinct? items)
    (cond
        ((null? items) true)
        ((null? (cdr items)) true)
        ((member (car items) (cdr items)) false)
        (else (distinct? (cdr items)))))

(define (flat-map proc lst)
    (if (null? lst)
        '()
        (let ((first (proc (car lst))))
            ((if (pair? first) append cons)
                first
                (flat-map proc (cdr lst))))))

(define (permutations-inner lst is?)
    (if (null? lst)
        (list '())
        (flat-map
            (lambda (first)
                (map
                    (lambda (rest) (cons first rest))
                    (permutations (filter (lambda (x) (not (is? x first))) lst))))
            lst)))

(define (permutations lst)
    (permutations-inner lst =))

(define (permutations-eq lst)
    (permutations-inner lst eq?))

(define (permutations-equal lst)
    (permutations-inner lst equal?))
