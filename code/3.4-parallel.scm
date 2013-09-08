
(define (mutex)
    (let ((m (make-mutex)))
        (define (me request)
            (cond
                ((eq? request 'acquire) (lock-mutex m) (display 'acquire-lock) (newline))
                ((eq? request 'release) (display 'release-lock) (newline) (unlock-mutex m))
                (else (error "unknown request -- mutex.me" request))))
        me))

; a possible make-serializer implementation
(define (make-serializer)
    (let ((m (mutex)))
        (lambda (f)
            (lambda (. args)
                (let ((x (m 'acquire))
                      (ret (apply f args))
                      (y (m 'release)))
                    ret)))))

(define (parallel-execute . procs)
    (let ((threads (map call-with-new-thread procs)))
        (for-each join-thread threads)))

(define (make-serializer-slow)
    (lambda (f)
        (let ((m (mutex)))
            (lambda ()
                (let ((x (m 'acquire))
                      (ret (f))
                      (y (m 'release)))
                    (usleep 100000) ;to cause intersection of threads
                    ret)))))

