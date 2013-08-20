(define (D x) (display x) (newline))

(define (after-delay delay proc)
    (usleep (* delay 1000))
    (proc))

(define inverter-delay 1)
(define or-gate-delay 1)
(define and-gate-delay 1)

(define (make-wire) (list 0)) ; value, actions

(define (add-action! wire proc) (set-cdr! wire (cons proc (cdr wire))))
(define (get-action wire) (cdr wire))

(define (get-signal wire) (car wire))
(define (set-signal! wire value)
    ;(D "set-signal!") (D wire) (D value)
    (set-car! wire value)
    (letrec
        ((actions (get-action wire))
         (execute
            (lambda (remain)
                (cond
                    ((not (null? remain))
                        ((car remain))
                        (execute (cdr remain)))))))
        (execute actions)))
            

(define (logical-not s)
    (cond
        ((= s 0) 1)
        ((= s 1) 0)
        (error "illegal signal")))

(define (inverter input output)
    (define (invert-input)
        (let ((new-value (logical-not (get-signal input))))
            (after-delay
                inverter-delay
                (lambda ()
                    (set-signal! output new-value)))))
    (add-action! input invert-input))

(define (logical-and a b)
    (cond
        ((and (= a 1) (= b 1)) 1)
        (else 0)))

(define (and-gate a1 a2 output)
    (define (and-action-procedure)
        (let ((new-value (logical-and (get-signal a1) (get-signal a2))))
            (after-delay and-gate-delay
                (lambda ()
                    (set-signal! output new-value)))))
    (add-action! a1 and-action-procedure)
    (add-action! a2 and-action-procedure)
    'ok)

;; 3-28
(define (logical-or a b)
    (cond
        ((or (= a 1) (= b 1)) 1)
        (else 0)))

(define (or-gate a1 a2 output)
    (define (or-action-procedure)
        (let ((new-value (logical-or (get-signal a1) (get-signal a2))))
            (after-delay or-gate-delay
                (lambda ()
                    (set-signal! output new-value)))))
    (add-action! a1 or-action-procedure)
    (add-action! a2 or-action-procedure)
    'ok)

;; tests
;#|
(define a (make-wire))
(define b (make-wire))
(define c (make-wire))
(define d (make-wire))
(define e (make-wire))
(define s (make-wire))

#|
(or-gate a b d)
(and-gate a b c)
(inverter c e)
(and-gate d e s)

(set-signal! a 0)
(D c) (D s)
(set-signal! b 1)
(D c) (D s)
(set-signal! a 1)
(D c) (D s)
;|#

(define (half-adder a b s c)
    (let ((d (make-wire))
          (e (make-wire)))
        (or-gate a b d)
        (and-gate a b c)
        (inverter c e)
        (and-gate d e s)
        'ok))

;; tests
#|
(half-adder a b s c)
(set-signal! a 0)
(D c) (D s)
(set-signal! b 1)
(D c) (D s)
(set-signal! a 1)
(D c) (D s)
|#


(define (full-adder a b c-in sum c-out)
    (let ((s (make-wire))
          (c1 (make-wire))
          (c2 (make-wire)))
        (half-adder b c-in s c1)
        (half-adder a s sum c2)
        (or-gate c1 c2 c-out)
        'ok))
;; tests
#|
(full-adder a b c s d)
(set-signal! a 0)
(D d) (D s)
(set-signal! b 1)
(D d) (D s)
(set-signal! a 1)
(D d) (D s)
(set-signal! c 1)
(D d) (D s)
|#
