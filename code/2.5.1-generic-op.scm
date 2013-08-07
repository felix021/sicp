#lang racket

(require "getput.scm")
(require "apply-generic.scm")

(provide 
    add
    sub
    mul
    div)

(define (install-scheme-number-package)

    (define (tag x) (attach-tag 'scheme-number x))

    (define type-args '(scheme-number scheme-number))

    (define (tag-binary-op op) (lambda (x y) (tag (op x y))))

    (put 'add type-args (tag-binary-op +))
    (put 'sub type-args (tag-binary-op -))
    (put 'mul type-args (tag-binary-op *))
    (put 'div type-args (tag-binary-op /))
    (put 'make 'scheme-number (lambda (x) (tag x)))

    'scheme-number-package-installed)

(install-scheme-number-package)

(define (make-scheme-number n)
    ((get 'make 'scheme-number) n))

(define (install-rational-package)
    (define (numer x) (car x))
    (define (denom x) (cdr x))

    (define (make-rat n d)
        (let ((g (gcd n d)))
            (cons (/ n g) (/ d g))))

    (define (add-rat x y)
        (make-rat (+ (* (numer x) (denom y))
                     (* (denom x) (numer y)))
                  (* (denom x) (denom y))))

    (define (sub-rat x y)
        (make-rat (- (* (numer x) (denom y))
                     (* (denom x) (numer y)))
                  (* (denom x) (denom y))))

    (define (mul-rat x y)
        (make-rat (* (numer x) (numer y))
                  (* (denom x) (denom y))))

    (define (div-rat x y)
        (make-rat (* (numer x) (denom y))
                  (* (denom x (numer y)))))

    (define (equal-rat? x y)
        (= (* (numer x) (denom y))
           (* (denom x) (numer y))))

    (define (tag x) (attach-tag 'rational x))

    (define type-args '(rational rational))

    (define (tag-binary-op op) (lambda (x y) (tag (op x y))))

    (put 'add type-args (tag-binary-op add-rat))
    (put 'sub type-args (tag-binary-op sub-rat))
    (put 'mul type-args (tag-binary-op mul-rat))
    (put 'div type-args (tag-binary-op div-rat))
    (put 'make 'rational (lambda (n d) (tag (make-rat n d))))

    'rational-package-installed)

(install-rational-package)

(define (make-rational x y)
    ((get 'make 'rational) x y))

(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))

;; tests
#|
(add (make-scheme-number 2) (make-scheme-number 3))
(add (make-rational 2 3) (make-rational 1 3))
;|#
