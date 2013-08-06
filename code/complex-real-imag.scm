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

(define (real-part z) (car z))
(define (imag-part z) (cdr z))

(define (magnitude z)
    (sqrt (+ (square (real-part z)) (square (imag-part z)))))
(define (angle z)
    (atan (imag-part z) (real-part z)))

(define (make-from-real-imag x y) (cons x y))
(define (make-from-mag-ang r a)
    (cons (* r (cos a)) (* r (sin a))))

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
