#lang racket

(provide
    make-interval
    lower-bound
    upper-bound
    add-interval
    mul-interval
    div-interval
    sub-interval)

(define (make-interval a b) (cons a b))
;; 2-07
(define (lower-bound x) (car x))
(define (upper-bound x) (cdr x))

(define (add-interval x y)
    (make-interval
        (+ (lower-bound x) (lower-bound y))
        (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
    (let* ((lx (lower-bound x))
           (ux (upper-bound x))
           (ly (lower-bound y))
           (uy (upper-bound y))
           (p1 (* lx ly))
           (p2 (* lx uy))
           (p3 (* ux ly))
           (p4 (* ux uy)))
        (make-interval
            (min p1 p2 p3 p4)
            (max p1 p2 p3 p4))))

; 2-10
(define (div-interval x y)
    (let ((ly (lower-bound y)) (uy (upper-bound y)))
        (if (<= (* ly uy) 0)
            (error "illegal to divide interval over 0: " y)
            (mul-interval
                x
                (make-interval (/ 1.0 uy) (/ 1.0 ly))))))

; 2-08
(define (sub-interval x y)
    (add-interval
        x
        (make-interval
            (- (upper-bound y))
            (- (lower-bound y)))))

;; tests
#|
(define itv1 (make-interval 10 15))
(define itv2 (make-interval 4 5))
(define itv3 (make-interval -2 5))

(add-interval itv1 itv2)
(sub-interval itv1 itv2)
(sub-interval itv1 itv3)
(mul-interval itv1 itv2)
(mul-interval itv1 itv3)
(div-interval itv1 itv2)
;|#
