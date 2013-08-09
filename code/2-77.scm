#lang racket

(require "getput.scm")
(require "apply-generic.scm")
(require "complex-generic.scm")
(require "complex-op.scm")
(require "2.5.1-generic-op.scm")
(require "generic-op.scm")

(provide
    make-complex-rect
    make-complex-polar)

(define (install-complex-rect-package)
    (define (tag x) (attach-tag 'complex x))

    (define type-args '(complex complex))

    (define (tag-binary-op op) (lambda (x y) (tag (op x y))))

    (put 'add type-args add-complex)
    (put 'sub type-args sub-complex)
    (put 'mul type-args mul-complex)
    (put 'div type-args div-complex)

    (put 'make-from-real-imag 'complex
        (lambda (x y) (tag (make-from-real-imag x y))))

    (put 'make-from-mag-ang 'complex
        (lambda (r a) (tag (make-from-mag-ang r a))))

    (put 'real-part '(complex) real-part)
    (put 'imag-part '(complex) imag-part)
    (put 'magnitude '(complex) magnitude)
    (put 'angle '(complex) angle)

    'complex-rect-installed)

(install-complex-rect-package)

(define (make-complex-rect x y)
    ((get 'make-from-real-imag 'complex) x y))

(define (make-complex-polar r a)
    ((get 'make-from-mag-ang 'complex) r a))

;; tests

#|
(add (make-complex-rect 2 3) (make-complex-polar 3.605551275463989 0.982793723247329))

(define z (make-complex-rect 3 4))
z
(magnitude z)
;|#

;;
;;  (magnitude z)
;;      (apply-generic 'magnitude '(complex rect 3 4))
;;          (magnitude '(rect 3 4))
;;              (apply-generic 'magnitude '(rect 3 4))
;;                  (magnitude[@rect-package] '(3 4))
;; 
