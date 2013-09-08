
(define (test-and-set! cell)
    (if (car cell)
        true
        (begin
            (set-car! cell true)
            false)))

;   A                       B
;   (car cell)->false   
;                           (car cell) -> false
;   (set-car! cell true)
;       [cell: '(true)]     
;                           (set-car! cell true)
;                                   [cell: '(true)]
;   false                   
;                           false
