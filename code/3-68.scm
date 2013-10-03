
(define (pairs s t)
    (interleave
        (stream-map (lambda (x) (list (stream-car s) x)) t)
        (pairs (stream-cdr s) (stream-cdr t))))

; 由于interleave不是一个语法结构，会导致pairs不断递归调用自己，最终stack overflow.
