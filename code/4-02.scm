;; a) 把define和set!当作一个过程执行了
;; b)

(define (application? exp) (tagged-list? exp 'call))

(define (operator exp) (cadr exp))

(define (operands exp) (cddr exp))

;; no change
;; (define (no-operands? ops) (null? ops))
;; (define (first-operand ops) (car ops))
;; (define (rest-operands ops) (cdr ops))


(define (eval exp env)
    (cond
        ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-ofquotation exp))
        ((if? exp) (eval-if exp env))
        ((lambda ? exp)
            (make-procedure
                (lambda-parameters exp)
                (lambda-body exp)
                env))
        ((begin? exp)
            (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((application? exp)
            (apply
                (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        (else
            (error "unknown expression type -- EVAL" exp))))
