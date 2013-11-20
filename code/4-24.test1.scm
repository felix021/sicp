(define (loop n)
    (if (> n 0)
        (loop (- n 1))))

(loop 1000000)
(exit)
