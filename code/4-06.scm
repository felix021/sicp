(include "4.1.scm")

(define (let? exp) (tagged-list? exp 'let))

(define (let-parameters-list exp) (cadr exp))

(define (let-body exp) (cddr exp))

(define (let->combination exp)
    (let ((parameters  (let-parameters-list exp)))
        (cons
            (make-lambda
                (map car parameters)
                (let-body exp))
            (map cadr parameters))))
                

;eval: 在 application? 之前添加即可
;   ((let? exp) (eval (let->combination exp) env))
