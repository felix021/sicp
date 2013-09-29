(include "3-61.scm")

(define (div-series s1 s2)
    (let ((c (stream-car s2)))
        (if (= 0 c)
            (error "first item of s2 should not be zero -- DIV-SERIES" c)
            (scale-stream
                (mul-series
                    s1
                    (inverse-series (scale-stream s2 (/ 1 c))))
                (/ 1 c)))))

;; tan = sin/cos
(define tan-series (div-series sine-series cosine-series))


;; test code

(include "gfelix.scm")

(define (x-stream x)
    (define self
        (cons-stream
            1
            (scale-stream self x)))
    self)

(display-line
    (exact->inexact
        (fold-right + 0
            (stream-head (stream-map * tan-series (x-stream 0.8)) 30))))
; output:    1.0296385556333

; tan(0.8) = 1.0296385570503640127463611728204
