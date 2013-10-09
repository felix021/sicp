(include "3.5.2.scm")

#|
(define int
    (cons-stream initial-value
        (add-streams
            (scale-stream integrand dt)
            int)))
|#

#|
(define (solve f y0 dt)
    (define y (integral dy y0 dt))
    (define dy (stream-map f y)))
|#

(define (integral delayed-integrand initial-value dt)
    (define int
        (cons-stream
            initial-value
            (let ((integrand (force delayed-integrand)))
                (add-streams (scale-stream integrand dt) int))))
    int)

(define (solve f y0 dt)
    (define y (integral (delay dy) y0 dt))
    (define dy (stream-map f y))
    y)

;(display (stream-ref (solve (lambda (y) y) 1 0.001) 1000))
