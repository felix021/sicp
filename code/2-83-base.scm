#lang racket

(require "getput.scm")

(provide
    make-integer
    make-rational
    make-real
    make-complex

    attach-tag
    type-tag
    contents
    apply-generic)

(define (make-integer i)
    (attach-tag 'integer i))

(define (make-rational n d)
    (attach-tag 'rational (/ n d)))

(define (make-real r)
    (attach-tag 'real (exact->inexact r)))

(define (make-complex r i)
    (attach-tag 'complex (make-rectangular r i)))

;; don't need the 'integer special treating, so copied from apply-generic.scm
;;
(define (attach-tag type-tag contents)
    (cons type-tag contents))

(define (type-tag datum)
    (cond
        ((pair? datum) (car datum))
        (else (error "bad tagged datum -- TYPE-TAG: " datum))))

(define (contents datum)
    (cond
        ((pair? datum) (cdr datum))
        (else (error "bad tagged datum -- CONTENTS: " datum))))

(define (apply-generic op . args)
    (let*
          ((type-tags (map type-tag args))
           (proc (get op type-tags)))
        (if proc
            (apply proc (map contents args))
            (error 
                "no method available for types -- APPLY-GENERIC: "
                (list op type-tags)))))

