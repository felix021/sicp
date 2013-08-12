#lang racket

(require "felix.scm")

(define (safe? solution)
    ;(display solution) (newline)
    (let ((p (car solution)))
        (define (conflict? q i)
            (or
                (= p q)
                (= p (+ q i))
                (= p (- q i))))
        (define (check rest i)
            (cond 
                ((null? rest) #t)
                ((conflict? (car rest) i) #f)
                (else (check (cdr rest) (inc i)))))
        (check (cdr solution) 1)))

(define (n-queen n)
    (let ((n-cols (range 1 n 1)))
        (define (queen-cols k)
            (if (= k 0)
                (list '())
                (filter
                    (lambda (solution) (safe? solution))
                    (let ((sub-solutions (queen-cols (dec k))))
                        (flatmap
                            (lambda (new-queen)
                                (map 
                                    (lambda (solution)
                                        (cons new-queen solution))
                                    sub-solutions))
                            n-cols)))))
        (queen-cols n)))

(time (length (n-queen 10)))
(time (length (n-queen 11)))


;; update @ 2013-08-12

(define (n-queen-faster n)
    (define ans '())
    (define (fill-col sol i)
        (if (= i 0)
            (set! ans (cons sol ans))
            (for-each
                (lambda (col)
                    (if (safe? (cons col sol))
                        (fill-col (cons col sol) (- i 1))
                        #t))
                (range 1 n 1))))
    (fill-col '() n)
    ans)

(time (length (n-queen-faster 10)))
(time (length (n-queen-faster 11)))
(time (length (n-queen-faster 12)))
