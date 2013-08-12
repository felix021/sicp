#lang racket

(define (make-account balance passwd)
    (define (withdraw amount)
        (if (>= balance amount)
            (begin
                (set! balance (- balance amount))
                balance)
            "Insufficient funds"))
    (define (deposit amount)
        (set! balance (+ balance amount))
        balance)
    (define (dispatch pwd m)
        (cond
            ((not (eq? pwd passwd)) (error "Incorrect password"))
            ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit)  deposit)
            (else (error "unknown request -- MAKE-ACCOUNT: " m))))
    dispatch)

(define acc (make-account 100 'ooxx))
((acc 'ooxx 'withdraw) 50) ;50
((acc 'xxoo 'withdraw) 50) ;Insufficient funds
