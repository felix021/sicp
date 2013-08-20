;; 3-28
(define (logic-or a b)
    (cond
        ((or (= a 1) (= b 1)) 1)
        (else 0)))

(define (or-gate a1 a2 output)
    (define (or-action-procedure)
        (let ((new-value (logic-or (get-signal a1) (get-signal a2))))
            (after-delay or-gate-delay
                (lambda ()
                    (set-signal! output new-value)))))
    (add-action! a1 or-action-procedure)
    (add-action! a2 or-action-procedure)
    'ok)
