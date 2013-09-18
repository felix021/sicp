;; this version is for Guile

;; this imports take/drop ...
(use-modules (srfi srfi-1))

(define (reduce proc z)
    (define (iter answer remain)
        (if (null? remain)
            answer
            (iter (proc answer (car remain)) (cdr remain))))
    (iter (car z) (cdr z)))

(define (square x) (* x x))

(define (id x) x)

(define (inc x) (+ x 1))
(define (dec x) (- x 1))

(define (avg . z) (avg-list z))

(define (avg-list z)
    (/ (reduce + z) (length z)))

(define (diff x y) (abs (- x y)))

(define (fixed-point f x)
    (define tolerance 0.000001)
    (define (close-enough? x y) (< (diff x y) tolerance))
    (define (try t)
        (define v (f t))
        (if (close-enough? t v)
            t
            (try v)))
    (try x))

(define (deriv g dx)
    (lambda (x)
        (/ (- (g (+ x dx)) (g x)) dx)))

(define (newton-transform g dx)
    (lambda (x) (- x (/ (g x) ((deriv g dx) x)))))
    
(define (newton-method g guess dx)
    (fixed-point (newton-transform g dx) guess))

(define (accumulate op init lst)
    (if (null? lst)
        init
        (op (car lst)
            (accumulate op init (cdr lst)))))

(define (zip sequences)
    (if (null? (car sequences))
        '()
        (cons (map car sequences) (zip (map cdr sequences)))))

(define (append-one lst item) (append lst (list item)))

(define (range start stop step)
    (if (> start stop)
        '()
        (cons start (range (+ start step) stop step))))

(define (flatmap p s)
    (accumulate append '() (map p s)))

(define (fold-right op init seq)
    (if (null? seq)
        init
        (op (car seq)
            (fold-right op init (cdr seq)))))

(define (fold-left op init seq)
    (define (iter ans remain)
        (if (null? remain)
            ans
            (iter (op ans (car remain)) (cdr remain))))
    (iter init seq))
        
(define (enumerate-tree tree)
    (cond
        ((null? tree) '())
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree)) (enumerate-tree (cdr tree))))))

(define (list-range lst start end)
    (drop (take lst end) start))

(define (monte-carlo trials experiment)
    (define (iter trials-remaining trials-passed)
        (cond
            ((= trials-remaining 0) (/ trials-passed trials))
            ((experiment)
                (iter (- trials-remaining 1) (+ trials-passed 1)))
            (else
                (iter (- trials-remaining 1) trials-passed))))
    (iter trials 0))

(define (random-in-range low high)
    (let ((range (- high low)))
        (+ low (random range))))

(define (prime? x)
    (define m (ceiling (sqrt x)))
    (define (iter t)
        (cond ((> t m) #t)
              ((= (remainder x t) 0) #f)
              (else (iter (+ t 1) ))))
    (if (= x 2)
        #t
        (iter 2)))
