#lang racket

(require "getput.scm")
(require "apply-generic.scm")
(require "generic-op.scm")
(require "2.5.3-poly.scm")
(require "2.5.3-term.scm")
(require "2-80.scm")

(define (install-zero-poly?)
    (define (zero-poly? terms)
        ;(display "zero?: ") (display terms) (newline)
        (cond
            ((null? terms) #t)
            ((=zero? (coeff (first-term terms)))
                (zero-poly? (rest-terms terms)))
            (else #f)))

    (put '=zero? '(polynomial) (lambda (poly) (zero-poly? (contents (term-list poly)))))

    'zero-poly-installed)

(install-zero-poly?)

#|
(=zero? '(polynomial x termlist (1 0) (0 1)))
(=zero? '(polynomial x termlist (1 0) (0 0)))
(=zero? '(polynomial x termlist (1 1) (0 0)))
(=zero? '(polynomial x termlist))
(=zero? '(polynomial x termlist (2 (polynomial y termlist (1 1) (0 1))) (1 0) (0 1)))
(=zero? '(polynomial x termlist (2 (polynomial y termlist (1 0) (0 1))) (1 0) (0 1)))
(=zero? '(polynomial x termlist (2 (polynomial y termlist (1 0) (0 0))) (1 0) (0 0)))
|#

(define poly1
    '(polynomial x termlist
        (5 4)
        (3 (polynomial y termlist (1 -1) (0 -1)))
        (2 (polynomial y termlist (1 1) (0 1)))
        (1 (polynomial y termlist (1 1) (0 1)))
        (0 3)))
(define poly2
    '(polynomial x termlist
        (4 3)
        (3 (polynomial y termlist (1 1) (0 1)))
        (1 (polynomial y termlist (1 2) (0 -1)))
        (0 2)))
poly1
poly2
(add poly1 poly2)
