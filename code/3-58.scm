(include "3.5.2.scm")

(define (expand num den radix)
    (cons-stream
        (quotient (* num radix) den)
        (expand (remainder (* num radix) den) den radix)))

(display-line (stream-head (expand 1 7 10) 10))
; {[1*10/7], (expand [1*10%7] 7 10)} = {1, (expand 3 7 10)}
; {[3*10/7], (expand [3*10%7] 7 10)} = {4, (expand 2 7 10)}
; {[2*10/7], (expand [2*10%7] 7 10)} = {2, (expand 6 7 10)}
; ...

(display-line (stream-head (expand 3 8 10) 10))
