#lang racket

(define (inc a) (+ a 1))
(define (dec a) (- a 1))

(define (add a b)
    (if (= a 0)
        b
        (inc (add (dec a) b))))

;; (add 4 5) => (inc (add (dec 4) 5))
;; (inc (add 3 5))
;; (inc (inc (add 2 5)))
;; (inc (inc (inc (add 1 6))))
;; (inc (inc (inc (inc (add 0 5)))))
;; (inc (inc (inc (inc 5))))
;; (inc (inc (inc 6)))
;; (inc (inc 7))
;; (inc 8)
;; 9

(define (add1 a b)
    (if (= a 0)
        b
        (add1 (dec a) (inc b))))
;; (add 4 5) => (add (dec 4) (inc 5))
;; (add 3 6) => (add (dec 3) (inc 6))
;; (add 2 7) => (add (dec 2) (inc 7))
;; (add 1 8) => (add (dec 1) (inc 8))
;; (add 0 9) => (add (dec 0) (inc 9))
;; 9
