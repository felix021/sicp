(include "3.5.2.scm")

#|
(define rand
    (let ((x random-init))
        (lambda ()
            (set! x (rand-update x))
            x)))
|#

(define random-init 4)

; glibc's choice according to `Linear_congruential_generator`@wikipedia
(define rand-update
    (let ((a 1103515245)
          (c 12345)
          (m 2147483648))
        (lambda (x)
            (remainder (+ (* a x) c) m))))

(define random-numbers
    (cons-stream random-init
        (stream-map rand-update random-numbers)))

(define (map-successive-pairs f s)
    (cons-stream
        (f (stream-car s) (stream-car (stream-cdr s)))
        (map-successive-pairs f (stream-cdr (stream-cdr s)))))

(define cesaro-stream
    (map-successive-pairs (lambda (r1 r2) (= (gcd r1 r2) 1)) random-numbers))

(define (monte-carlo experiment-stream passed failed)
    (define (next passed failed)
        (cons-stream
            (/ passed (+ passed failed))
            (monte-carlo
                (stream-cdr experiment-stream) passed failed)))
    (if (stream-car experiment-stream)
        (next (+ passed 1) failed)
        (next passed (+ failed 1))))

(define pi
    (stream-map (lambda (p) (sqrt (/ 6 p))) (monte-carlo cesaro-stream 0 0)))

; the result is not ideal, actually...
;(display (stream-ref pi 10000))
