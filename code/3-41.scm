(load "3.4-parallel.scm")

(define (make-account balance)
    (define (withdraw amount)
        (if (>= balance amount)
            (begin (set! balance (- balance amount))
                balance)
            "Insufficient funds"))
    (define (deposit amount)
        (set! balance (+ balance amount))
        balance)
    (let ((protected (make-serializer)))
        (define (dispatch m)
            (cond
                ((eq? m 'withdraw) (protected withdraw))
                ((eq? m 'deposit) (protected deposit))
                ((eq? m 'balance)
                    ((protected (lambda () balance)))) ;serialized
                (else (error "unknown request -- MAKE-ACCOUNT" m))))
        dispatch))

;担心是多余的，只是读取余额并不会导致并发问题，只是在"读取->写入"之间出现交叉的时候才可能导致不一致性。
