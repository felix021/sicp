#lang racket

(require "felix.scm")

(define (make-monitored f)
    (let ((counter 0))
        (lambda (arg)
            (if (eq? arg 'how-many-calls)
                counter
                (begin
                    (set! counter (+ 1 counter))
                    (f arg))))))

(define s (make-monitored sqrt))
(s 100)
(s 'how-many-calls)

(define mf (make-monitored square))

(mf 3)
(mf 4)
(mf 'how-many-calls)
(mf 5)
(mf 'how-many-calls)
