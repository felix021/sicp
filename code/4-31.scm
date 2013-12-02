(define dont-run-all 1)
(include "4.2.2.scm")

;; 不写lazy-memo了，太麻烦了。。。

(define (apply procedure arguments env)
    (cond
        ((primitive-procedure? procedure)
            (apply-primitive-procedure
                procedure
                (list-of-arg-values arguments env)))
        ((compound-procedure? procedure)
            (eval-compound-procedure procedure arguments env))
        (else
            (error "Unknown procedure type -- APPLY" procedure))))

(define (eval-compound-procedure procedure arguments env)
    (define (iter-args formal-args actual-args)
        (if (null? formal-args)
            '()
            (cons
                (let ((this-arg (car formal-args)))
                    (if (and (pair? this-arg)
                             (eq? (cadr this-arg) 'lazy))
                        (delay-it (car actual-args) env)
                        (eval (car actual-args) env)))
                (iter-args (cdr formal-args) (cdr actual-args)))))

    (define (procedure-arg-names parameters)
        (map (lambda (x) (if (pair? x) (car x) x)) parameters))

    (eval-sequence
        (procedure-body procedure)
        (extend-environment
            (procedure-arg-names (procedure-parameters procedure))
            (iter-args 
                (procedure-parameters procedure)
                arguments)
            (procedure-environment procedure))))

(driver-loop)

;
; M-Eval input: 
;(define x 1)
;
; M-Eval value: 
;ok
;
; M-Eval input: 
;(define (p (e lazy)) e x)
;
; M-Eval value: 
;ok
;
; M-Eval input: 
;(p (set! x (cons x '(2))))
;
; M-Eval value: 
;1
;
; M-Eval input: 
;(exit)
;
