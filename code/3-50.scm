
; include: takes effect when compiling
; load:    takes effect when running
(include "3.5.1-stream.scm")

(define (stream-map-multi proc . streams)
    (if (stream-null? (car streams))
        the-empty-stream
        (cons-stream
            (apply proc (map stream-car streams))
            (apply stream-map-multi (cons proc (map stream-cdr streams))))))

(display-stream
    (stream-map-multi
        +
        (stream-enumerate-interval 1 10)
        (stream-enumerate-interval 11 20)
        (stream-enumerate-interval 21 30)))
