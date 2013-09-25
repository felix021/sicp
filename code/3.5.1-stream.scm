(include "gfelix.scm")

;(use-syntax (ice-9 syncase))

(define-syntax cons-stream 
    (syntax-rules ()
        [(cons-stream x y) (cons x (delay y))]))

;(define (cons-stream a b) (cons a (delay b))) ;won't work

(define (stream-car stream) (car stream))

(define (stream-cdr stream) (force (cdr stream)))

(define stream-null? null?)

(define the-empty-stream '())

(define (stream-ref s n)
    (if (= n 0)
        (stream-car s)
        (stream-ref (stream-cdr s) (- n 1))))

#| ;single arg version
(define (stream-map proc s)
    (if (stream-null? s)
        the-empty-stream
        (cons-stream
            (proc (stream-car s))
            (stream-map proc (stream-cdr s)))))
|#

(define (stream-map proc . streams)
    (if (stream-null? (car streams))
        the-empty-stream
        (cons-stream
            (apply proc (map stream-car streams))
            (apply stream-map (cons proc (map stream-cdr streams))))))

(define (stream-for-each proc s)
    (if (stream-null? s)
        'done
        (begin
            (proc (stream-car s))
            (stream-for-each proc (stream-cdr s)))))

(define (stream-filter pred? s)
    (cond
        ((stream-null? s) the-empty-stream)
        ((pred? (stream-car s))
            (cons-stream
                (stream-car s)
                (stream-filter pred? (stream-cdr s))))
        (else (stream-filter pred? (stream-cdr s)))))

(define (display-line x)
    (display x)
    (newline))

(define (display-stream s)
    (stream-for-each display-line s))

(define (stream-enumerate-interval low high)
    (if (> low high)
        the-empty-stream
        (cons-stream
            low
            (stream-enumerate-interval (+ low 1) high))))

(define (stream-head stream n)
    (cond
        ((stream-null? stream) '())
        ((= n 0) '())
        (else
            (cons
                (stream-car stream)
                (stream-head (stream-cdr stream) (- n 1))))))

#|

(display-stream (stream-enumerate-interval 1 10))

(display
    (stream-car
        (stream-cdr
            (stream-filter prime?
                (stream-enumerate-interval 10000 1000000)))))

;|#

