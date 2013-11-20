(define dont-run 1)

(include "4.1.scm")

; a)

(define (lookup-variable-value var env)
    (define (env-loop env)
        (define (scan vars vals)
            (cond
                ((null? vars)
                    (env-loop (enclosing-environment env)))
                ((eq? var (car vars))
                    (car vals))
                (else
                    (scan (cdr vars) (cdr vals)))))
        (if (eq? env the-empty-environment)
            (error "Unbound variable" var)
            (let ((frame (first-frame env)))
                (scan (frame-variables frame) (frame-values frame)))))
    (let ((ret (env-loop env)))
        (if (eq? ret '*unassigned*)
            (error "unassigned variable:" var)
            ret)))

; b)

(define (scan-out-defines seq)
    (define (no-defs seq)
        (if (null? seq)
            '()
            (let ((exp (car seq)))
                (if (definition? exp)
                    (no-defs (cdr seq))
                    (cons exp (no-defs (cdr seq)))))))

    (define (defs seq)
        (if (null? seq)
            '()
            (let ((exp (car seq)))
                (if (definition? exp)
                    (cons exp (defs (cdr seq)))
                    (defs (cdr seq))))))

    (cons
        'let
        (cons
            (map (lambda (x) (list x '*unassigned*)) (map cadr (defs seq)))
            (append
                (map (lambda (x) (cons 'set! (cdr x))) (defs seq))
                (no-defs seq)))))

(display
    (scan-out-defines '((define x 1) (define y 2) (+ x y) (display x)))
)

; c)
(define (make-procedure parameters body env)
    (list 'procedure parameters (scan-out-defines body) env))
; 安装在make-procedure更好，因为它只会被调用一次，而procedure-body在每次调用同一个函数时都会被调用，效率低。
