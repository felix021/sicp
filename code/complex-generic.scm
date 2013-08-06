#lang racket

(provide
    real-part
    imag-part
    magnitude
    angle
    make-from-real-imag
    make-from-mag-ang
    square
)

(define (square x) (* x x))

(define (attach-tag type-tag contents)
    (cons type-tag contents))

(define (type-tag datum)
    (if (pair? datum)
        (car datum)
        (error "bad tagged datum -- TYPE-TAG: " datum)))

(define (contents datum)
    (if (pair? datum)
        (cdr datum)
        (error "bad tagged datum -- CONTENTS: " datum)))

;TODO @3.3?
;(define put (lambda (x y z) '()))
;(define get (lambda (x y z) '()))

(require "getput.scm")

(define (install-rectangular-package)
    (define (real-part z) (car z))
    (define (imag-part z) (cdr z))

    (define (magnitude z)
        (sqrt (+ (square (real-part z)) (square (imag-part z)))))
    (define (angle z)
        (atan (imag-part z) (real-part z)))

    (define (make-from-real-imag x y) (cons x y))
    (define (make-from-mag-ang r a)
        (cons (* r (cos a)) (* r (sin a))))

    ;; interface to the rest of the system
    (define (tag x) (attach-tag 'rectangular x))

    (put 'real-part '(rectangular) real-part)
    (put 'imag-part '(rectangular) imag-part)
    (put 'magnitude '(rectangular) magnitude)
    (put 'angle     '(rectangular) angle)
    (put 'make-from-real-imag 'rectangular
        (lambda (x y) (tag (make-from-real-imag x y))))
    (put 'make-from-mag-ang   'rectangular
        (lambda (r a) (tag (make-from-mag-ang r a))))
    'done)

(define (install-polar-package)
    (define (magnitude z) (car z))
    (define (angle z) (cdr z))

    (define (real-part z) 
        (* (magnitude z) (cos (angle z))))
    (define (imag-part z) 
        (* (magnitude z) (sin (angle z))))

    (define (make-from-real-imag x y)
        (cons
            (sqrt (+ (square x) (square y)))
            (atan y x)))
    (define (make-from-mag-ang r a) (cons r a))

    ;; interface to the rest of the system
    (define (tag x) (attach-tag 'polar x))

    (put 'real-part '(polar) real-part)
    (put 'imag-part '(polar) imag-part)
    (put 'magnitude '(polar) magnitude)
    (put 'angle     '(polar) angle)
    (put 'make-from-real-imag 'polar
        (lambda (x y) (tag (make-from-real-imag x y))))
    (put 'make-from-mag-ang   'polar
        (lambda (r a) (tag (make-from-mag-ang r a))))
    'done)

(install-rectangular-package)
(install-polar-package)

(define (apply-generic op . args)
    (let*
          ((type-tags (map type-tag args))
           (proc (get op type-tags)))
        (if proc
            (apply proc (map contents args))
            (error 
                "no methdo available for types -- APPLY-GENERIC: "
                (list op type-tags)))))

(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))

(define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))

(define (make-from-mag-ang x y)
    ((get 'make-from-mag-ang 'polar) x y))

#|
(define z (make-from-real-imag 2 3))
(real-part z)
(imag-part z)
(magnitude z)
(angle z) 
(add-complex z z)
(sub-complex z z)
(mul-complex z z)
(div-complex z z)

(define zz (make-from-mag-ang 3.605551275463989 0.982793723247329))
(real-part zz)
(imag-part zz)
(magnitude zz)
(angle zz) 
(add-complex zz z)
(sub-complex zz z)
(mul-complex zz z)
(div-complex zz z)
;|#
