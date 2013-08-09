#lang racket

(define (fast-expmod a n b)
    (remainder (expt a n) b))

;; 计算 (expt a n) 耗时较长
