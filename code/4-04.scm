(define (and? exp) (tagged-list? exp 'and))
(define (and-cases exp) (cdr exp))

; exp should be (and-cases exp)
(define (eval-and exp env)
    (if (null? exp)
        true
        (if (true? (eval (car exp) env))
            (eval-and (cdr exp) env)
            false)))

(define (or? exp) (tagged-list? exp 'or))
(define (or-cases exp) (cdr exp))

; exp should be (or-cases exp)
(define (eval-or exp env)
    (if (null? exp)
        true
        (if (true? (eval (car exp) env))
            true
            (eval-or (cdr exp) env))))

(define (eval exp env)
    (cond
        ((self-evaluating? exp) exp)
        ;.....
        ((and? exp)
            (eval-and (and-cases exp) env))
        ((or? exp)
            (eval-or (or-cases exp) env))
        ;.....
        ((application? exp)
            (apply
                (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
            (error "unknown expression type -- EVAL" exp))))

;;;;;
;派生表达式

(define (expand-and exp)
    (if (null? exp)
        true
        (let ((first (car exp))
              (rest  (cdr exp)))
            (make-if
                first
                (if (null? rest)
                    true
                    (expand-and rest))
                false))))

(define (and->if exp)
    (expand-and (and-cases exp)))

(define (expand-or exp)
    (if (null? exp)
        true
        (let ((first (car exp))
              (rest  (cdr exp)))
            (make-if
                first
                true
                (if (null? rest)
                    true
                    (expand-or rest))))))

(define (or->if exp)
    (expor-or (or-cases exp)))
