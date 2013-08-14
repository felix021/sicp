(load "3-common.scm")

(define (make-cycle x)
    (set-cdr! (last-pair x) x)
    x)

(define z (make-cycle '(a b c)))

(last-pair z) ;; will loop forever...
