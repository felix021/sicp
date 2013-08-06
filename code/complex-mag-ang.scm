#lang racket

(require "felix.scm")

(provide
    real-part
    imag-part
    magnitude
    angle
    make-from-real-imag
    make-from-mag-ang
)

(define (magnitude z) (car z))
(define (angle z) (cdr z))

(define (real-part z) 
    (* (magnitude z) (cos (angle z))))
(define (imag-part z) 
    (* (magnitude z) (sin (angle z))))

(define (make-from-real-imag x y)
    (cons
        (sqrt (+ (square x) (square y)))
        (atan y x)))
(define (make-from-mag-ang r a) (cons r a))

#|
(define z (make-from-real-imag 2 3))
(real-part z)
(imag-part z)
(magnitude z)
(angle z) 

(define zz (make-from-mag-ang 3.605551275463989 0.982793723247329))
(real-part zz)
(imag-part zz)
(magnitude zz)
(angle zz)
;|#
