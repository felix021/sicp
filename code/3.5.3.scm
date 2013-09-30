(include "3.5.2.scm")

(define (average a b) (/ (+ a b) 2))

(define (sqrt-improve guess x)
    (average guess (/ x guess)))

(define (sqrt-stream x)
    (define guesses
        (cons-stream
            1.0
            (stream-map
                (lambda (guess)
                    (sqrt-improve guess x))
                guesses)))
    guesses)

;(display-line (stream-head (sqrt-stream 2) 5))

(define (pi-summands n)
    (cons-stream
        (/ 1.0 n)
        (stream-map - (pi-summands (+ n 2)))))

(include "3-55.scm") ; for partial-sums

(define pi-stream
    (scale-stream (partial-sums (pi-summands 1)) 4))

;(display-line (stream-head pi-stream 8))

(define (euler-transform s)
    (let ((s0 (stream-ref s 0))
          (s1 (stream-ref s 1))
          (s2 (stream-ref s 2)))
        (cons-stream
            (- s2 (/ (square (- s2 s1))
                     (+ s0 (* -2 s1) s2)))
            (euler-transform (stream-cdr s)))))

;(display-line (stream-head (euler-transform pi-stream) 8))

(define (make-tableau transform s)
    (cons-stream s (make-tableau transform
                                 (transform s))))

(define (accelerated-sequence transform s)
    (stream-map stream-car
        (make-tableau transform s)))

;(display-line (stream-head (accelerated-sequence euler-transform pi-stream) 8))
