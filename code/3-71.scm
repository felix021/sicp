(include "3-70.scm")

(define (weight-R pair)
    (apply + (map (lambda (x) (* x x x)) pair)))

(define p (weighted-pairs weight-R integers integers))

#|
(define (find-next stream weight)
    (let ((w (weight-R (stream-car stream))))
        (if (= weight w)
            (cons-stream
                w
                (find-next (stream-cdr stream) w))
            (find-next (stream-cdr stream) w))))

(define Ramanujan (find-next p 0))
|#

(define (find-next stream)
    (let ((s0 (stream-ref stream 0))
          (s1 (stream-ref stream 1)))
        (if (= (weight-R s0) (weight-R s1))
            (cons-stream
                (list (weight-R s0) s0 s1)
                (find-next 
                    (stream-cdr (stream-cdr stream))))
            (find-next (stream-cdr stream)))))

(define Ramanujan (find-next p))

(display-line (stream-head Ramanujan 10))

