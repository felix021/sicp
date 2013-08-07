#lang racket

(define (square x) (* x x))

(define (make-from-real-imag x y)
    (define (dispatch op)
        (cond
            ((eq? op 'real-part) x)
            ((eq? op 'imag-part) y)
            ((eq? op 'magnitude)
                (sqrt (+ (square x) (square y))))
            ((eq? op 'angle)
                (atan y x))
            (else
                (error "unknown op -- MAKE_FROM REAL IMAG: " op))))
    dispatch)

(define (make-from-mag-ang r a)
    (define (dispatch op)
        (cond
            ((eq? op 'real-part)
                (* r (cos a)))
            ((eq? op 'imag-part)
                (* r (sin a)))
            ((eq? op 'magnitude) r)
            ((eq? op 'angle) a)
            (else
                (error "unknown op -- MAKE_FROM MAG ANG: " op))))
    dispatch)

;#|
(define z (make-from-real-imag 2 3))
z
(z 'real-part)
(z 'imag-part)
(z 'magnitude)
(z 'angle) 

(define zz (make-from-mag-ang 3.605551275463989 0.982793723247329))
zz
(zz 'real-part)
(zz 'imag-part)
(zz 'magnitude)
(zz 'angle)
;|#
