#lang racket

(require "getput.scm")
(require "apply-generic.scm")

(provid
    add-terms)

(define (the-empty-termlist) '())
(define (empty-termlist? terms) (null? terms))
(define (adjoin-term t terms) (cons t terms))
(define (first-term terms) (car terms))
(define (rest-terms terms) (cdr terms))

(define (make-term order coeff) (cons order coeff))
(define (order term) (car term))
(define (coeff term) (cdr term))

(define (add-terms L1 L2)
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

;; todo
