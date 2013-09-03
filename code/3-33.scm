(load "3.3.5.scm")

;
;  c ----                                  ----- a
;         \                              /
;          > [MULITPLIER] ----- [ADDER] <
;         /                              \
;  2 ----                                  ----- b
;

(define (averager a b c)
    (let 
        ((mid (make-connector))
         (two (make-connector)))
        (adder a b mid)
        (multiplier c two mid)
        (constant 2 two)
        'ok))

(define a (make-connector))
(define b (make-connector))
(define c (make-connector))

(averager a b c)

(probe "a" a)
(probe "b" b)
(probe "c" c)

(set-value! a 3 'user)
(set-value! b 5 'user)

(forget-value! b 'user)
(set-value! c 8 'user)
