#lang racket

(require "felix.scm")

(define empty-board '())

(define (safe? k positions)
    ;(display k) (display ": ") (display positions) (newline)
    (define p (car positions))

    (define (conflict-with? q i)
        (or 
            (= p q)
            (= p (+ q i))
            (= p (- q i))))

    (define (is-safe? others i) 
        (cond 
            ((null? others) #t)
            ((conflict-with? (car others) i) #f)
            (else (is-safe?  (cdr others) (inc i)))))

    (is-safe? (cdr positions) 1))

(define (adjoin-position new-row k rest-of-queens)
    (cons new-row rest-of-queens))

(define (queens board-size)
    (define (queen-cols k)
        (if (= k 0)
            (list empty-board)
            (filter
                (lambda (positions) (safe? k positions))
                (flatmap
                    (lambda (rest-of-queens)
                        (map 
                            (lambda (new-row)
                                (adjoin-position new-row k rest-of-queens))
                            (range 1 board-size 1)))
                    (queen-cols (dec k))))))
    (queen-cols board-size))

(let ((ans (queens 11)))
    (display (length ans))
    (newline)
    ;(for-each (lambda (x) (begin (display x) (newline) #t)) ans)
)
