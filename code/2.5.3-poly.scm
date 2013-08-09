#lang racket

(require "getput.scm")
(require "apply-generic.scm")
(require "generic-op.scm")

(define (same-variable? a b)
    (and
        (symbol? a)
        (symbol? b)
        (eq? a b)))

(define (install-polynomial-package)
    (define (make-poly variable term-list)
        (cons variable term-list))
    (define (variable p) (car p))
    (define (term-list p) (cdr p))

    (define (poly-same-var? p1 p2)
        (same-variable? (variable p1) (variable p2)))

    (define (add-poly p1 p2)
        (if (poly-same-var? p1 p2)
            (make-poly
                (variable p1)
                (add-terms
                    (term-list p1)
                    (term-list p2)))
            (error "Polys not in same var -- ADD_POLY: " (list p1 p2))))

    (define (mul-poly p1 p2)
        (if (poly-same-var? p1 p2)
            (make-poly
                (variable p1)
                (mul-terms
                    (term-list p1)
                    (term-list p2)))
            (error "Polys not in same var -- MUL_POLY: " (list p1 p2))))

    (define (tag op) (lambda args (attach-tag 'polynomial (apply op args))))

    (define type-tags '(polynomial polynomial))

    (put 'add type-tags (tag add-poly))
    (put 'mul type-tags (tag mul-poly))
    (put 'make 'polynomial (tag make-poly))

    'poly-package-installed)

;(define (add x y) (apply-generic 'add x y))
;(define (mul x y) (apply-generic 'mul x y))
