#lang racket

(define balance 100)

(define (withdraw amount)
    (if (>= balance amount)
        (begin
            (set! balance (- balance amount))
            balance)
        "Insufficient funds"))

(withdraw 25) ;75
(withdraw 25) ;50
(withdraw 60) ;Insufficient funds
(withdraw 15) ;35
(newline)

; --- p152
(define new-withdraw
    (let ((balance 100))
        (lambda (amount)
            (if (>= balance amount)
                (begin
                    (set! balance (- balance amount))
                    balance)
                "Insufficient funds"))))

(new-withdraw 30) ;70
(new-withdraw 30) ;40
(new-withdraw 50) ;Insufficient funds
(new-withdraw 20) ;20
(newline)

(define (make-withdraw balance)
    (lambda (amount)
        (if (>= balance amount)
            (begin
                (set! balance (- balance amount))
                balance)
            "Insufficient funds")))

(define W1 (make-withdraw 100))
(define W2 (make-withdraw 100))
(W1 50) ;50
(W2 70) ;30
(W2 40) ;Insufficient funds
(W1 40) ;10
(newline)

; --- p153
(define (make-account balance)
    (define (withdraw amount)
        (if (>= balance amount)
            (begin
                (set! balance (- balance amount))
                balance)
            "Insufficient funds"))
    (define (deposit amount)
        (set! balance (+ balance amount))
        balance)
    (define (dispatch m)
        (cond
            ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit)  deposit)
            (else (error "unknown request -- MAKE-ACCOUNT: " m))))
    dispatch)

(define acc (make-account 100))
((acc 'withdraw) 50) ;50
((acc 'withdraw) 60) ;Insufficient funds
((acc 'deposit) 40)  ;90
((acc 'withdraw) 60) ;30
(newline)

(define acc2 (make-account 100))

