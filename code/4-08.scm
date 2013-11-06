(include "4.1.scm")

(define (let? exp) (tagged-list? exp 'let))

(define (let-parameters-list exp) (cadr exp))

(define (let-body exp) (cddr exp))

(define (naming-let? exp) (symbol? (cadr exp)))
(define (naming-let-name exp) (cadr exp))
(define (naming-let-parameters-list exp) (caddr exp))
(define (naming-let-body exp) (cadddr exp))

(define (let->combination exp)
    (if (naming-let? exp)
        (let ((name (naming-let-name exp))
              (parameters (naming-let-parameters-list exp)))
            (sequence->exp
                (list
                    (list 'define name
                        (make-lambda
                            (map car parameters)
                            (naming-let-body exp)))
                    (cons name (map cadr parameters)))))
        (let ((parameters  (let-parameters-list exp)))
            (cons
                (make-lambda
                    (map car parameters)
                    (let-body exp))
                (map cadr parameters)))))
                

;eval: 在 application? 之前添加即可
;   ((let? exp) (eval (let->combination exp) env))
