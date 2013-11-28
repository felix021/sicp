(define count 0)

(define (id x)
    (set! count (+ count 1))
    x)

(define w (id (id 10)))
; 此时 w 对应的值是 (list 'thunk '(id 10) env), 而count = 1

;input
count

;value
1

;input
w

;value
10

;input
count

;value
2
