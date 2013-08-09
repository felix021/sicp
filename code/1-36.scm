#lang racket

(require "fixed-point.scm")

(fixed-point
    (lambda (x) (+ 1 (/ 1 x)))
    1.0)

(fixed-point
    (lambda (x) (/ (log 1000) (log x)))
    2.0)

