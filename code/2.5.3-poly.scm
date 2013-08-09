#lang racket

(require "getput.scm")
(require "apply-generic.scm")
(require "generic-op.scm")
(require "2.5.3-term.scm")

(provide
    same-variable?
    make-poly
    variable
    term-list)

(define (same-variable? a b)
    (and
        (symbol? a)
        (symbol? b)
        (eq? a b)))

(define (make-poly variable term-list) (cons variable term-list))
(define (variable p) (car p))
(define (term-list p) (cdr p))

(define (install-polynomial-package)
    (define (poly-same-var? p1 p2)
        (same-variable? (variable p1) (variable p2)))

    (define (add-poly p1 p2)
        ;(display "term-list p1: ") (display p1) (newline)
        ;(display "term-list p2: ") (display p2) (newline)
        (if (poly-same-var? p1 p2)
            (make-poly
                (variable p1)
                (add (term-list p1) (term-list p2)))
            (error "Polys not in same var -- ADD_POLY: " (list p1 p2))))

    (define (mul-poly p1 p2)
        (if (poly-same-var? p1 p2)
            (make-poly
                (variable p1)
                (mul
                    (term-list p1)
                    (term-list p2)))
            (error "Polys not in same var -- MUL_POLY: " (list p1 p2))))

    (define (tag op) (lambda args (attach-tag 'polynomial (apply op args))))

    (define type-tags '(polynomial polynomial))

    (put 'add type-tags (tag add-poly))
    (put 'mul type-tags (tag mul-poly))
    (put 'make 'polynomial (tag make-poly))

    ;; just for test
    (define (add-num-poly num poly)
        (add-poly-num poly num))
    (define (add-poly-num poly num)
        (add-poly
            poly
            (make-poly
                (variable poly)
                (attach-tag 'termlist (list (make-term 0 num))))))
    (put 'add '(polynomial scheme-number) (tag add-poly-num))
    (put 'add '(scheme-number polynomial) (tag add-num-poly))

    ;(display (add-poly-num '(x termlist (2 1) (1 1) (0 1)) 3))

    'poly-package-installed)

(install-polynomial-package)

;; tests
#|
(define poly1 (attach-tag 'polynomial (make-poly 'x '(termlist (100 1) (2 2) (0 1)))))
(define poly2 (attach-tag 'polynomial (make-poly 'x '(termlist (100 1) (2 2) (0 1)))))
poly1
poly2
(add poly1 poly2)
(mul poly1 poly2)
;|#
