(include "4.1.scm")

;SKIP(no change):
;   enclosing-environment
;   first-frame
;   the-empty-environment

(define (make-frame variables values)
    (cons 
        'table
        (map cons variables values)))

(define (frame-pairs frame) (cdr frame-pairs))

(define (add-biding-to-frame! var val frame)
    (set-cdr! frame
        (cons (cons var val) (frame-pairs frame))))

;SKIP:
;   extend-environment

(define (lookup-variable-value var env)
    (define (env-loop env)
        (if (eq? env the-empty-environment)
            (error "Unbound variable" var)
            (let ((ret (assoc var (frame-pairs (first-frame env)))))
                (if ret
                    (cdr ret)
                    (env-loop (enclosing-environment env))))))
    (env-loop env))

(define (set-variable-value! var val env)
    (define (env-loop env)
        (if (eq? env the-empty-environment)
            (error "Unbound variables -- SET!" var)
            (let ((ret (assoc var (frame-pairs (first-frame env)))))
                (if ret
                    (set-cdr! ret val)
                    (env-loop (enclosing-environment env))))))
    (env-loop env))

(define (define-variable! var val env)
    (let* ((frame (first-frame env))
           (ret (assoc var (frame-pairs frame))))
        (if ret
            (set-cdr! ret val)
            (add-biding-to-frame! var val frame))))
    
