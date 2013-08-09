#lang racket

(require "getput.scm")

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

;; not tested

(define (coerce-all args)
    (define (coerced-to type-dest remain)
        (if (null? remain)
            '()
            (let*
                ((arg-src (car remain))
                 (type-src (type-tag arg-src)))
                (if (eq? type-src type-dest)
                    (cons arg-src (coerced-to type-dest (cdr remain)))
                    (let ((coerce-func (get-coercion type-src type-dest)))
                        (if coerce-func
                            (cons (coerce-func arg-src) (coerced-to type-dest (cdr remain)))
                            #f))))))

    (define (coerced-iter types)
        (if (null? types)
            #f
            (let*
                ((type-dest (car types))
                 (coerced-args (coerced-to type-dest args)))
                (if coerced-args
                    coerced-args
                    (coerced-iter (cdr types))))))

    (coerced-iter (map type-tag args)))

(define (apply-generic op . args)
    (let*
        ((type-tags (map type-tag args))
         (proc (get op type-tags)))
        (if (not (null? proc))
            (apply proc (map contents args))
            (let ((coerced-args (coerce-all args)))
                (if coerced-args
                    (apply-generic op coerced-args)
                    (error "no available method to apply to: " (list op args)))))))
