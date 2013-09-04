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
        (let ((protected-withdraw (protected withdraw))
              (protected-deposit  (protected deposit)))
            (define (dispatch m)
                (cond
                    ((eq? m 'withdraw) protected-withdraw)
                    ((eq? m 'deposit) protected-deposit)
                    ((eq? m 'balance) balance)
                    (else (error "unknown request -- MAKE-ACCOUNT" m))))
            dispatch)))

; 从正确性上来说是没有差别的，区别只在于什么时候[创建串行化执行函数]：
;   3-41中的版本是在调用withdraw/deposit的时候创建，
;   而本题则是在调用make-account的时候就先创建好。
