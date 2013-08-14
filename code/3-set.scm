(define (make-new-set) '())

(define (in-set? x set)
    (cond
        ((null? set) #f)
        ((eq? x (car set)) #t)
        (else (in-set? x (cdr set)))))

(define (adjoint x set)
    (cons x set))

