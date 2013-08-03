#lang racket

(define (sum-integers a b)
    (if (> a b)
        0
        (+ a (sum-integers (+ a 1) b))))
;(sum-integers 1 100)

(define (sum-cubes a b)
    (if (> a b)
        0
        (+ (* a a a) (sum-cubes (+ a 1) b))))
;(sum-cubes 3 5)

(define (pi-sum a b)
    (if (> a b)
        0
        (+ (/ 1.0 (* a (+ a 2))) (pi-sum (+ a 4) b))))
;(* 8 (pi-sum 1 100000))

(define (common-sum f a next b)
    (if (> a b)
        0
        (+ (f a) (common-sum f (next a) next b))))

(define (identity x) x)

(define (inc-n n)
    (define t (lambda (x) (+ x n)))
    t)

(define (inc x) ((inc-n 1) x))

(define (sum-integers1 a b)
    (common-sum identity a inc b))
;(sum-integers1 1 100)

(define (cube x) (* x x x))
(define (sum-cubes1 a b)
    (common-sum cube a inc b))
;(sum-cubes1 3 5)

(define (pi a b)
    (define (elem a) (/ 1.0 (* a (+ a 2))))
    (* 8 (common-sum elem a (inc-n 4) b)))
;(pi 1 10000)

(define (integral f a b dx)
    (define (f-dx x) (f (+ x (/ dx 2))))
    (* dx (common-sum f-dx a (lambda (x) (+ x dx)) b)))

(integral cube 0 1 0.01)
(integral cube 0 1 0.001)

(define (sum-iter f a next b)
    (define (iter sum x)
        (if (> x b)
            sum
            (iter (+ sum (f x)) (next x))))
    (iter 0 a))

(define (integral-n f a b n)
    (define h (/ (- b a) n 1.0))
    (define (y k) (f (+ a (* k h))))
    (*  (/ h 3.0)
        (+ (y 0) (y n)
            (* 4 (sum-iter y 1 (inc-n 2) n))
            (* 2 (sum-iter y 2 (inc-n 2) (- n 1))))))
(integral-n cube 0 1 100)
(integral-n cube 0 1 1000)

