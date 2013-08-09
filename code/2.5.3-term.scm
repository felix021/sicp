#lang racket

(require "getput.scm")
(require "apply-generic.scm")

(require "2.5.1-generic-op.scm")
(require "generic-op.scm")
(require "2-80.scm")

(provide
    the-empty-termlist
    empty-termlist?
    order
    coeff
    make-term
    adjoin-term
    first-term
    rest-terms

    add-terms
    mul-terms
    )

(define (the-empty-termlist) '())
(define (empty-termlist? term-list) (null? term-list))

(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))

(define (adjoin-term term term-list)
    (if (=zero? (coeff term))
        term-list
        (cons term term-list)))

(define (first-term term-list) (car term-list))
(define (rest-terms term-list) (cdr term-list))

(define (add-terms L1 L2)
        ;(display "term-list L1: ") (display L1) (newline)
        ;(display "term-list L2: ") (display L2) (newline)
    (cond
        ((empty-termlist? L1) L2)
        ((empty-termlist? L2) L1)
        (else
            (let ((t1 (first-term L1))
                  (t2 (first-term L2)))
             (cond
                ((> (order t1) (order t2))
                    (adjoin-term t1 (add-terms (rest-terms L1) L2)))
                ((< (order t1) (order t2))
                    (adjoin-term t2 (add-terms L1 (rest-terms L2))))
                (else
                    (adjoin-term
                        (make-term
                            (order t1)
                            (add (coeff t1) (coeff t2)))
                        (add-terms (rest-terms L1) (rest-terms L2)))))))))

(define (mul-term-by-all-terms t1 L)
    (if (empty-termlist? L)
        (the-empty-termlist)
        (let ((t2 (first-term L)))
            (adjoin-term
                (make-term
                    (+ (order t1) (order t2))
                    (mul (coeff t1) (coeff t2)))
                (mul-term-by-all-terms t1 (rest-terms L))))))

(define (mul-terms L1 L2)
    (if (empty-termlist? L1)
        (the-empty-termlist)
        (add-terms
            (mul-term-by-all-terms (first-term L1) L2)
            (mul-terms (rest-terms L1) L2))))

(define (install-term-package)
    (define (tag-op op)
        (lambda args (attach-tag 'termlist (apply op args))))

    (define type-tags '(termlist termlist))
    (put 'add type-tags (tag-op add-terms))
    (put 'mul type-tags (tag-op mul-terms))

    'term-package-installed)

(install-term-package)

;; tests
#|
(define tlist1 (adjoin-term (make-term 100 1) (adjoin-term (make-term 2 2) (adjoin-term (make-term 0 1) (the-empty-termlist)))))
(define tlist2 (adjoin-term (make-term 101 1) (adjoin-term (make-term 2 2) (adjoin-term (make-term 0 -1) (the-empty-termlist)))))
(add-terms tlist1 tlist2)

(define tlist3 (adjoin-term (make-term 1 1) (adjoin-term (make-term 0 1) (the-empty-termlist))))
(define tlist4 (adjoin-term (make-term 1 1) (adjoin-term (make-term 0 2) (the-empty-termlist))))
(mul-terms tlist3 tlist4)

(add (attach-tag 'termlist tlist3) (attach-tag 'termlist tlist4))
(mul (attach-tag 'termlist tlist3) (attach-tag 'termlist tlist4))
;|#
