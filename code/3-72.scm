(include "3-70.scm")

(define (weight-square pair)
    (apply + (map (lambda (x) (* x x)) pair)))

(define p (weighted-pairs weight-square integers integers))

(define (find-next stream)
    (let ((s0 (stream-ref stream 0))
          (s1 (stream-ref stream 1))
          (s2 (stream-ref stream 2)))
        (if (= (weight-square s0) (weight-square s1) (weight-square s2))
            (cons-stream
                (list (weight-square s0) s0 s1 s2)
                (find-next 
                    (stream-cdr (stream-cdr (stream-cdr stream)))))
            (find-next (stream-cdr stream)))))

(display-line (stream-head (find-next p) 10))
