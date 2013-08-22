(load "3.3.2-queue.scm")

(define (~ x) (display x) (newline))

(define (make-time-segment time queue)
    (cons time queue))

(define (segment-time s) (car s))
(define (segment-queue s) (cdr s))

(define (make-agenda) '(0))

(define (current-time agenda) (car agenda))
(define (set-current-time! agenda time) (set-car! agenda time))

(define (segments agenda) (cdr agenda))
(define (set-segments! agenda segments) (set-cdr! agenda segments))

(define (first-segment agenda) (car (segments agenda)))
(define (rest-segments agenda) (cdr (segments agenda)))

(define (empty-agenda? agenda) (null? (segments agenda)))

(define (first-agenda-item agenda)
    (if (empty-agenda? agenda)
        (error "Agenda is empty -- FIRST-AGENDA-ITEM")
        (let ((first-seg (first-segment agenda)))
            (set-current-time! agenda (segment-time first-seg))
            (front-queue (segment-queue first-seg)))))

(define (remove-first-agenda-item! agenda)
    (let ((q (segment-queue (first-segment agenda))))
        (delete-queue! q)
        (if (empty-queue? q)
            (set-segments! agenda (rest-segments agenda)))))

(define (add-to-agenda! time action agenda)
    (define (belongs-before? segments)
        (or (null? segments)
            (< time (segment-time (car segments)))))
    (define (make-new-time-segment time action)
        (let ((q (make-queue)))
            (insert-queue! q action)
            (make-time-segment time q)))
    (define (add-to-segments! segments)
        (if (= (segment-time (car segments)) time)
            (insert-queue! (segment-queue (car segments)) action)
            (let ((rest (cdr segments)))
                (if (belongs-before? rest)
                    (set-cdr!
                        segments
                        (cons
                            (make-new-time-segment time action)
                            (cdr segments)))
                    (add-to-segments! rest)))))
    (let ((segments (segments agenda)))
        (if (belongs-before? segments)
            (set-segments!
                agenda
                (cons (make-new-time-segment time action) segments))
            (add-to-segments! segments))))

(define the-agenda (make-agenda))

(define (after-delay delay action)
    (add-to-agenda!
        (+ delay (current-time the-agenda))
        action
        the-agenda))

(define (propagate)
    (if (empty-agenda? the-agenda)
        'done
        (let ((first-item (first-agenda-item the-agenda)))
            (first-item)
            (remove-first-agenda-item! the-agenda)
            (propagate))))

#|
(~ the-agenda)
(add-to-agenda! 3 '_action3-1 the-agenda)
(add-to-agenda! 3 '_action3-2 the-agenda)
(add-to-agenda! 2 '_action2-1 the-agenda)
(add-to-agenda! 4 '_action4-1 the-agenda)
(add-to-agenda! 2 '_action2-2 the-agenda)
(add-to-agenda! 4 '_action4-2 the-agenda)
(add-to-agenda! 5 '_action5-1 the-agenda)
(~ (first-agenda-item the-agenda))
(remove-first-agenda-item! the-agenda)
(~ the-agenda)
(remove-first-agenda-item! the-agenda)
(~ the-agenda)
|#
