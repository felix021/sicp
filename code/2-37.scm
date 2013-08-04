#lang racket

(require "felix.scm")

(define (dot-product v w)
    (accumulate + 0 (map * v w)))

(dot-product '(1 2 3) '(4 5 6))

(define (matrix-*-vector m v)
    (map (lambda (w) (dot-product v w)) m))

(matrix-*-vector '((1 2 3) (4 5 6)) '(7 8 9))

;this is just (zip ...)
(define (transpose m)
    (if (null? (car m))
        '()
        (cons (map car m) (transpose (map cdr m)))))

(define (accumulate-n op init sequences)
    (if (null? (car sequences))
        '()
        (cons
            (accumulate op init (map car sequences))
            (accumulate-n op init (map cdr sequences)))))

(define (transpose1 m)
    (accumulate-n cons '() m))

(transpose1 '((1 2 3) (4 5 6)))

(define (matrix-*-matrix m n)
    (let ((n-t (transpose n)))
        (map 
            (lambda (v)
                (map (lambda (w) (dot-product v w)) n-t))
            m)))

(matrix-*-matrix '((1 2 3) (4 5 6)) '((1 2) (3 4) (5 6)))

