#lang racket

;(require "complex-real-imag.scm")
;(require "complex-mag-ang.scm")

;(require "complex-tag.scm")
(require "complex-generic.scm")

(define (add-complex z1 z2)
    (make-from-real-imag
        (+ (real-part z1) (real-part z2))
        (+ (imag-part z1) (imag-part z2))))

(define (sub-complex z1 z2)
    (make-from-real-imag
        (- (real-part z1) (real-part z2))
        (- (imag-part z1) (imag-part z2))))

(define (mul-complex z1 z2)
    (make-from-mag-ang
        (* (magnitude z1) (magnitude z2))
        (+ (angle z1) (angle z2))))

(define (div-complex z1 z2)
    (make-from-mag-ang
        (/ (magnitude z1) (magnitude z2))
        (- (angle z1) (angle z2))))

;#|
(define z (make-from-real-imag 2 3))
z
(real-part z)
(imag-part z)
(magnitude z)
(angle z) 
(add-complex z z)
(sub-complex z z)
(mul-complex z z)
(div-complex z z)

(newline)

(define zz (make-from-mag-ang 3.605551275463989 0.982793723247329))
zz
(real-part zz)
(imag-part zz)
(magnitude zz)
(angle zz) 
(add-complex zz z)
(sub-complex zz z)
(mul-complex zz z)
(div-complex zz z)
;|#
