#lang racket

(require "getput.scm")
(require "2-83-base.scm")

(provide
    raise)

(define (install-raise-package)
    (define (raise-integer i) (make-rational i 1))
    (define (raise-rational r) (make-real r))
    (define (raise-real r) (make-complex r 0))

    (put 'raise '(integer) raise-integer)
    (put 'raise '(rational) raise-rational)
    (put 'raise '(real) raise-real)

    'raise-package-installed)

(install-raise-package)

(define (raise i) (apply-generic 'raise i))

#|
(raise (make-integer 3))
(raise (make-rational 3 4))
(raise (make-real 0.75))
|#
