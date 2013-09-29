(include "3.5.2.scm")

(include "3-59.scm")

; s1 = (a + b) => a = (car s1), b = (cdr s1)
; s2 = (x + y) => x = (car s2), y = (cdr s2)
; s1 * s2 = a*x + b*x + (a+b)*y

(define (mul-series s1 s2)
    (cons-stream (* (stream-car s1) (stream-car s2))
        (add-streams
            (scale-stream (stream-cdr s1) (stream-car s2)) 
            (mul-series s1 (stream-cdr s2)))))

;; test codes, commented out for 3-61
#|
(display-line (stream-head 
    (mul-series sine-series sine-series) 10))

(display-line (stream-head 
    (mul-series cosine-series cosine-series) 10))

(define (x-stream x)
    (define self
        (cons-stream
            1
            (scale-stream self x)))
    self)

(display-line (stream-head (x-stream 2) 10))

(define xs (x-stream 2))

(define one (add-streams
                (stream-map * xs (mul-series sine-series sine-series))
                (stream-map * xs (mul-series cosine-series cosine-series))))

(display-line (stream-head one 10))

(include "gfelix.scm")

(display-line (fold-right + 0 (stream-head one 10)))
;|#
