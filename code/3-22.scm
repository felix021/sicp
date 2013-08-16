
(define (make-queue)
    (let ((front-ptr '())
          (rear-ptr '()))

        (define (insert! item)
            (let ((new-pair (cons item '())))
                (if (null? front-ptr)
                    (set! front-ptr new-pair)
                    (set! rear-ptr new-pair))
                (set! rear-ptr new-pair)))

        (define (delete!)
            (if (null? front-ptr)
                (error "DELETE called with an empty queue")
                (set! front-ptr (cdr front-ptr))))

        (define (print-queue)
            (display "Queue: ")
            (display front-ptr)
            (newline))

         (define (dispatch op)
            (cond
                ((eq? op 'empty?) (null? front-ptr))
                ((eq? op 'front-ptr) front-ptr)
                ((eq? op 'rear-ptr) rear-ptr)
                ((eq? op 'front) 
                    (if (null? front-ptr)
                        (error "FRONT called with an empty queue")
                        (car front-ptr)))
                ((eq? op 'insert!) insert!)
                ((eq? op 'delete!) (delete!))
                ((eq? op 'print) (print-queue))
                (else (error "unknown operation" op))))

        dispatch))

;; tests
;#|
(define q (make-queue))
((q 'insert!) 1)
((q 'insert!) 2)
((q 'insert!) 3)
(q 'print)
#|
(q 'delete!)
((q 'insert!) 4)
(q 'delete!)
((q 'insert!) 5)
(q 'print)
(display (q 'empty?)) (newline)
(q 'delete!)
(q 'print)
(q 'delete!)
(q 'print)
(q 'delete!)
(display (q 'empty?)) (newline)
(q 'print)
;|#
