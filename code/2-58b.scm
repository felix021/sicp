#lang racket

;(require "felix.scm")

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? x num) (and (number? x) (= x num)))

;(define (make-sum a1 a2) (list '+ a1 a2))

(define (make-sum a1 a2)
    (cond 
        ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))

(define (first-occurence-of x exp)
    (define (iter answer remain)
        (cond
            ((null? remain) -1)
            ((eq? (car remain) x) answer)
            (else (iter (+ answer 1) (cdr remain)))))
    (iter 0 exp))

;(first-occurence-of '+ '(1 2 3 4 5))

(define (is-op-exp? op e)
    (and (pair? e) (>= (first-occurence-of op e) 0)))

(define (op-left op e) 
    (let ((occur (first-occurence-of op e)))
        (if (= occur 1)
            (car e)
            (take e (first-occurence-of op e)))))

(define (op-right op e) 
    (let ((occur (first-occurence-of op e))
          (len (length e)))
        (if (= occur (- len 2))
            (list-ref e (- len 1))
            (drop e (+ 1 (first-occurence-of op e))))))

(define (sum? e) (is-op-exp? '+ e))
(define (addend e) (op-left '+ e))
(define (augend e) (op-right '+ e))

(define (product? e) 
    ;since sum? test precedes product? test in deriv, 
    ;there's no need to do sum? test here again :)
    (is-op-exp? '* e))

(define (multiplier e) (op-left '* e))
(define (multiplicand e) (op-right '* e))

;(define (make-product m1 m2) (list '* m1 m2))

(define (make-product a1 a2)
    (cond
        ((or (=number? a1 0) (=number? a2 0)) 0)
        ((=number? a1 1) a2)
        ((=number? a2 1) a1)
        ((and (number? a1) (number? a2)) (* a1 a2))
        (else (list a1 '* a2))))

(define (deriv exp var)
    (cond 
        ((number? exp) 0)
        ((variable? exp) (if (eq? exp var) 1 0))
        ((sum? exp)
            (let ((u (addend exp))
                  (v (augend exp)))
                (make-sum
                    (deriv u var)
                    (deriv v var))))
        ((product? exp)
            (let ((u (multiplier exp))
                  (v (multiplicand exp)))
                (make-sum
                    (make-product u (deriv v var))
                    (make-product v (deriv u var)))))
        (else (error "unkown type of expression"))))

(deriv '(x + 3) 'x)

(deriv '(x + 3 + x * 2) 'x)

(deriv '(x * y + x * 3) 'x)

(deriv '(x * y * (x + 3)) 'x)
