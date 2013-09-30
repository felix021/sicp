(include "3.5.2.scm")

; 1
; 1 + 2
; 1 + 2 + 3
; 1 + 2 + 3 + 4
;
;               1
; 1             2
; 1 + 2         3
; 1 + 2 + 3     4

(define (partial-sums-slow stream)
    (cons-stream
        (stream-car stream)
        (add-streams
            (partial-sums-slow stream)
            (stream-cdr stream))))

;; a better solution according to Syaoming @ http://sicp.readthedocs.org/en/latest/chp3/55.html
(define (partial-sums stream)
    (define self
        (cons-stream
            (stream-car stream)
            (add-streams
                self
                (stream-cdr stream))))
    self)

;(define xxx (partial-sums integers))

;(display-line (stream-head xxx 10))
