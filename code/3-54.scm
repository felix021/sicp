(include "3.5.2.scm")

(define (mul-streams s1 s2)
    (stream-map * s1 s2))

(define factorials (cons-stream 1 (mul-streams (stream-cdr integers) factorials)))

(display-line (stream-head factorials 10))
