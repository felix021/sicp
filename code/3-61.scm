(include "3-60.scm")

(define (inverse-series s)
    (let ((minus-Sr (scale-stream (stream-cdr s) -1)))
        (define X
            (cons-stream
                1
                (mul-series minus-Sr X)))
        X))

;; test codes, commented out for 3-62
#|
(define icosine-series (inverse-series cosine-series))
(display-line (stream-head cosine-series 10))
(display-line (stream-head icosine-series 10))

(include "gfelix.scm")

(display-line
    (exact->inexact
        (fold-right + 0
            (stream-head (mul-series cosine-series icosine-series) 5))))
;|#
