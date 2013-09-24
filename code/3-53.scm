(include "3.5.2.scm")

(define s (cons-stream 1 (add-streams s s)))

(display-line (stream-ref s 1))
(display-line (stream-ref s 2))
(display-line (stream-ref s 3))
(display-line (stream-ref s 4))

; 1, 2, 4, 8, ...
