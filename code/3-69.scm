(include "3.5.3-pairs.scm")

(define (triples s t u)
    (let ((s0 (stream-car s))
          (t0 (stream-car t))
          (u0 (stream-car u))
          (s+ (stream-cdr s))
          (t+ (stream-cdr t))
          (u+ (stream-cdr u)))
     (cons-stream
        (list s0 t0 u0)
        (interleave
            (stream-map
                (lambda (tu) (cons s0 tu)) (stream-cdr (pairs t u)))
            (triples s+ t+ u+)))))

;(display (stream-head (triples integers integers integers) 100))

(define (ok? i j k)
  (= (+ (* i i) (* j j)) (* k k)))

(define Pythagoras-triples
    (stream-filter
        (lambda (stu) (apply ok? stu))
        (triples integers integers integers)))

(display (stream-head Pythagoras-triples 4))
