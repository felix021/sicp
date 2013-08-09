#lang racket

(require "getput.scm")
(require "2-83-base.scm")
(require "2-83.scm")
(require "2-84.scm")

(define (install-project-package)
    (define (project-rational r) (make-integer (round r)))
    (define (project-real r) 
        (let* ((rat (inexact->exact r))
               (numer (numerator rat))
               (denom (denominator rat)))
            (make-rational numer denom)))
    (define (project-complex r) (make-real (real-part r)))

    (put 'project '(rational) project-rational)
    (put 'project '(real) project-real)
    (put 'project '(complex) project-complex)

    'project-package-installed)

(install-project-package)

(define (project x)
    (apply-generic 'project x))

;; project tests
;#|
(project (make-complex 3 4))
(project (project (make-complex 3 4)))
(project (project (project (make-complex 3 4))))
(project (make-real 0.75))
(project (make-rational 3 4))
(newline)
;|#

(define (near-eqv? x y)
    (define (diff a b) (abs (- a b)))
    (define tolerance 0.0001)
    (define (f-eq? f1 f2) (< (diff f1 f2) tolerance))
    (let* ((xx (contents x))
           (yy (contents y)))
        (and
            (f-eq? (real-part xx) (real-part yy))
            (f-eq? (imag-part xx) (imag-part yy)))))

(define (drop x)
    ;(display "drop: ") (display x) (newline)
    (if (eq? 'integer (type-tag x))
        x
        (let*
            ((projected (project x))
             (raised (raise projected)))
            ;(display "drop: ") (display projected) (display raised) (newline)
            ; equal? is not enought since the inexact comparison
            (if (near-eqv? raised x)
                (drop projected)
                x))))

;; drop tests
(drop (make-complex 3.0 4.0))
(drop (make-complex 3.5 0.0))
(drop (make-complex 3/2 0.0))
(drop (make-complex 3.0 0.0))
(newline)

;; it's non-trivial to deal with multiple return value,
;; so just make yourself believe it returns only one number ...
(define (apply-generic-raise-drop1 op args)
    (let ((ans (apply-generic-raise op args)))
        (drop ans)))

(define (add . args)
    (apply-generic-raise-drop1 'add args))

;; tests
;#|
(add
    (make-integer 1)
    (make-real 3.5))

(add
    (make-real 3.5)
    (make-integer 1))

(add
    (make-integer 1)
    (make-rational 1 4)
    (make-real 0.75)
    (make-complex 0 3)
    (make-complex 0 -3.0))

(add
    (make-complex 0.5 -3.0)
    (make-complex 0 3)
    (make-rational 1 4)
    (make-real 0.75)
    (make-integer 1))
;|#
