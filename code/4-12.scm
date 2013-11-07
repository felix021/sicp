(include "4-11.scm")

(define (lookup-in-current-level var env)
    (if (eq? env the-empty-environment)
        #f
        (assoc var (frame-pairs (first-frame env)))))

(define (lookup-variable-pair var env)
    (if (eq? env the-empty-environment)
        #f
        (let ((ret (lookup-in-current-level var env)))
            (if ret
                ret
                (lookup-variable-pair var (enclosing-environment env))))))

(define (lookup-variable-value var env)
    (let ((ret (lookup-variable-pair var env)))
        (if ret
            (cdr ret)
            (error "Unbound variable" var))))

(define (set-variable-value! var val env)
    (let ((ret (lookup-variable-pair var env)))
        (if ret
            (set-cdr! ret val)
            (error "Unbound variable" var))))

(define (define-variable! var val env)
    (let ((ret (lookup-in-current-level var env)))
        (if ret
            (set-cdr! ret val)
            (add-biding-to-frame! var val (first-frame env)))))
