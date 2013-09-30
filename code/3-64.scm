(include "3.5.3.scm")

(define (stream-limit s tolerance)
    (let ((s0 (stream-ref s 0))
          (s1 (stream-ref s 1)))
        (if (< (abs (- s1 s0)) tolerance)
            s1
            (stream-limit (stream-cdr s) tolerance))))


(define (sqrt x tolerance)
    (stream-limit (sqrt-stream x) tolerance))

(display-line (sqrt 2 0.00001))
