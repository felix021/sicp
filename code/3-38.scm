(define balance 0)

(define (init) (set! balance 100))
(define (Peter) (set! balance (+ balance 10)))
(define (Paul) (set! balance (- balance 20)))
(define (Mary) (set! balance (- balance (/ balance 2))))
(define (result) (display balance) (newline))

; a) 35, 40, 45, 50
; 1
(init)
(Peter) (Paul) (Mary)
(result) ;45

; 2
(init)
(Peter) (Mary) (Paul)
(result) ;35

; 3
(init)
(Paul) (Peter) (Mary)
(result) ;45

; 4
(init)
(Paul) (Mary) (Peter)
(result) ;50

; 5
(init)
(Mary) (Peter) (Paul)
(result) ;40

; 6
(init)
(Mary) (Paul) (Peter)
(result) ;40

; b) example
;     +-------- [$100] -------+
;     |                       |
;     v                       v
;   Peter                    Paul
; Access: $100             
; New: 100+10=110          Access: $100
; Set: balance=110         New: 100-20=80 
;                          Set: balance=80
