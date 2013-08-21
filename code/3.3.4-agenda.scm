(define (make-agenda) '(0))

(define (empty-agenda? agenda) (null? (cdr agenda)))

(define (first-agenda-item agenda) (cadr agenda))

(define (remove-first-agenda-item! agenda)
    (set-cdr! agenda (cddr agenda)))

(define (add-to-agenda! time action agenda)
    (set-cdr! agenda (cons (cons time action) (cdr agenda))))

(define (current-time agenda) (car agenda))

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

(define (probe name wire)
    (add-action! wire
        (lambda ()
            (newline)

