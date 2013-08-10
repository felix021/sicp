#lang racket

(define (L2-47a)
  (define (make-frame origin edge1 edge2)
    (list origin edge1 edge2))
  (define (origin-frame frame) (car frame))
  (define (edge1-frame frame) (cadr frame))
  (define (edge2-frame frame) (caddr frame))

  (define t (make-frame 1 2 3))
  (display t) (newline)
  (display (origin-frame t)) (newline)
  (display (edge1-frame t)) (newline)
  (display (edge2-frame t)) (newline)

  'done)
(L2-47a)

(define (L2-47b)
  (define (make-frame origin edge1 edge2)
    (cons origin (cons edge1 edge2)))
  (define (origin-frame frame) (car frame))
  (define (edge1-frame frame) (car (cdr frame)))
  (define (edge2-frame frame) (cddr frame))

  (define t (make-frame 1 2 3))
  (display t) (newline)
  (display (origin-frame t)) (newline)
  (display (edge1-frame t)) (newline)
  (display (edge2-frame t)) (newline)

  'done)
(L2-47b)
