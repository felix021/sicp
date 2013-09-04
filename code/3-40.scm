(load "3.4-parallel.scm")

(define x 10)

(define s (make-serializer))
(define ss (make-serializer-slow))

(parallel-execute
    (lambda () (set! x (* x x)))
    (lambda () (set! x (* x x x))))

;(display x)

; equals to
#|
(set! x 10)

(parallel-execute
    (lambda ()
        (let ((a x))
            ;possible intersection point
            (let ((b x))
                ;possible intersection point
                (set! x (* a b)))))
    (lambda ()
        (let ((a x))
            ;possible intersection point
            (let ((b x))
                ;possible intersection point
                (let ((c x))
                    ;possible intersection point
                    (set! x (* a b c)))))))
(display x)
; 100
; 1,000
; 10,000
; 100,000
; 1,000,000
;|#

(set! x 10)

(parallel-execute
    (s (lambda () (set! x (* x x x))))
    (s (lambda () (set! x (* x x)))))

(display x)

; only 1,000,000
