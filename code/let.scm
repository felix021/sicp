#lang racket

(define x 5)

(+ (let ((x 3)) (+ x (* x 10))) x)
