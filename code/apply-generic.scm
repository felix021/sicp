#lang racket

(require "getput.scm")

(provide
    attach-tag
    type-tag
    contents
    apply-generic)

(define (attach-tag type-tag contents)
    (if (number? contents) ;2-78
        contents
        (cons type-tag contents)))

(define (type-tag datum)
    (cond
        ((number? datum) 'scheme-number) ;2-78
        ((pair? datum) (car datum))
        (else (error "bad tagged datum -- TYPE-TAG: " datum))))

(define (contents datum)
    (cond
        ((number? datum) datum) ;2-78
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
