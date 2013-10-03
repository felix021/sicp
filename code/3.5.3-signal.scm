(include "3.5.2.scm")

(define (integral integrand initial-value dt)
    (define int
        (cons-stream
            initial-value
            (add-streams (scale-stream integrand dt) int)))
    int)
