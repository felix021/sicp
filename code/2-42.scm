#lang racket

(require "felix.scm")

;not ok....

(define (queen row col) (cons row col))
(define (row queen) (car queen))
(define (col queen) (cdr queen))

(define (safe? k positions)
    (display k) (display ": ") (display positions) (newline)
    (if (= k 1)
        #t
        (letrec
            ((q (car positions))
             (qsum (+ (row q) (col q)))
             (qdiff (- (row q) (col q)))
             (judge (lambda (lst)
                (cond 
                    ((null? lst) #t)
                    ((or (let ((x (car lst)))
                        (= (row q) (row x))
                        (= (col q) (col x))
                        (= qsum  (+ (row x) (col x)))
                        (= qdiff (- (row x) (col x)))))
                     #f)
                    (else (judge (cdr lst)))))))
            (judge (cdr positions)))))

(define empty-board '())

(define (adjoin-position col row rest-of-queens) 
    (cons (queen row col) rest-of-queens))

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

(queens 4)
;(length (queens 4))
