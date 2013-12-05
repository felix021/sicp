(define dont-run-any 1)
(include "4-33.scm")

(map (lambda (name obj)
        (define-variable!  name (list 'primitive obj) the-global-environment))
    (list 'raw-cons 'raw-car 'raw-cdr)
    (list cons car cdr))

;#|

(actual-value
    '(begin

        (define (cons x y)
            (raw-cons 'cons (lambda (m) (m x y))))

        (define (car z)
            ((raw-cdr z) (lambda (p q) p)))

        (define (cdr z)
            ((raw-cdr z) (lambda (p q) q)))
    )
    the-global-environment)
;|#

(define (disp-cons obj depth)
    (letrec ((user-car (lambda (z)
                (force-it (lookup-variable-value 'x (procedure-environment (cdr z))))))
             (user-cdr (lambda (z)
                (force-it (lookup-variable-value 'y (procedure-environment (cdr z)))))))
        (cond
            ((>= depth 10)
                (display "... )"))
            ((null? obj)
                (display ""))
            (else
                (let ((cdr-value (user-cdr obj)))
                    (display "(")
                    (display (user-car obj))
                    (if (tagged-list? cdr-value 'cons)
                        (begin
                            (display " ")
                            (disp-cons cdr-value (+ depth 1)))
                        (begin
                            (display " . ")
                            (display cdr-value)))
                    (display ")"))))))

(define (user-print object)
    (if (compound-procedure? object)
        (display
            (list 'compound-procedure
                (procedure-parameters object)
                (procedure-body object)
                '<procedure-env>))
        (if (tagged-list? object 'cons)
            (disp-cons object 0)
            (display object))))

(driver-loop)
