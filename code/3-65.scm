(include "3.5.3.scm")

(define (ln2-summands n)
    (cons-stream
        (/ 1.0 n)
        (stream-map - (ln2-summands (+ n 1)))))

(define ln2-stream
    (partial-sums (ln2-summands 1)))

(display-line (stream-head ln2-stream 10))

(define ln2-stream-faster (euler-transform ln2-stream))

(display-line (stream-head ln2-stream-faster 10))

(define ln2-stream-fastest (accelerated-sequence euler-transform ln2-stream))

(display-line (stream-head ln2-stream-fastest 10))
