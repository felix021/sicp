
(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))
(define (set-front-ptr! queue item) (set-car! queue item))
(define (set-rear-ptr! queue item) (set-cdr! queue item))
(define (empty-queue? queue) (null? (front-ptr queue)))
(define (make-queue) (cons '() '()))

(define (front-queue queue)
    (if (empty-queue? queue)
        (error "FRONT called with an empty queue" queue)
        (car (front-ptr queue))))

(define (insert-queue! queue item)
    (let ((new-pair (cons item '())))
        (if (empty-queue? queue)
            (set-front-ptr! queue new-pair)
            (set-cdr! (rear-ptr queue) new-pair))
        (set-rear-ptr! queue new-pair)
        queue))

(define (delete-queue! queue)
    (if (empty-queue? queue)
        (error "DELETE called with an empty queue" queue)
        (begin
            (set-front-ptr! queue (cdr (front-ptr queue)))
            queue)))

(define (print-queue queue)
    (display "Queue: ")
    (display (front-ptr queue))
    (newline))

;; tests
#|
(define q (make-queue))
(insert-queue! q 1)
(insert-queue! q 2)
(insert-queue! q 3)
(display (front-ptr q)) (newline)
(delete-queue! q)
(insert-queue! q 4)
(delete-queue! q)
(insert-queue! q 5)
(display (front-ptr q)) (newline)
(display (empty-queue? q)) (newline)
(delete-queue! q)
(delete-queue! q)
(delete-queue! q)
(display (empty-queue? q)) (newline)
|#
