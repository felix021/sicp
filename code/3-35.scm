(load "3.3.5.scm")

(define (squarer a b)
    (define (process-new-value)
        (if (has-value? b)
            (if (< (get-value b) 0)
                (error "square less than 0 -- SQUARER" (get-value b))
                (set-value! a (sqrt (get-value b)) me))
            (if (has-value? a)
                (set-value! b (* (get-value a) (get-value a)) me))))
    (define (process-forget-value)
        (forget-value! a me)
        (forget-value! b me)
        (process-new-value))
    (define (me request)
        (cond
            ((eq? request 'I-have-a-value) (process-new-value))
            ((eq? request 'I-lost-my-value) (process-forget-value))
            (else (error "unknown request -- SQUARER.me" request))))
    (connect a me)
    (connect b me)
    me)

;#|

(define a (make-connector))
(define b (make-connector))

(squarer a b)
(probe "a" a)
(probe "b" b)

(set-value! a 3 'user)
(forget-value! a 'user)

(set-value! b 16 'user)

;|#
