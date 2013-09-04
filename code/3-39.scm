(define (make-serializer f)
    (let ((m (mutex)))
        (lambda . args
            (m acquire)
            (apply f args)
            (m release))))

(define x 10)

(define s (make-serializer))

(parallel-execute (lambda () (set! x ((s (lambda () (* x x))))))
                  (s (lambda () (set! x (+ x 1)))))

; equals to
(parallel-execute
    (lambda () (set! x (square x)))
    (s (lambda () (set! x (+ x 1)))))

; todo ...
