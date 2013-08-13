#lang racket

(require "3-03.scm")

(define (make-joint acc acc-pwd new-pwd)
    (lambda (pwd m)
        (if (eq? pwd new-pwd)
            (acc acc-pwd m)
            (error "bad password -- MAKE-JOINT"))))

(define acc (make-account 100 'ooxx))
((acc 'ooxx 'deposit) 10)

(define acc-joint (make-joint acc 'ooxx 'xxoo))
((acc-joint 'xxoo 'deposit) 10)
