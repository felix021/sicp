(load "3.4-parallel.scm")

(define x 10)

;(define s (make-serializer)) ;; 101 or 121
(define s (make-serializer-slow)) ;; this helps to produce the answer x=100

(parallel-execute
    (lambda () (set! x ((s (lambda () (* x x))))))
    (s (lambda () (set! x (+ x 1)))))

(display x)

; the last form equals to
#|
(define (square x) (* x x))
(parallel-execute
    (lambda () (set! x (square x)))
    (s (lambda () (set! x (+ x 1)))))
|#
; A: [get x] [set! x]
; B: [get x, set! x]
;
; 1) 101
;   A.get x -> 10
;   A.set 100 -> x
;   B.get x -> 100, B.set 101 -> x
;
; 2) 121
;   B.get x -> 10, B.set 11 -> x
;   A.get x -> 11
;   A.set 121 -> x
;
; 3) 100
;   A.get x -> 10
;   B.get x -> 10, B.set 11 -> x
;   A.set x -> 100
;
