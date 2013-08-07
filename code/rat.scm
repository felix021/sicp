#lang racket

(define (pair x y)
    (lambda (i) (if (= i 0) x y)))

(define (gcd a b) (if (= b 0) a (gcd b (remainder a b))))

(define (make-rat x y)
    (define g (gcd x y))
    (let ((x (/ x g))
          (y (/ y g)))
        (if (< y 0)
            (pair (- x) (- y))
            (pair x y))))

(define (numer x) (x 0))

(define (denom x) (x 1))

(define (add-rat x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (denom x) (numer y)))
              (* (denom x) (denom y))))

(define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (denom x) (numer y)))
              (* (denom x) (denom y))))

(define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y))))

(define (div-rat x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x (numer y)))))

(define (equal-rat? x y)
    (= (* (numer x) (denom y))
       (* (denom x) (numer y))))

(define (print-rat x) (display (numer x)) (display "/") (display (denom x)) (newline))

#|
(print-rat (make-rat 3 4))
(print-rat (make-rat -3 4))
(print-rat (make-rat 3 -4))
(print-rat (make-rat -3 -4))

(print-rat 
    (mul-rat (make-rat 3 4)
             (make-rat 4 5)))
|#
