(include "3.5.3-pairs.scm")

(define (pair-all s t)
    (cons-stream
        (list (stream-car s) (stream-car t))
        (interleave-streams
            (stream-map
                (lambda (x) (list (stream-car s) x))
                (stream-cdr t))
            (stream-map
                (lambda (x) (list (stream-car t) x))
                (stream-cdr s))
            (pair-all (stream-cdr s) (stream-cdr t)))))

(display (stream-head (pair-all nature-number-stream nature-number-stream) 20))
