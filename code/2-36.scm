#lang racket

(require "felix.scm")

(define (accumulate-n op init sequences) 
    (map (lambda (seq) (accumulate + init seq)) (zip sequences)))

(accumulate-n + 0 '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))

(define (accumulate-nx op init sequences)
    (if (null? (car sequences))
        '()
        (cons
            (accumulate op init (map car sequences))
            (accumulate-nx op init (map cdr sequences)))))

(accumulate-nx + 0 '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))
