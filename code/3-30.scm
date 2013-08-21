(define (dd x) (display x) (display " "))
(load "3.3.4.scm")

;; delay = (* n fa-delay)
;;       = (* n (+ ha-delay ha-delay or-delay))
;;       = (* n (+ (* 2 (+ (max and-delay (+ or-delay not-delay)) and-delay)) or-delay))

(define (ripple-carry-adder A B S C) ; assuming that A/B/S have the same length
    (define (adder A B c-in S c-out)
        (if (null? A)
            (add-action! c-in
                (lambda () (set-signal! C (get-signal c-in))))
            (let ((a (car A))
                  (b (car B))
                  (s (car S)))
                (full-adder a b c-in s c-out)
                (adder (cdr A) (cdr B) c-out (cdr S) (make-wire)))))
    (define c-in (make-wire))
    (set-signal! c-in 0)
    (adder A B c-in S (make-wire)))

;; tests
(define a0 (make-wire))
(define b0 (make-wire))
(define s0 (make-wire))

(define a1 (make-wire))
(define b1 (make-wire))
(define s1 (make-wire))

(define C (make-wire))

(ripple-carry-adder (list a0 a1) (list b0 b1) (list s0 s1) C)

(set-signal! a0 1)
(set-signal! a1 1)

(set-signal! b0 1)
(set-signal! b1 1)


(D (list s0 s1 (get-signal C)))
