#lang racket

(require "getput.scm")
(require "apply-generic.scm")
(require "complex-generic.scm")
(require "complex-op.scm")
(require "2-77.scm")

;; 为了方便区分作业，不一一塞到对应的包里了...
(define (install-equ?)
    (define tolerance 0.0001)
    (define (eq-float x y) (< (abs (- x y)) tolerance))

    (put 'equ? '(scheme-number scheme-number) (lambda (x y) (= x y)))

    ; rational这个不做了，还得适配numer和denom好麻烦
    ;(put 'equ? '(rational rational) (lambda (x y) ( ... ))) 

    (put 'equ? '(complex complex)
        (lambda (x y) 
            ;(display (real-part x)) (newline)
            ;(display (real-part y)) (newline)
            (and
                (eq-float (real-part x) (real-part y))
                (eq-float (imag-part x) (imag-part y)))))

    'equ?-installed)

(install-equ?)

(define (equ? a b)
    (apply-generic 'equ? a b))

(equ? 2 3)
(equ? 3 3)

(define z1 (make-complex-rect 2 3))
(define z2 (make-complex-polar 3.605551275463989 0.982793723247329))

(equ? z1 z2)
(equ? (make-complex-rect 3 3) z2)
(equ? (make-complex-rect 2 3.00000001) z2)
