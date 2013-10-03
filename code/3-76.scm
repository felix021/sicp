(include "3-74.scm")

(define (smooth stream)
    (stream-map
        (lambda (a b) (/ (+ a b) 2))
        stream
        (stream-cdr stream)))

(define smoothed-sense-data (smooth sense-data))

(define zero-crossings
    (stream-map
        sign-change-detector
        smoothed-sense-data
        (cons-stream 0 smoothed-sense-data)))

(display-line (stream-head zero-crossings 13))
