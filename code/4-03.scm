(include "g_getput.scm")
(include "4.1.scm")

;; copied from http://community.schemewiki.org/?sicp-ex-4.3

(put 'op 'quote     text-of-quotation)
(put 'op 'set!      eval-assignment)
(put 'op 'define    eval-definition)
(put 'op 'if        eval-if)
(put 'op 'lambda    (lambda (x y) (make-procedure (lambda-parameters x) (lambda-body x) y)))
(put 'op 'begin     (lambda (x y) (eval-sequence (begin-sequence x) y)))
(put 'op 'cond      (lambda (x y) (evaln (cond-if x) y)))

(define (evaln expr env)
    (cond
        ((self-evaluating? expr) expr)
        ((variable? expr) (lookup-variable-value expr env))
        ((get 'op (car expr))
            (applyn (get 'op (car expr) expr env)))
        ((application? expr) (applyn (evaln (operator expr) env) (list-of-values (operands expr) env)))
        (else
            (error "unknown expression type -- EVAL" expr))))
