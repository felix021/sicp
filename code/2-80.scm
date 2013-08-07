#lang racket

(require "getput.scm")
(require "apply-generic.scm")
(require "complex-generic.scm")
(require "complex-op.scm")
(require "2-77.scm")

(define (install-=zero?)
    (define tolerance 0.0001)
    (define (eq-float x y) (< (abs (- x y)) tolerance))

    (put '=zero? '(scheme-number) (lambda (x) (= x 0)))
    (put '=zero? '(complex)
        (lambda (x) 
            ;(display (real-part x)) (newline) (display (imag-part x)) (newline)
            (and
                (eq-float (real-part x) 0)
                (eq-float (imag-part x) 0))))

    '=zero?-installed)

(install-=zero?)

(define (=zero? x)
    (apply-generic '=zero? x))

;; tests
(=zero? 0) ;#t
(=zero? 1) ;#f

(=zero? (make-complex-rect 0 0))  ;#t
(=zero? (make-complex-polar 0 0)) ;#t
(=zero? (make-complex-rect 1 0))  ;#f
(=zero? (make-complex-polar 0 1)) ;#t
(=zero? (make-complex-polar 1 0)) ;#f
(=zero? (make-complex-rect 0.000001 0)) ;#t
