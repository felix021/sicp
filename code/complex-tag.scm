#lang racket

(require "felix.scm")

(provide
    real-part
    imag-part
    magnitude
    angle
    make-from-real-imag
    make-from-mag-ang
    rectangular?
    polar?
    convert-from-rect-to-polar
    convert-from-polar-to-rect
)

;tag functions
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

(define (rectangular? z)
    (eq? (type-tag z) 'rectangular))

(define (polar? z)
    (eq? (type-tag z) 'polar))

; rectanguler functions
(define (real-part-rect z) (car z))
(define (imag-part-rect z) (cdr z))

(define (magnitude-rect z)
    (sqrt (+ (square (real-part-rect z)) (square (imag-part-rect z)))))

(define (angle-rect z)
    (atan (imag-part-rect z) (real-part-rect z)))

(define (make-from-real-imag x y) (attach-tag 'rectangular (cons x y)))

(define (make-as-rect-from-polar r a)
    (make-from-real-imag (* r (cos a)) (* r (sin a))))

; polar functions
(define (magnitude-polar z) (car z))
(define (angle-polar z) (cdr z))

(define (real-part-polar z) 
    (* (magnitude-polar z) (cos (angle-polar z))))
(define (imag-part-polar z) 
    (* (magnitude-polar z) (sin (angle-polar z))))

(define (make-from-mag-ang r a) (attach-tag 'polar (cons r a)))

(define (make-as-polar-from-rect x y)
    (make-from-mag-ang
        (sqrt (+ (square x) (square y)))
        (atan y x)))

; common exposed functions
(define (make-common f-rect f-polar)
    (lambda (z)
        (if (rectangular? z)
            (f-rect (contents z))
            (f-polar (contents z)))))

(define real-part (make-common real-part-rect real-part-polar))
(define imag-part (make-common imag-part-rect imag-part-polar))
(define magnitude (make-common magnitude-rect magnitude-polar))
(define angle (make-common angle-rect angle-polar))

(define (convert-from-polar-to-rect z)
    (make-from-real-imag (real-part z) (imag-part z)))

(define (convert-from-rect-to-polar z)
    (make-from-mag-ang (magnitude z) (angle z)))
