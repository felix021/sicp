(include "4.1.scm")

; 以书上的版本为准，忽略4-11/4-12

; make-unbound!应当只删除当前环境的符号约束，否则可能造成混乱，例如:
#|

(define foo (display 123))

(define (bar)
    (define (baz)
        (define foo 456)
        (unbound! 'foo))
    (baz)
    (foo)) ;这里的foo应当还是有效的

(bar)

|#

(define (unbound? exp) (tagged-list? exp 'unbound!))
(define (unbound-variable exp) (cadr exp))

(define (make-unbound! var env)
    (let ((frame (first-frame env)))
        (define (scan vars vals)
            (let ((next-vars (cdr vars))
                  (next-vals (cdr vals)))
                (cond
                    ((null? next-vars) 'done)
                    ((eq? var (car next-vars))
                        (set-cdr! vars (cdr next-vars))
                        (set-cdr! vals (cdr next-vals)))
                    (else
                        (scan next-vars next-vals)))))
        (let ((vars (frame-variables frame))
              (vals (frame-values frame)))
            (if (null? vars)
                'done
                (if (eq? var (car vars))
                    (begin
                        (set-car! frame (cdr vars))
                        (set-cdr! frame (cdr vals)))
                    (scan vars vals))))))
