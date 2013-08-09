#lang racket

(require "getput.scm")
(require "2-83-base.scm")
(require "2-83.scm")

(provide
    get-level
    raise-to
    apply-generic-raise
    tag-op
    )


(define (get-level type)
    (cond
        ((eq? type 'integer) 1)
        ((eq? type 'rational) 2)
        ((eq? type 'real) 3)
        ((eq? type 'complex) 4)
        (else (error "unknown type: " type))))

(define (raise-to level arg)
    (if (= level (get-level (type-tag arg)))
        arg
        (raise-to level (raise arg))))

(define (raise-all-to level remain)
    (if (null? remain)
        '()
        (cons
            (raise-to level (car remain))
            (raise-all-to level (cdr remain)))))

(define (raise-all args)
    (let
        ((max-level
            (apply
                max
                (map (lambda (x) (get-level (type-tag x))) args))))
        (raise-all-to max-level args)))

(define (apply-generic-raise op args)
    (let*
        ((type-tags (map type-tag args))
         (proc (get op type-tags)))
        (if proc
            (apply proc (map contents args))
            (let*
                ((raised-args (raise-all args))
                 (proc (get op (type-tag (car raised-args)))))
                ;(display raised-args) (newline)
                (if proc
                    (apply proc (map contents raised-args))
                    (error "no method for: " (list op args)))))))

(define (tag-op tag op)
    (lambda args (attach-tag tag (apply op args))))

(define (install-add-package)
    (put 'add 'integer (tag-op 'integer +))
    (put 'add 'rational (tag-op 'rational +))
    (put 'add 'real (tag-op 'real +))
    (put 'add 'complex (tag-op 'complex +))
    'install-add-ok)

(install-add-package)

(define (add . args)
    (apply-generic-raise 'add args))

#|
(add
    (make-integer 1)
    (make-real 3.5))

(add
    (make-real 3.5)
    (make-integer 1))

(add
    (make-integer 1)
    (make-rational 1 4)
    (make-real 0.75)
    (make-complex 0 3))

(add
    (make-complex 0 3)
    (make-rational 1 4)
    (make-real 0.75)
    (make-integer 1))
;|#
