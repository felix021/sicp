#lang racket

(define (point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (segment p1 p2) (list p1 p2))
(define (segment-start s) (car s))
(define (segment-end s) (cadr s))

(define (segment-length s)
    (let ((x1 (x-point (segment-start s)))
          (y1 (y-point (segment-start s)))
          (x2 (x-point (segment-end s)))
          (y2 (y-point (segment-end s)))
          (square (lambda (x) (* x x))))
    (sqrt
        (+ (square (- x1 x2))
           (square (- y1 y2))))))

(define (make-rect1 s1 s2)

    (define (dispatch x)
        (cond
            ((equal? x "length") (segment-length s1))
            ((equal? x "width") (segment-length s2))
            (else (error "unknown"))))

    dispatch)

(define (make-rect2 p1 p2 p3)
    (define s1 (segment p1 p2))
    (define s2 (segment p1 p3))
    (define (dispatch x)
        (cond
            ((equal? x "length") (segment-length s1))
            ((equal? x "width") (segment-length s2))
            (else (error "unknown"))))

    dispatch)

(define (area rect)
    (* (rect "length") (rect "width")))

(define (perimeter rect)
    (* 2 (+ (rect "length") (rect "width"))))

(define p1 (point 0 0))
(define p2 (point 0 3))
(define p3 (point 2 0))
(define p4 (point 2 3))
(define s1 (segment p1 p2))
(define s2 (segment p1 p3))
(define s3 (segment p4 p2))
(define s4 (segment p4 p3))

(define rect1 (make-rect1 s1 s2))
(rect1 "length")
(rect1 "width")

(area rect1)
(perimeter rect1)

(define rect2 (make-rect2 p1 p2 p3))
(rect2 "length")
(rect2 "width")

(area rect2)
(perimeter rect2)
