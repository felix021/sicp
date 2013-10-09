(include "3.5.5.scm")

; action-stream should consists of symbol 'generate or number which means to reset random-init
(define (rand-stream random-init action-stream)
    (define rand
        (cons-stream
            random-init
            (cond
                ((stream-null? action-stream) the-empty-stream)
                ((eq? 'generate (stream-car action-stream))
                    (stream-map rand-update rand))
                (else
                    (rand-stream (stream-car action-stream) (stream-cdr action-stream))))))
    rand)

