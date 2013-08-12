#lang racket

(define (make-account balance passwd)
    (define err_pwd_counter 0)
    (define (withdraw amount)
        (if (>= balance amount)
            (begin
                (set! balance (- balance amount))
                balance)
            "Insufficient funds"))
    (define (deposit amount)
        (set! balance (+ balance amount))
        balance)

    (define (incorrect-passwd . args) (display "incorrect password\n"))
    (define (call-the-cops . args) (error "bad pwd over 7 times, calling cops..."))

    (define (dispatch pwd m)
        (if (not (eq? pwd passwd))
            (begin
                (set! err_pwd_counter (+ 1 err_pwd_counter))
                (if (>= err_pwd_counter 7)
                    call-the-cops
                    incorrect-passwd))
            (begin
                (set! err_pwd_counter 0)
                (cond
                    ((eq? m 'withdraw) withdraw)
                    ((eq? m 'deposit)  deposit)
                    (else (error "unknown request -- MAKE-ACCOUNT: " m))))))
    dispatch)

(define acc (make-account 100 'ooxx))
((acc 'ooxx 'withdraw) 50) ;50
((acc 'xxoo 'withdraw) 50) ;Insufficient funds
((acc 'ooxx 'withdraw) 50) ;50
((acc 'xxoo 'withdraw) 50) ;Insufficient funds
((acc 'xxoo 'withdraw) 50) ;Insufficient funds
((acc 'xxoo 'withdraw) 50) ;Insufficient funds
((acc 'xxoo 'withdraw) 50) ;Insufficient funds
((acc 'xxoo 'withdraw) 50) ;Insufficient funds
((acc 'xxoo 'withdraw) 50) ;Insufficient funds
((acc 'xxoo 'withdraw) 50) ;Insufficient funds
((acc 'xxoo 'withdraw) 50) ;call the cops
