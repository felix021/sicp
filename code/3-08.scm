#lang racket

(define f
    (let ((z 0))
        (lambda (x)
            (let ((tmp z))
                (set! z x)
                tmp))))

(+ (f 0) (f 1)) ;;0
;(+ (f 1) (f 0)) ;;1
