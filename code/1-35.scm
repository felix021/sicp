#lang racket

(require "fixed-point.scm")

;; x = 1 + 1/x
;; x^2 = x + 1
;; (x - 1/4)^2 = 5/4
;; x = (1 [+/-] sqrt(5)) / 2


(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)
