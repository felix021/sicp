#lang racket

; ignore me ...
; just for testing do syntax

(define (fibo n)
    (do
        (;<var list>
         ;var-name inital-value modification-after-each-iteration
         (i 1 (+ i 1))  
         (a 1 (+ a b))
         (b 0 a))

        (
            ;termination-pred return value
            (= i n) a
        )
        ;<loop body>
        ;(display a) (newline)
    )
)

(display "answer: ")
(fibo 10)
