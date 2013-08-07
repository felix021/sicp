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
            (if (= (length args) 2)
                (let*
                    ((type1 (car type-tags))
                     (type2 (cadr type-tags))
                     (a1 (car args))
                     (a2 (cadr args))
                     (t1->t2 (get-coercion type1 type2))
                     (t2->t1 (get-coercion type2 type1)))
                    (cond
                        (t1->t2 apply-generic op (t1->t2 a1) a2)
                        (t2->t1 apply-generic op a1 (t2->t1 a2))
                        (else (error "no method to coerce types: " (list op type-tags)))))
                (error "no method for these types: " (list op type-tags))))))
