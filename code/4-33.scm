(define dont-run-now 1)
(include "4.2.3-full.scm")

;; my solution: 依赖于cons的实现
(define (text-of-quotation expr)
    (define (new-list pair)
        (if (null? pair)
            '()
            (make-procedure
                '(m)
                (list (list 'm 'car-value 'cdr-value))
                (extend-environment
                    (list 'car-value 'cdr-value)
                    (list (car pair) (new-list (cdr pair)))
                    the-empty-environment))))
    (let ((text (cadr expr)))
        (if (not (pair? text))
            text
            (new-list text))))

;; meteorgan's solution @ http://community.schemewiki.org/?sicp-ex-4.33
;; 不依赖于cons的具体实现，更好

(define prev-eval eval)

(define (eval expr env)
    (if (quoted? expr)
        (text-of-quotation expr env)
        (prev-eval expr env)))

(define (text-of-quotation expr env)
    (let ((text (cadr expr)))
        (if (pair? text)
            (eval (make-list text) env)
            text)))

(define (make-list expr)
    (if (null? expr)
        (list 'quote '())
        (list 'cons
            (list 'quote (car expr))
            (make-list (cdr expr)))))

(if (not (defined? 'dont-run-any))
    (driver-loop)
)
