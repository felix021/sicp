(define (cons x y)
    (define (set-x! v) (set! x v))
    (define (set-y! v) (set! y v))
    (define (dispatch m)
        (cond
            ((eq? m 'car) x)
            ((eq? m 'cdr) y)
            ((eq? m 'set-car!) set-x!)
            ((eq? m 'set-cdr!) set-y!)
            (else (error "unknown operation"))))
    dispatch)

(define (car z) (z 'car))
(define (cdr z) (z 'cdr))
(define (set-car! z v) ((z 'set-car!) v) z)
(define (set-cdr! z v) ((z 'set-cdr!) v) z)

(define x (cons 1 2))
(define z (cons x x))
(set-car! (cdr z) 17)
(display (car x))

;; 不想画图了，参考huangz同学的吧……
