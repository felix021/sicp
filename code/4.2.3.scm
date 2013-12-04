(define dont-run-all 1)
(include "4.2.2.scm")

(actual-value
    '(begin

        (define (cons x y)
            (lambda (m) (m x y)))

        (define (car z)
            (z (lambda (p q) p)))

        (define (cdr z)
            (z (lambda (p q) q)))

        (define (list-ref items n)
            (if (= n 0)
                (car items)
                (list-ref (cdr items) (- n 1))))

        (define (map proc items)
            (if (null? items)
                '()
                (cons (proc (car items))
                      (map proc (cdr items)))))

        (define (scale-list items factor)
            (map (lambda (x) (* x factor))
                 items))

        (define (add-lists list1 list2)
            (cond
                ((null? list1) list2)
                ((null? list2) list1)
                (else
                    (cons
                        (+ (car list1) (car list2))
                        (add-lists (cdr list1) (cdr list2))))))

        (define ones (cons 1 ones))

        (define integers (cons 1 (add-lists ones integers)))
        
        (define (integral integrand initial-value dt)
            (define int
                (cons
                    initial-value
                    (add-lists (scale-list integrand dt) int)))
            int)

        (define (solve f y0 dt)
            (define y (integral dy y0 dt))
            (define dy (map f y))
            y)
    )
    the-global-environment)

(if (not (defined? 'dont-run-any))
    (driver-loop)
)
