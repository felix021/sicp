(include "3.5.3-pairs.scm")

(define sense-data (list->stream '(1 2 1.5 1 0.5 -0.1 -2 -3 -2 -0.5 0.2 3 4 0 0 0)))

(define (sign-change-detector now last)
    (cond
        ((and (< last 0) (> now 0)) 1)
        ((and (> last 0) (< now 0)) -1)
        (else 0)))

#|
(define (make-zero-crossings input-stream last-value)
    (cons-stream
        (sign-change-detector (stream-car input-stream) last-value)
        (make-zero-crossings
            (stream-cdr input-stream)
            (stream-car input-stream))))

(define zero-crossings (make-zero-crossings sense-data 0))

;(display-line (stream-head zero-crossings 13))
|#

(define zero-crossings
    (stream-map sign-change-detector sense-data
        (cons-stream 0 sense-data)))

;(display-line (stream-head zero-crossings 13))
