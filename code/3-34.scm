(load "3.3.5.scm")

;
;        -----
;      /       \  
; a --<         > [multiplier] -- b
;      \       /
;        -----
;
;
;

(define (squarer a b)
    (multiplier a a b))

;例如
(define a (make-connector))
(define b (make-connector))
(squarer a b)
(set-value! b 16 'user)
;因为multiplier的m1和m2都是a，因此m1、m2都是没有value的，约束条件不满足，约束无法从b传播至a
