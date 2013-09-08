; This version of mutex won't since the `test-and-set!` here is not atomic.
; Please refer to the Guile-dependent implemention in 3.4-parallel.scm.

(define true #t)
(define false #f)

; This is not enough.
; Atomicity has to be implemented by some hardware-dependent method.
(define (test-and-set! cell)
    (if (car cell)
        true
        (begin
            (set-car! cell true)
            false)))

(define (clear! cell)
    (set-car! cell false))

(define (make-mutex)
    (let ((cell (list false)))
        (define (the-mutex m)
            (cond
                ((eq? m 'acquire)
                    (if (test-and-set! cell)
                        (the-mutex 'acquire))) ;retry
                ((eq? m 'release) (clear! cell))
                (else (error "unknown operation -- make-mutex" m))))
        the-mutex))

(define (make-serializer)
    (let ((mutex (make-mutex)))
        (lambda (p)
            (define (serialized-p . args)
                (mutex 'acquire)
                (let ((val (apply p args)))
                    (mutex 'release)
                    val))
            serialized-p)))
