(include "3.5.4.scm")

(define (RLC R L C dt)
    (lambda (vC0 iL0)
        (define vC (integral (delay dvC) vC0 dt))
        (define iL (integral (delay diL) iL0 dt))
        (define dvC (scale-stream iL (- (/ 1 C))))
        (define diL (add-streams (scale-stream vC (/ 1 L)) (scale-stream iL (- (/ R L)))))
        (stream-map cons vC iL)))

(define xRLC ((RLC 1 1 0.2 0.1) 10 0))

(display  (stream-head xRLC 10))
