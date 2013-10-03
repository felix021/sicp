(include "3.5.3-signal.scm")

(define (RC R C dt)
    (lambda (i v0)
        (add-streams
            (integral (scale-stream i (/ 1 C)) v0 dt)
            (scale-stream i R))))
