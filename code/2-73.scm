#lang racket

;TODO @3.3?
;(define put (lambda (x y z) '()))
;(define get (lambda (x y z) '()))

(require "getput.scm")

(define variable? symbol?)

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

(define (deriv exp var)
    (cond
        ((number? exp) 0)
        ((variable? exp) (if (eq? exp var) 1 0))
        (else
            ((get 'deriv (operator exp)) (operands exp) var))))

;; a) 根据 exp 的操作符取出相应的求导函数，对 exp 的操作数求导
;;    number和variable塞不进去，是因为它们没有对应operator和operands的数据可以提取
;;    如果修改这两个函数的话，实际上也是可以塞进去的，但是看起来会比现在这样更诡异:(
;; 
;; b) 

(define (=number? x num) (and (number? x) (= x num)))

(define (make-sum a1 a2)
    (cond 
        ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))

(define (make-product a1 a2)
    (cond
        ((or (=number? a1 0) (=number? a2 0)) 0)
        ((=number? a1 1) a2)
        ((=number? a2 1) a1)
        ((and (number? a1) (number? a2)) (* a1 a2))
        (else (list '* a1 a2))))

;; sum interface
(define (install-sum-deriv)
    (define (deriv-sum z x)
        (let ((u (car z)) (v (cadr z)))
            (make-sum
                (deriv u x)
                (deriv v x))))
    (put 'deriv '+ deriv-sum)
    'done)
;; mul interface
(define (install-mul-deriv)
    (define (deriv-mul z x)
        (let ((u (car z)) (v (cadr z)))
            (make-sum
                (make-product u (deriv v x))
                (make-product v (deriv u x)))))
    (put 'deriv '* deriv-mul)
    'done)

;; install
(install-sum-deriv)
(install-mul-deriv)

;; tests
(deriv '(+ x 3) 'x)

(deriv '(* x y) 'x)

(deriv '(* (* x y) (+ x 3)) 'x)

;; c) 求幂什么的..真不想写啊...

(define (make-exp a n)
    (cond
        ((=number? n 0) 1)
        ((=number? n 1) a)
        (else (list '** a n))))

(define (install-exp-deriv)
    (define (deriv-exp z x)
        (let ((a (car z)) (n (cadr z)))
            (make-product
                n
                (make-exp
                    a
                    (make-sum n -1)))))
    (put 'deriv '** deriv-exp)
    'done)
(install-exp-deriv)

;; tests
(deriv '(** x 0) 'x)
(deriv '(** x 1) 'x)
(deriv '(+ x (* y (** x 5))) 'x)

;; d) 改掉put:
;;      (put '+ 'deriv deriv-sum)
;;      (put '* 'deriv deriv-mul)
;;      (put '** 'deriv deriv-exp)
