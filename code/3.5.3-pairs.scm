(include "3.5.2.scm")

(define (interleave s1 s2)
    (if (stream-null? s1)
        s2
        (cons-stream
            (stream-car s1)
            (interleave s2 (stream-cdr s1)))))
                        
(define (pairs s t)
    (cons-stream
        (list (stream-car s) (stream-car t))
        (interleave
            (stream-map (lambda (x) (list (stream-car s) x)) (stream-cdr t))
            (pairs (stream-cdr s) (stream-cdr t)))))

(define nature-number-stream (integers-starting-from 1))

(define int-pairs
    (pairs nature-number-stream nature-number-stream))

(define prime-sum-pairs
    (stream-filter
        (lambda (pair)
            (prime? (+ (car pair) (cadr pair))))
        int-pairs))

(define (interleave-streams . streams)
    (if (= (length streams) 2)
        (apply interleave streams)
        (interleave
            (car streams)
            (apply interleave-streams (cdr streams)))))

;(display (stream-head prime-sum-pairs 10))
