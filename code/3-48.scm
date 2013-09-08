(load "3.4-parallel.scm")

(define (make-account id balance)
    (let ((s (make-serializer)))
        (define (deposit amount)
            (set! balance (+ balance amount)))
        (define (withdraw amount)
            (set! balance (- balance amount)))
        (define (dispatch request)
            (cond
                ((eq? request 'withdraw) withdraw)
                ((eq? request 'deposit) deposit)
                ((eq? request 'balance) balance)
                ((eq? request 'id) id)
                ((eq? request 'serializer) s)
                (else (error "unknown request" request))))
        dispatch))

(define (exchange acc1 acc2)
    (let ((diff (- (acc1 'balance) (acc2 'balance))))
        ((acc1 'withdraw) diff)
        ((acc2 'deposit) diff)))

(define (serialized--exchange acc1 acc2)
    (let
        ((s1 (acc1 'serializer))
         (s2 (acc2 'serializer)))
        (if (< (acc1 'id) (acc2 'id))
            ((s1 (s2 exchange)) acc1 acc2)
            ((s2 (s1 exchange)) acc1 acc2))))

(define acc1 (make-account 1 100))
(define acc2 (make-account 2 150))

(display (acc1 'balance)) (newline)
(display (acc2 'balance)) (newline)

(serialized--exchange acc1 acc2)

(display (acc1 'balance)) (newline)
(display (acc2 'balance)) (newline)
         
